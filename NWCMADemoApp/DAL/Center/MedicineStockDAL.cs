using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.DAL.Center
{
    public class MedicineStockDal
    {
        private readonly SqlCommand _sqlCommand;
        private readonly SqlConnection _sqlConnection;

        public MedicineStockDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public List<MedicineStockModel> GetAllStockInformation(int centerId)
        {
            List<MedicineStockModel> medicineStockModels = new List<MedicineStockModel>();
            string query = "SpGetMedicineNameAndQuantityByCenterId";
            _sqlCommand.CommandText = query;
            _sqlCommand.CommandType = CommandType.StoredProcedure;
            _sqlCommand.Parameters.AddWithValue("@centerId", centerId);
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                MedicineStockModel medicineStockModel = new MedicineStockModel();
                medicineStockModel.MedicineName = rdr[0].ToString();
                medicineStockModel.PresentStock = Convert.ToInt32(rdr[1].ToString());
                medicineStockModels.Add(medicineStockModel);
            }
            _sqlConnection.Close();
            return medicineStockModels;
        }
    }
}