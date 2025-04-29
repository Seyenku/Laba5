using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Laba5.Models
{
    public static class StudentEventRepository
    {
        private static List<StudentEvent> _events = new List<StudentEvent>
        {
            new StudentEvent { Id = 1, Title = "Student Conference", Description = "Annual scientific conference", Date = DateTime.Parse("30.04.2025"), Location = "Main Hall", Organizer = "Student Council" },
            new StudentEvent { Id = 2, Title = "Basketball Tournament", Description = "Inter-university competition", Date = DateTime.Parse("30.04.2025"), Location = "Sports Complex", Organizer = "Sports Department" },
            new StudentEvent { Id = 3, Title = "Career Fair", Description = "Meet potential employers", Date = DateTime.Parse("30.04.2025"), Location = "University Center", Organizer = "Career Development" },
            new StudentEvent { Id = 4, Title = "Programming Contest", Description = "Coding competition for students", Date = DateTime.Parse("30.04.2025"), Location = "IT Building", Organizer = "Computer Science Department" },
            new StudentEvent { Id = 5, Title = "Spring Concert", Description = "Student music performances", Date = DateTime.Parse("30.04.2025"), Location = "Concert Hall", Organizer = "Music Department" }
        };

        public static List<StudentEvent> GetEventsByDate(DateTime date)
        {
            return _events.FindAll(e => e.Date.Date == date.Date);
        }

        public static List<StudentEvent> GetAllEvents()
        {
            return _events;
        }
    }
}