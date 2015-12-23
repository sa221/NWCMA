using System;
using System.Web.UI;

namespace NWCMADemoApp.Pages.MasterPages
{
    public partial class MasterPageAdmin : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void logOutButton_OnServerClick(object sender, EventArgs e)
        {
            Session.RemoveAll();
        
            Response.Redirect("~/Pages/Admin/AdminHome.aspx");
        }
    }
}