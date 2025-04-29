using Laba5.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.Diagnostics;

namespace Laba5
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class EventsServiceWCF : IEventsServiceWCF
    {
        public List<StudentEvent> GetEventsByDate(string date)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(date))
                {
                    throw new ArgumentException("Date parameter cannot be null or empty");
                }

                date = date.Trim();

                DateTime parsedDate;
                if (!DateTime.TryParseExact(date, "dd.MM.yyyy", CultureInfo.InvariantCulture, 
                                          DateTimeStyles.None, out parsedDate))
                {
                    throw new ArgumentException($"Invalid date format: '{date}'. Please use dd.MM.yyyy format.");
                }

                return StudentEventRepository.GetEventsByDate(parsedDate);
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Error in GetEventsByDate: {ex.Message}");
                throw new FaultException($"Error processing date: {ex.Message}");
            }
        }

        public List<StudentEvent> GetAllEvents()
        {
            return StudentEventRepository.GetAllEvents();
        }
    }
}