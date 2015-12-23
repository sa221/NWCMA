using System;
using System.Web.UI;
using NWCMADemoApp.BLL.Center;
using NWCMADemoApp.Models.AdminModel;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.Pages.Center
{
    public partial class DoctorEntry : Page
    {
        readonly DoctorEntryBll _doctorEntryBll = new DoctorEntryBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        
        protected void saveDoctorButton_Click(object sender, EventArgs e)
        {
            // Get the center id from session

            LoginModel loginModel = (LoginModel)Session["loginInformation"];

            DoctorModel doctorModel = new DoctorModel();
            doctorModel.Name = doctorNameTextBox.Text;
            doctorModel.Degree = degreeTextBox.Text;
            doctorModel.Specialization = specializationTextBox.Text;
            doctorModel.CenterId = loginModel.Id;
            if (_doctorEntryBll.SaveDoctor(doctorModel) > 0)
            {
                failStatusLabel.InnerText = "";
                successStatusLabel.InnerText = "Doctor name saved";
                //GetAllDoctorInGridView();

            }
            else
            {
                successStatusLabel.InnerText = "";
                failStatusLabel.InnerText = "Doctor name not saved";

            }
        }

       

       
    }
}