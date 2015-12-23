using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.DAL.Center
{
    public class DoseDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public DoseDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public List<DoseModel> GetAllDose()
        {
            List<DoseModel> doseModels = new List<DoseModel>();

            string query = "Select * from tblDose";
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                DoseModel doseModel = new DoseModel();
                doseModel.Id = Convert.ToInt32(rdr[0]);
                doseModel.Dose = rdr[1].ToString();

                doseModels.Add(doseModel);
                
            }
            _sqlConnection.Close();
            return doseModels;

        }
    }
}