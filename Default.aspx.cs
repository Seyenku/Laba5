using System;
using System.Web.UI;
using System.Collections.Generic;

namespace Laba5
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEventsFromWCF();
            }
        }

        private void LoadEventsFromWCF()
        {
            try
            {
                var client = new EventsServiceWCFClient();
                
                var events = client.GetAllEvents();
                
                Session["AllEvents"] = events;
                
                client.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error calling WCF service: {ex.Message}");
            }
        }
    }
}