<%@ Page Title="Студенческие мероприятия" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Laba5._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Подключение Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Подключение Datepicker CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    
    <main class="container">
        <div class="card mb-4 shadow">
            <div class="card-header bg-primary text-white py-3">
                <h1 class="display-6 mb-0"><i class="bi bi-broadcast-pin me-2"></i>ASMX сервис</h1>
                <p class="lead mb-0 mt-2 text-white-50">Поиск мероприятий с использованием ASMX сервиса</p>
            </div>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label for="datePicker" class="form-label fw-bold">Выберите дату:</label>
                            <div class="input-group date" id="datePickerContainer">
                                <span class="input-group-text bg-primary text-white"><i class="bi bi-calendar-event"></i></span>
                                <input type="text" id="datePicker" class="form-control border-primary" placeholder="дд.мм.гггг" autocomplete="off" />
                                <button type="button" class="btn btn-outline-secondary" id="clearDate">
                                    <i class="bi bi-x-circle"></i>
                                </button>
                            </div>
                            <div class="form-text">Нажмите на поле для выбора даты из календаря</div>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <div class="d-grid gap-2 d-md-flex w-100">
                            <button class="btn btn-primary" type="button" id="btnSearch">
                                <i class="bi bi-search me-1"></i> Найти по дате
                            </button>
                        </div>
                    </div>
                </div>
                
                <div id="loadingIndicator" style="display:none;" class="text-center my-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Загрузка...</span>
                    </div>
                </div>
                
                <div id="results" class="card shadow-sm mb-3" style="display:none;">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <h3 class="card-title mb-0 fs-5">
                            <i class="bi bi-list-columns-reverse me-2"></i>Результаты поиска
                        </h3>
                        <span id="resultCount" class="badge bg-primary fs-6"></span>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="eventsContainer"></div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </main>
    
    <!-- Подключение скриптов для Datepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ru.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            // Инициализация датапикера
            $('#datePickerContainer').datepicker({
                format: 'dd.mm.yyyy',
                language: 'ru',
                autoclose: true,
                todayHighlight: true,
                weekStart: 1,
                orientation: "bottom"
            });
            
            // Очистка поля даты
            $('#clearDate').click(function() {
                $('#datePicker').val('');
            });
            
            // Универсальная функция поиска
            function performSearch() {
                var date = $("#datePicker").val();
                
                if (date) {
                    searchEvents(date);
                } else {
                    alert("Пожалуйста, выберите дату для поиска");
                }
            }
            
            // Привязка к единой кнопке поиска
            $("#btnSearch").click(function () {
                performSearch();
            });
            
            // Привязка события нажатия Enter в поле даты
            $("#datePicker").keypress(function(e) {
                if(e.which == 13) { // Enter key
                    e.preventDefault();
                    performSearch();
                }
            });
            
            // Функция для поиска мероприятий
            function searchEvents(date) {
                $("#loadingIndicator").show();
                $("#results").hide();
                $("#eventsContainer").empty();
                
                // ASMX сервис
                $.ajax({
                    type: "POST",
                    url: "EventsService.asmx/GetEventsByDate",
                    data: JSON.stringify({ date: date }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        displayEvents(response.d);
                    },
                    error: function (error) {
                        handleError(error);
                    },
                    complete: function () {
                        $("#loadingIndicator").hide();
                    }
                });
            }
            
            // Функция для отображения мероприятий
            function displayEvents(events) {
                var container = $("#eventsContainer");
                container.empty();
                $("#results").show();
                
                if (!events || events.length === 0) {
                    container.append('<div class="alert alert-info">Мероприятий на выбранную дату не найдено.</div>');
                    $("#resultCount").text("0");
                    return;
                }
                
                $("#resultCount").text(events.length);
                
                var tableHtml = '<div class="alert alert-success mb-3">Найдено мероприятий: ' + events.length + '</div>';
                tableHtml += '<table class="table table-striped table-hover">';
                tableHtml += '<thead class="table-primary"><tr><th>Название</th><th>Описание</th><th>Дата</th><th>Место</th><th>Организатор</th></tr></thead>';
                tableHtml += '<tbody>';
                
                $.each(events, function (index, event) {
                    var date = new Date(parseInt(event.Date.substr(6)));
                    var formattedDate = ('0' + date.getDate()).slice(-2) + '.' + 
                                        ('0' + (date.getMonth() + 1)).slice(-2) + '.' + 
                                        date.getFullYear();
                    
                    tableHtml += '<tr>';
                    tableHtml += '<td>' + event.Title + '</td>';
                    tableHtml += '<td>' + event.Description + '</td>';
                    tableHtml += '<td>' + formattedDate + '</td>';
                    tableHtml += '<td>' + event.Location + '</td>';
                    tableHtml += '<td>' + event.Organizer + '</td>';
                    tableHtml += '</tr>';
                });
                
                tableHtml += '</tbody></table>';
                container.html(tableHtml);
            }
            
            // Обработка ошибок
            function handleError(error) {
                console.error("Error details:", error);
                $("#results").show();
                
                var errorMessage = "Произошла ошибка при получении данных. ";
                
                // Try to extract more detailed error information
                if (error.responseJSON && error.responseJSON.Message) {
                    errorMessage += error.responseJSON.Message;
                } else if (error.responseText) {
                    try {
                        // Try to parse the response text
                        var errorObj = JSON.parse(error.responseText);
                        if (errorObj.Message) {
                            errorMessage += errorObj.Message;
                        } else if (errorObj.ExceptionMessage) {
                            errorMessage += errorObj.ExceptionMessage;
                        } else {
                            errorMessage += "Проверьте формат даты (дд.мм.гггг).";
                        }
                    } catch (e) {
                        // If can't parse JSON, display the raw response if it's not too long
                        if (error.responseText.length < 100) {
                            errorMessage += error.responseText;
                        } else {
                            errorMessage += "Проверьте формат даты (дд.мм.гггг).";
                        }
                    }
                } else {
                    errorMessage += "Проверьте формат даты (дд.мм.гггг).";
                }
                
                $("#resultCount").text("0");
                $("#eventsContainer").html('<div class="alert alert-danger">' + errorMessage + '</div>');
            }
        });
    </script>
</asp:Content>
