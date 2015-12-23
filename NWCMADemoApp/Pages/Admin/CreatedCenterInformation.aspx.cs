using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using NWCMADemoApp.BLL.Admin;

namespace NWCMADemoApp.Pages.Admin
{
    public partial class CreatedCenterInformation : Page
    {
        readonly CreateCenterBll _createCenterBll = new CreateCenterBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            GetCreatedCenterSpecificInformaftion();
        }

        public void GetCreatedCenterSpecificInformaftion()
        {
            newCenterGridView.DataSource = _createCenterBll.GetAllCenter();
            newCenterGridView.DataBind();
        }

        protected void generatePDFButton_Click(object sender, EventArgs e)
        {
            PdfPTable pdfPTable = new PdfPTable(newCenterGridView.HeaderRow.Cells.Count);

           

            foreach (TableCell headerCell in newCenterGridView.HeaderRow.Cells)
            {
                
                PdfPCell pfdPCell = new PdfPCell(new Phrase(headerCell.Text));
                //pfdPCell.BackgroundColor = new BaseColor(newCenterGridView.HeaderStyle.ForeColor);
                pdfPTable.AddCell(pfdPCell);
            }


            foreach (GridViewRow gridViewRow in newCenterGridView.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
                   

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
            Response.AppendHeader("content-disposition", "attachment;filename=NewCenter.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();


        }
    }
}