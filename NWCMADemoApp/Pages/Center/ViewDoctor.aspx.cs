using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using NWCMADemoApp.BLL.Center;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.Pages.Center
{
    public partial class ViewDoctor : Page
    {
        readonly DoctorEntryBll _doctorEntryBll = new DoctorEntryBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAllDoctorInGridView();
        }
        public void GetAllDoctorInGridView()
        {
            LoginModel loginModel = (LoginModel)Session["loginInformation"];

            doctorGridView.DataSource = _doctorEntryBll.GetAllDoctor(loginModel.Id);
            doctorGridView.DataBind();
        }

        protected void doctorGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            doctorGridView.PageIndex = e.NewPageIndex;
            GetAllDoctorInGridView();
        }
    }
}