using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using Laba5.Models;

namespace Laba5
{
    [ServiceContract]
    public interface IEventsServiceWCF
    {
        [OperationContract]
        [WebGet(UriTemplate = "GetEventsByDate?date={date}", ResponseFormat = WebMessageFormat.Json)]
        List<StudentEvent> GetEventsByDate(string date);

        [OperationContract]
        [WebGet(UriTemplate = "GetAllEvents", ResponseFormat = WebMessageFormat.Json)]
        List<StudentEvent> GetAllEvents();
    }
} 