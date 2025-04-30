using System;
using System.Web.UI;

namespace Laba5
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentUrl = Request.Url.AbsolutePath.ToLower();
            
        }
    }
}