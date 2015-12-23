using System;
using System.Web.UI;
using NWCMADemoApp.BLL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.Pages.Admin
{
    public partial class DiseaseEntry : Page
    {
        readonly DiseaseEntryBll _diseaseEntryBll = new DiseaseEntryBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAllDiseaseInGridView();
        }

        protected void saveButton_Click(object sender, EventArgs e)
        {
            DiseaseModel diseaseModel = new DiseaseModel();
            diseaseModel.Name = diseaseTextBox.Text;
            diseaseModel.Description = descriptionTextBox.Text;
            diseaseModel.Procedure = procedureTextBox.Text;
           

            if (_diseaseEntryBll.IsDiseaseExist(diseaseModel))
            {
                successSpan.InnerText = "";
               failSpan.InnerText = "Disease name already exist";
                
            }
            else
            {
                if (_diseaseEntryBll.SaveDisease(diseaseModel) > 0)
                {
                    failSpan.InnerText = "";
                    successSpan.InnerText = "Disease name saved";

                    GetAllDiseaseInGridView();

                }
               
                else
                {
                    successSpan.InnerText = "";
                    failSpan.InnerText = "Disease name not saved";

                }
            }

        }


        public void GetAllDiseaseInGridView()
        {
            diseaseGridView.DataSource = _diseaseEntryBll.GetAllDisease();
            diseaseGridView.DataBind();
        }
    }
}