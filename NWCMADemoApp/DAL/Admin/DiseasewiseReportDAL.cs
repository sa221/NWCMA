using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.DAL.Admin
{
    public class DiseaseWiseReportDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public DiseaseWiseReportDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public List<DiseaseReportModel> GetAllDiseaseWiseReport(DiseaseReportCarryData diseaseReport)
        {
            List<DiseaseReportModel> diseaseReportModels = new List<DiseaseReportModel>();

            _sqlCommand.CommandType = CommandType.StoredProcedure;
            _sqlCommand.CommandText = "DiseaseReport";
            _sqlCommand.Parameters.Add("@startingDate", diseaseReport.StartingDate);
            _sqlCommand.Parameters.Add("@endingDate", diseaseReport.EndingDate);
            _sqlCommand.Parameters.Add("@dieaseName", diseaseReport.Disease);
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                DiseaseReportModel diseaseModel = new DiseaseReportModel();
                diseaseModel.District = rdr[0].ToString();
                diseaseModel.TotalPopulation = Convert.ToInt32(rdr[1]);
                diseaseModel.TotalPatient = (int) rdr[2];
                diseaseReportModels.Add(diseaseModel);
            }
            _sqlConnection.Close();
            return diseaseReportModels;

        }
    }
}