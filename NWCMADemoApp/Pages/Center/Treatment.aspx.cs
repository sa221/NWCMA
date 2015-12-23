using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using NWCMADemoApp.BLL.Admin;
using NWCMADemoApp.BLL.Center;
using NWCMADemoApp.Models.AdminModel;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.Pages.Center
{
    public partial class Treatment : Page
    {
        readonly DoctorEntryBll _doctorEntryBll = new DoctorEntryBll();
        readonly MedicineEntryBll _medicineEntryBll = new MedicineEntryBll();
        readonly DiseaseEntryBll _diseaseEntryBll = new DiseaseEntryBll();
        readonly PatientHistoryBll _patientHistoryBll = new PatientHistoryBll();
        readonly TreatmentBll _treatmentBll = new TreatmentBll();
        readonly DoseBll _doseBll = new DoseBll();
        readonly PatientBll _patientBll = new PatientBll();
        DataTable _dataTable = new DataTable();
        LoginModel _loginModel;
        private PatientModel _patient;

        protected void Page_Load(object sender, EventArgs e)
        {
            _loginModel = (LoginModel)Session["loginInformation"];
            
            
            if (!IsPostBack)
            {
                
                GetAllDoctorInDropDownlist();
                ListItem liDoctor = new ListItem("Select doctor", "-1");
                doctorDropDownList.Items.Insert(0, liDoctor);

                GetAllMedicineInDropDownlist();
                ListItem liMedicine = new ListItem("Select medicine", "-1");
                medicineDropDownList.Items.Insert(0, liMedicine);

                GetAllDiseaseInDropDownlist();
                ListItem liDisease = new ListItem("Select disease", "-1");
                diseaseDropdownList.Items.Insert(0, liDisease);

                GetAllDoseInDropDownlist();
                ListItem liDose = new ListItem("Select dose", "-1");
                doseDropdownList.Items.Insert(0, liDose);
                
            }
        }

        protected void showDetailsButton_Click(object sender, EventArgs e)
        {
            //GetPatientInfo();
            //string idTextBoxValue = voterIdTextBox.Text;
            //WebClient myWebClient = new WebClient();
            //var jsonData = myWebClient.DownloadString("http://nerdcastlebd.com/web_service/voterdb/index.php/voters/all/format/json");
            //JObject jObject = JObject.Parse(jsonData);

            //foreach (JObject resultJObject in jObject["voters"])
            //{

            //    string id = resultJObject["id"].ToString();

            //    if (idTextBoxValue == id)
            //    {
            //        string name = resultJObject["name"].ToString();
            //        string address = resultJObject["address"].ToString();
            //        string dateOfBirth = (string)resultJObject["date_of_birth"];

            //        int now = DateTime.Now.Year;
            //        string[] result = dateOfBirth.Split('-');
            //        int myDate = int.Parse(result[0].ToString());
            //        int age = now - myDate;

            //        patient= new PatientModel();
            //        patient.VoterId = id;
            //        patient.Name = name;
            //        patient.Address = address;
            //        patient.Age = age;

            //        voterIdTextBox.Text = id;
            //        patientNameTextBox.Text = name;
            //        addressTextBox.Text = address;
            //        ageTextBox.Text = age.ToString();
            //        serviceNumberTextBox.Text=GetNumberOfSevice(id).ToString();
            //        break;
            //    }
            //}
        }

        private void GetPatientInfo()
        {
            int patientId;
            string idTextBoxValue = voterIdTextBox.Text;
            try
            {
                patientId = Convert.ToInt32(idTextBoxValue);
                _patient = _patientBll.GetPationtInfo(patientId);
                patientNameTextBox.Text = _patient.Name;
                addressTextBox.Text = _patient.Address;
                ageTextBox.Text = _patient.Age.ToString();
                serviceNumberTextBox.Text = _patientBll.NumberOfService(_patient.Id).ToString();

            }
            catch (Exception)
            {
                // ignored
            }
        }
        public void GetAllDoctorInDropDownlist()
        {
            LoginModel loginModel = (LoginModel)Session["loginInformation"];
            doctorDropDownList.DataSource = _doctorEntryBll.GetAllDoctor(loginModel.Id);
            doctorDropDownList.DataTextField = "Name";
            doctorDropDownList.DataValueField = "ID";
            doctorDropDownList.DataBind();
        }

        public void GetAllMedicineInDropDownlist()
        {
            medicineDropDownList.DataSource = _medicineEntryBll.GetAllMedicine(_loginModel.Id);
            medicineDropDownList.DataTextField = "Name";
            medicineDropDownList.DataValueField = "ID";
            medicineDropDownList.DataBind();
        }
        public void GetAllDiseaseInDropDownlist()
        {
            diseaseDropdownList.DataSource = _diseaseEntryBll.GetAllDisease();
            diseaseDropdownList.DataTextField = "Name";
            diseaseDropdownList.DataValueField = "ID";
            diseaseDropdownList.DataBind();
        }

        public void GetAllDoseInDropDownlist()
        {
            doseDropdownList.DataSource = _doseBll.GetAllDose();
            doseDropdownList.DataTextField = "Dose";
            doseDropdownList.DataValueField = "ID";
            doseDropdownList.DataBind();
        }

        public int GetNumberOfSevice(int voterId)
        {
            return _patientBll.NumberOfService(voterId);
        }
        public void PopulateGridView()
        {
            _dataTable.Columns.Add("Disease", typeof(string));
            _dataTable.Columns.Add("DiseaseId", typeof(string));
            _dataTable.Columns.Add("Medicine", typeof(string));
            _dataTable.Columns.Add("MedicineId", typeof(string));
            _dataTable.Columns.Add("Dose", typeof(string));
            _dataTable.Columns.Add("DoseId", typeof(string));
            _dataTable.Columns.Add("Before/After", typeof(string));
            _dataTable.Columns.Add("Before/AfterId", typeof(string));
            _dataTable.Columns.Add("Quntity", typeof(string));
            _dataTable.Columns.Add("Note", typeof(string));
            _dataTable.AcceptChanges();
            Session["treatmentGridViewData"] = _dataTable;
        }

        private bool InsertDataIntoGridView()
        {
            _dataTable = (DataTable)Session["treatmentGridViewData"];
            if (String.IsNullOrWhiteSpace(quantityTextBox.Text))
            {
                quantityTextBox.Text = "0";
            }
            else
            {
                int quantity = _treatmentBll.GetQuantity(Convert.ToInt32(medicineDropDownList.SelectedItem.Value), _loginModel.Id);
                if (Convert.ToInt32(quantityTextBox.Text) > quantity)
                {
                    return false;
                }
            }
            _dataTable.Rows.Add(diseaseDropdownList.SelectedItem.Text, diseaseDropdownList.SelectedItem.Value, medicineDropDownList.SelectedItem.Text, medicineDropDownList.SelectedItem.Value,
                doseDropdownList.SelectedItem.Text, doseDropdownList.SelectedItem.Value, medicineIndication.SelectedItem.Text, medicineIndication.SelectedItem.Value, quantityTextBox.Text, noteTextBox.Text);
            _dataTable.AcceptChanges();
            Session["treatmentGridViewData"] = _dataTable;
            addMedicineGridView.DataSource = _dataTable;

            addMedicineGridView.Columns[1].Visible = true;
            addMedicineGridView.Columns[3].Visible = true;
            addMedicineGridView.Columns[5].Visible = true;
            addMedicineGridView.Columns[7].Visible = true;
            addMedicineGridView.DataBind();
            addMedicineGridView.Columns[1].Visible = false;
            addMedicineGridView.Columns[3].Visible = false;
            addMedicineGridView.Columns[5].Visible = false;
            addMedicineGridView.Columns[7].Visible = false;
            return true;
        }
        protected void addButton_Click(object sender, EventArgs e)
        {
            if (!diseaseDropdownList.SelectedValue.Equals("-1"))
            {
                if (!medicineDropDownList.SelectedValue.Equals("-1"))
                {
                    if (!doseDropdownList.SelectedValue.Equals("-1"))
                    {
                        if (Session["treatmentGridViewData"] == null)
                        {
                            PopulateGridView();
                        }

                        if (!InsertDataIntoGridView())
                        {
                            // Insufficient medicine
                        }
                    }
                }
            }
        }



        protected void saveButton_Click(object sender, EventArgs e)
        {
            if (_patient == null)
            {
                if (observationTextBox.Text != "")
                {
                    if (Convert.ToInt32(doctorDropDownList.SelectedValue) > 0)
                    {
                        if (Session["treatmentGridViewData"] != null)
                        {
                            int patientId = PatientEntry();
                            int treatmentHistoryId = PatientHistoryEntry(patientId);
                            if (TreatmentEntry(patientId, treatmentHistoryId))
                            {
                                Session["treatmentGridViewData"] = null;
                                _dataTable.Clear();
                                addMedicineGridView.DataSource = null;
                                addMedicineGridView.DataBind();
                                // successfully saved
                            }
                        }
                    }
                }
            }
        }

        private int PatientHistoryEntry(int patientId)
        {
            PatientHistoryModel patientHistory = new PatientHistoryModel();
            patientHistory.PatientId = patientId;
            patientHistory.Observation = observationTextBox.Text;
            patientHistory.DateOfServices = Calendar1.Text;
            patientHistory.DoctorId = Convert.ToInt32(doctorDropDownList.SelectedValue);
            LoginModel loginModel = (LoginModel)Session["loginInformation"];
            patientHistory.CenterId = loginModel.Id;
            return _patientHistoryBll.PatientHistoryEntry(patientHistory);
        }

        private bool TreatmentEntry(int patientId, int treatmentHistoryId)
        {
            int rows = addMedicineGridView.Rows.Count;
            List<TreatmentModel> treatments = new List<TreatmentModel>();
            if (rows > 0)
            {
                foreach (GridViewRow row in addMedicineGridView.Rows)
                {

                    TreatmentModel treatment = new TreatmentModel();
                    treatment.TreatmentHistoryId = treatmentHistoryId;
                    treatment.DiseaseId = Convert.ToInt32(row.Cells[1] .Text);
                    treatment.DoseId = Convert.ToInt32(row.Cells[5].Text);
                    treatment.IndicationId = Convert.ToInt32(row.Cells[7].Text);
                    treatment.MedicineId = Convert.ToInt32(row.Cells[3].Text);
                    treatment.Note = row.Cells[9].Text;
                    treatment.Quantiry = Convert.ToInt32(row.Cells[8].Text);
                    treatment.PatientId = patientId;
                    treatments.Add(treatment);
                }
                
            }
            return _treatmentBll.TreatementEntry(treatments,_loginModel.Id);

        }

        private int PatientEntry()
        {
            PatientModel patient = new PatientModel();
            patient.VoterId = Convert.ToInt32(voterIdTextBox.Text);
            patient.Name = patientNameTextBox.Text;
            patient.Address = addressTextBox.Text;
            patient.Age = Convert.ToInt32(ageTextBox.Text);
            return _patientBll.PatientEntry(patient);
        }


        protected void voterIdTextBox_TextChanged(object sender, EventArgs e)
        {
            GetPatientInfo();
        }
    }
}