using Laba5.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laba5
{
    public partial class TestWCFClient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                resultsPanel.Visible = false;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;
            EventsServiceWCFClient client = null;

            try
            {
                client = new EventsServiceWCFClient();
                string date = txtDate.Text.Trim();

                if (string.IsNullOrEmpty(date))
                {
                    lblError.Text = "Please enter a date.";
                    return;
                }

                DateTime parsedDate;
                if (!DateTime.TryParseExact(date, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out parsedDate))
                {
                    lblError.Text = "Invalid date format. Please use dd.MM.yyyy format.";
                    return;
                }

                StudentEvent[] events = client.GetEventsByDate(date);

                if (events != null && events.Length > 0)
                {
                    GridViewEvents.DataSource = events;
                    GridViewEvents.DataBind();
                    lblResultCount.Text = $"Found {events.Length} events on {parsedDate.ToString("dd.MM.yyyy")}";
                    resultsPanel.Visible = true;
                }
                else
                {
                    lblError.Text = $"No events found on {parsedDate.ToString("dd.MM.yyyy")}";
                    resultsPanel.Visible = false;
                }
            }
            catch (FaultException ex)
            {
                lblError.Text = ex.Message;
                resultsPanel.Visible = false;
            }
            catch (Exception ex)
            {
                lblError.Text = $"Error: {ex.Message}";
                resultsPanel.Visible = false;
            }
            finally
            {
                if (client != null && client.State != CommunicationState.Closed)
                    client.Abort();
            }
        }

        protected void btnGetAll_Click(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;
            EventsServiceWCFClient client = null;

            try
            {
                client = new EventsServiceWCFClient();
                StudentEvent[] allEvents = client.GetAllEvents();

                GridViewEvents.DataSource = allEvents;
                GridViewEvents.DataBind();
                lblResultCount.Text = $"All events ({allEvents.Length})";
                resultsPanel.Visible = true;
            }
            catch (Exception ex)
            {
                lblError.Text = $"Error: {ex.Message}";
                resultsPanel.Visible = false;
            }
            finally
            {
                if (client != null && client.State != CommunicationState.Closed)
                    client.Abort();
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
            resultsPanel.Visible = false;
        }
    }
} 