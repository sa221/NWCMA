using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using NWCMADemoApp.BLL.Center;
using NWCMADemoApp.Models.CenterModel;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace NWCMADemoApp.Pages.Center
{
    public partial class TreatmentHistory : Page
    {
        readonly PatientHistoryBll _patientHistoryBll = new PatientHistoryBll();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        DataTable _dataTable = new DataTable("TreatmentHistory");
        protected void showDetailsButton_Click(object sender, EventArgs e)
        {
            int voterId =  Convert.ToInt32(voterIdTextBox.Text);
            List<PatientInformationModel> patientHistoryModels = new List<PatientInformationModel>();
            patientHistoryModels = _patientHistoryBll.GetAllHistory(voterId);
            PopulateDataTable();
            foreach (PatientInformationModel myHistory in patientHistoryModels)
            {
                patientNameTextBox.Text =  myHistory.Name;
                addressTextBox.Text = myHistory.Address;
                string serviceDate = myHistory.ServiceDate;

                TextBox centerNameTextBox = new TextBox();
                TextBox dateTextBox = new TextBox();
                TextBox doctorTextBox = new TextBox();
                TextBox observationTextBox = new TextBox();
                centerNameTextBox.Text = myHistory.CenterName;
                dateTextBox.Text = myHistory.Doctor;
                observationTextBox.Text = myHistory.Observation;
                PlaceHolder placeHolder1 = new PlaceHolder();
                placeHolder1.Controls.Add(centerNameTextBox);
                placeHolder1.Controls.Add(new LiteralControl("<br />"));

                InsertDataIntoDataTable(myHistory);
                treatmentHistoryGrid.DataSource = _dataTable;
                treatmentHistoryGrid.DataBind();

                //Controls.Add(centerNameTextBox);
                //    form1.Controls.Add(dateTextBox);
                //    form1.Controls.Add(doctorTextBox);
                //    form1.Controls.Add(observationTextBox);
            }
            


        }

        private int counter = 0;
        private void InsertDataIntoDataTable(PatientInformationModel patientInformation)
        {
            counter++;
            _dataTable.Rows.Add(counter, patientInformation.Doctor,patientInformation.DiseaseName,patientInformation.ServiceDate,patientInformation.Observation,
                patientInformation.MedicineName,patientInformation.Quantity,patientInformation.Dose,patientInformation.Note);
            _dataTable.AcceptChanges();

        }

        private void PopulateDataTable()
        {
            _dataTable.Columns.Add("Serial", typeof (string));
            _dataTable.Columns.Add("Doctor", typeof (string));
            _dataTable.Columns.Add("Disease", typeof (string));
            _dataTable.Columns.Add("Date", typeof (string));
            _dataTable.Columns.Add("Observation", typeof (string));
            _dataTable.Columns.Add("Medicine", typeof (string));
            _dataTable.Columns.Add("Quantity", typeof (string));
            _dataTable.Columns.Add("Does", typeof (string));
            _dataTable.Columns.Add("Note", typeof (string));
            _dataTable.AcceptChanges();
        }

       
        protected void generatePDFButton_Click(object sender, EventArgs e)
        {
            PdfPTable pdfPTable = new PdfPTable(treatmentHistoryGrid.HeaderRow.Cells.Count);



            foreach (TableCell headerCell in treatmentHistoryGrid.HeaderRow.Cells)
            {

                PdfPCell pfdPCell = new PdfPCell(new Phrase(headerCell.Text));
                //PdfPCell pfdPCell = new PdfPCell(new Phrase(" Name"));
                //pfdPCell.BackgroundColor = new BaseColor(newCenterGridView.HeaderStyle.ForeColor);
                pdfPTable.AddCell(pfdPCell);
            }


            foreach (GridViewRow gridViewRow in treatmentHistoryGrid.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {

                   // PdfPCell pfdPCell = new PdfPCell(new Phrase(_dataTable.Columns[1].ToString()));

                    PdfPCell pfdPCell = new PdfPCell(new Phrase(tableCell.Text));
                    //pfdPCell.BackgroundColor = new BaseColor(newCenterGridView.HeaderStyle.ForeColor);
                    pdfPTable.AddCell(pfdPCell);
                }
            }
            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);

            pdfDocument.Open();
            pdfDocument.Add(pdfPTable);
            pdfDocument.Close();

            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition", "attachment;filename=Patient_History.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();


        }
    }
}