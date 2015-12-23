using System;
using System.Web.UI;
using NWCMADemoApp.BLL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.Pages.Admin
{
    public partial class MedicineEntry : Page
    {
        readonly MedicineEntryBll _medicineEntryBll = new MedicineEntryBll();
        LoginModel _loginModel;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAllMedicineInGridView();
            _loginModel = (LoginModel)Session["loginInformation"];
        }



        public void GetAllMedicineInGridView()
        {
            medicineGridView.DataSource = _medicineEntryBll.GetAllMedicine();
            medicineGridView.DataBind();
        }

        protected void saveButton_Click(object sender, EventArgs e)
        {
            MedicineModel medicineModel = new MedicineModel();
            medicineModel.Name = medicineNameTextBox.Text;

            if (_medicineEntryBll.IsMedicineExist(medicineModel))
            {
                successStatusLabel.InnerText = "";
                failStatusLabel.InnerText = "Medicine already exist";
            }
            else
            {
                if (_medicineEntryBll.SaveMedicine(medicineModel) > 0)
                {
                    failStatusLabel.InnerText = "";
                    successStatusLabel.InnerText = "Medicine saved";
                    ClearAllField();
                    GetAllMedicineInGridView();
                }
                else
                {
                    successStatusLabel.InnerText = "";
                    failStatusLabel.InnerText = "Medicine not saved";

                }
            }

        }

        public void ClearAllField()
        {
            medicineNameTextBox.Text = "";
        }
    }
}