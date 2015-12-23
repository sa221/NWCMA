using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.DAL.Admin
{
    public class SendMedicineDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public SendMedicineDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public List<CenterModel> GetAllCenter(ThanaModel thanaModel)
        {
            List<CenterModel> centerModels = new List<CenterModel>();
            string query = "select id,name from tblCenter where tId=@tId";
            _sqlCommand.Parameters.AddWithValue("@tId", thanaModel.Id);
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                CenterModel centerModel = new CenterModel();
                centerModel.Id = Convert.ToInt32(rdr[0]);
                centerModel.Name = rdr[1].ToString();
                centerModels.Add(centerModel);
            }
            _sqlConnection.Close();
            return centerModels;
        }
        //Medicine

        public int GetSelectedMedicineId(string medicineName)
        {

            int medicineId = 0;
            string query = String.Format(@"select id from tblMedicine where name='{0}'",medicineName);
            //sqlCommand.CommandType = CommandType.StoredProcedure;
            //sqlCommand.Parameters.AddWithValue("@name", medicineModel.ID);
            

            //SqlParameter nameParameter = new SqlParameter("@mName", medicineName);
            //sqlCommand.Parameters.Add(nameParameter);
           
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                medicineId = Convert.ToInt32(rdr[0]);
            }
           
            _sqlConnection.Close();
            return medicineId;
        }

        public List<MedicineModel> GetAllMedicine()
        {
            List<MedicineModel> medicineModels = new List<MedicineModel>();
            string query = "select * from tblMedicine";
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                MedicineModel medicineModel = new MedicineModel();
                medicineModel.Id = Convert.ToInt32(rdr[0]);
                medicineModel.Name = rdr[1].ToString();
                medicineModels.Add(medicineModel);
            }
            _sqlConnection.Close();
            return medicineModels;
        }

        public int SaveSendMedicine(SendMedicineModel sendMedicineModel)
        {
            string query = String.Format(@"Insert into tblProvidedMedicine values('{0}',
                 '{1}','{2}','{3}','{4}')",
             sendMedicineModel.MedicineId,sendMedicineModel.Quantity,sendMedicineModel.CenterId,sendMedicineModel.ThanaId,sendMedicineModel.DistrictId);
 
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            int rowsAffected = _sqlCommand.ExecuteNonQuery();
            _sqlConnection.Close();
            
            return rowsAffected;
        }

        public int UpdateSendMedicine(SendMedicineModel sendMedicineModel)
        {
            string query = String.Format(@"Update tblProvidedMedicine set quantity='{0}'+quantity where
            medicineId='{1}' and centerId='{2}'",sendMedicineModel.Quantity,sendMedicineModel.MedicineId,sendMedicineModel.CenterId);

            
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            int rowsUpdated = _sqlCommand.ExecuteNonQuery();
            _sqlConnection.Close();
            
            return rowsUpdated;
        }

        public bool IsMedicineQuantityExist(SendMedicineModel sendMedicineModel)
        {
            bool isMedicineQuantityExist = false;
            string query = String.Format(@"Select * from tblProvidedMedicine where medicineId='{0}' and centerId='{1}'",sendMedicineModel.MedicineId,sendMedicineModel.CenterId);
            //sqlCommand.Parameters.AddWithValue("@medicineId2", sendMedicineModel.MedicineId);
            //sqlCommand.Parameters.AddWithValue("@centerId2", sendMedicineModel.CenterId);
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                isMedicineQuantityExist = true;
            }
            _sqlConnection.Close();

            return isMedicineQuantityExist;
        }


    }
}