using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using NWCMADemoApp.BLL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.Pages.Admin
{
    public partial class DiseaseWiseReport : Page
    {
        readonly DiseaseEntryBll _diseaseEntryBll = new DiseaseEntryBll();
        DataTable _dataTable = new DataTable();
        readonly DiseaseWiseReportBll _diseaseWiseReportBll = new DiseaseWiseReportBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetAllDiseaseInDropDownlist();
                ListItem liDisease = new ListItem("Select disease","-1");
                diseaseDropdownList.Items.Insert(0,liDisease);
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            date1.Text = Calendar1.SelectedDate.ToShortDateString();
        }

        protected void Calendar3_SelectionChanged(object sender, EventArgs e)
        {
            date2.Text = Calendar3.SelectedDate.ToShortDateString();
        }

        public void GetAllDiseaseInDropDownlist()
        {
            diseaseDropdownList.DataSource = _diseaseEntryBll.GetAllDisease();
            diseaseDropdownList.DataTextField = "Name";
            diseaseDropdownList.DataValueField = "ID";
            diseaseDropdownList.DataBind();
        }

        protected void showButton_Click(object sender, EventArgs e)
        {
            if (Session["DiseaseReportGridViewData"] == null)
            {
                PopulateGridView();
                InsertDataIntoGridView();
            }
            else
            {
                InsertDataIntoGridView();
            }
        }
        public void PopulateGridView()
        {
            _dataTable.Columns.Add("District", typeof(string));
            _dataTable.Columns.Add("Total Population", typeof(int));
            _dataTable.Columns.Add("Total Patient", typeof(int));

            Session["DiseaseReportGridViewData"] = _dataTable;
        }
        private void InsertDataIntoGridView()
        {
            _dataTable = (DataTable)Session["DiseaseReportGridViewData"];
            DiseaseReportCarryData diseaseReport = new DiseaseReportCarryData();
            diseaseReport.StartingDate = Convert.ToDateTime(date1.Text);
            diseaseReport.EndingDate = Convert.ToDateTime(date2.Text);
            diseaseReport.Disease = diseaseDropdownList.SelectedItem.Text;
            List < DiseaseReportModel > diseaseReports = _diseaseWiseReportBll.GetAllDiseaseWiseReport(diseaseReport);
            foreach (DiseaseReportModel reportModel in diseaseReports)
            {
                _dataTable.Rows.Add(reportModel.District, reportModel.TotalPopulation, reportModel.TotalPatient);
            }
            
            _dataTable.AcceptChanges();
            Session["DiseaseReportGridViewData"] = _dataTable;
            addMedicineGridView.DataSource = _dataTable;
            addMedicineGridView.DataBind();
        }

    }
}