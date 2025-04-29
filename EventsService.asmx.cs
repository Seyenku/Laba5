using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.Script.Services;
using System.Web.Services;
using Laba5.Models;

namespace Laba5
{
    [WebService(Namespace = "http://laba5.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class EventsService : WebService
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<StudentEvent> GetEventsByDate(string date)
        {
            try
            {
                DateTime parsedDate = DateTime.ParseExact(date, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                return StudentEventRepository.GetEventsByDate(parsedDate);
            }
            catch (FormatException)
            {
                throw new ArgumentException("Invalid date format. Please use dd.MM.yyyy format.");
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<StudentEvent> GetAllEvents()
        {
            return StudentEventRepository.GetAllEvents();
        }
    }
}