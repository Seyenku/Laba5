<%@ Page Title="WCF Клиент" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestWCFClient.aspx.cs" Inherits="Laba5.TestWCFClient" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Подключение Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Подключение Datepicker CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    
    <main class="container">
        <div class="card mb-4 shadow">
            <div class="card-header bg-primary text-white py-3">
                <h1 class="display-6 mb-0"><i class="bi bi-broadcast-pin me-2"></i>WCF Клиент</h1>
                <p class="lead mb-0 mt-2 text-white-50">Поиск мероприятий с использованием WCF сервиса</p>
            </div>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label for="<%= txtDate.ClientID %>" class="form-label fw-bold">Выберите дату:</label>
                            <div class="input-group date" id="datePickerContainer">
                                <span class="input-group-text bg-primary text-white"><i class="bi bi-calendar-event"></i></span>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control border-primary" placeholder="дд.мм.гггг"></asp:TextBox>
                                <button type="button" class="btn btn-outline-secondary" id="clearDate">
                                    <i class="bi bi-x-circle"></i>
                                </button>
                            </div>
                            <div class="form-text">Нажмите на поле для выбора даты из календаря</div>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <div class="d-grid gap-2 d-md-flex w-100">
                            <asp:Button ID="btnSearch" runat="server" Text="Найти по дате" CssClass="btn btn-primary search-button" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
                
                <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false"></asp:Label>
                
                <div id="resultsPanel" class="card shadow-sm mb-3" runat="server" visible="false">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <h3 class="card-title mb-0 fs-5">
                            <i class="bi bi-list-columns-reverse me-2"></i>Результаты поиска
                        </h3>
                        <asp:Label ID="lblResultCount" runat="server" CssClass="badge bg-primary fs-6"></asp:Label>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="GridViewEvents" runat="server" CssClass="table table-striped table-hover" 
                                AutoGenerateColumns="false" EmptyDataText="Мероприятий не найдено" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="Title" HeaderText="Название" />
                                    <asp:BoundField DataField="Description" HeaderText="Описание" />
                                    <asp:BoundField DataField="Date" HeaderText="Дата" DataFormatString="{0:dd.MM.yyyy}" />
                                    <asp:BoundField DataField="Location" HeaderText="Место" />
                                    <asp:BoundField DataField="Organizer" HeaderText="Организатор" />
                                </Columns>
                                <HeaderStyle CssClass="table-primary" />
                                <EmptyDataRowStyle CssClass="alert alert-info" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </main>
    
    <!-- Добавляем стиль для кнопки поиска -->
    <style>
        .search-button::before {
            content: "\F52A";
            font-family: "bootstrap-icons";
            margin-right: 0.5rem;
        }
    </style>
    
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
            
            // Привязка события к TextBox
            $('#datePickerContainer').datepicker()
                .on('changeDate', function (e) {
                    $('#<%= txtDate.ClientID %>').val(
                        e.format('dd.mm.yyyy')
                    );
                });
            
            // Очистка поля даты
            $('#clearDate').click(function() {
                $('#<%= txtDate.ClientID %>').val('');
            });
        });
    </script>
</asp:Content> 