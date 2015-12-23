using System;
using System.Web.UI;
using NWCMADemoApp.BLL.Center;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.Pages.Center
{
    public partial class MedicineStockReport : Page
    {
        readonly MedicineStockBll _medicineStockBll = new MedicineStockBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAllStockReportInGridView();
        }

        private void GetAllStockReportInGridView()
        {
            LoginModel loginModel = new LoginModel();
            loginModel = (LoginModel)Session["loginInformation"];
            int centerId = loginModel.Id;
            medicineStockGridView.DataSource = _medicineStockBll.GetAllStockReportByCenter(centerId);
            medicineStockGridView.DataBind();
        }
    }
}