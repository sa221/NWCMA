using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.DAL.Admin
{
    public class MedicineEntryDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public MedicineEntryDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public int SaveMedicine(MedicineModel medicineModel)
        {
          
            string query = "Insert into tblMedicine values(@name)";
            SqlParameter nameParameter = new SqlParameter("@name",medicineModel.Name);
            _sqlCommand.Parameters.Add(nameParameter);
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int rowsAffected = _sqlCommand.ExecuteNonQuery();
            _sqlConnection.Close();
            return rowsAffected;

        }

        public bool IsMedicineExist(MedicineModel medicineModel)
        {
            bool isMedicineExist = false;
            string query = "Select * from tblMedicine where name=@medicineName";
            _sqlCommand.CommandText = query;
            SqlParameter medicineNameParameter = new SqlParameter("@medicineName",medicineModel.Name);
            _sqlCommand.Parameters.Add(medicineNameParameter);
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                isMedicineExist = true;
            }
            _sqlConnection.Close();
            return isMedicineExist;

        }

        public List<MedicineModel> GetAllMedicine(int centerId)
        {
            List<MedicineModel> medicineModels = new List<MedicineModel>();
          
            string query = "Select m.id,m.name from tblMedicine as m join tblProvidedMedicine as pm on m.id=pm.medicineId where pm.centerId = @centerId and quantity>0";
            _sqlCommand.Parameters.Add("@centerId", centerId);
            _sqlCommand.CommandText = query;
           
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
               MedicineModel medicineModel = new MedicineModel();
                medicineModel.Id = (int) rdr[0];
                medicineModel.Name = rdr[1].ToString();
                medicineModels.Add(medicineModel);
            }
            _sqlConnection.Close();
            return medicineModels;

        }
        public List<MedicineModel> GetAllMedicine()
        {
            List<MedicineModel> medicineModels = new List<MedicineModel>();

            string query = "Select * from tblMedicine";
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                MedicineModel medicineModel = new MedicineModel();
                medicineModel.Id = (int)rdr[0];
                medicineModel.Name = rdr[1].ToString();
                medicineModels.Add(medicineModel);
            }
            _sqlConnection.Close();
            return medicineModels;

        }
    }
}