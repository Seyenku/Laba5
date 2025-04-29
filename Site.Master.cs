using System;
using System.Web.UI;

namespace Laba5
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Set the active class for the current page in the navigation
            string currentUrl = Request.Url.AbsolutePath.ToLower();
            
        }
    }
}