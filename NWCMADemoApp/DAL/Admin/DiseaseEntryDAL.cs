using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.DAL.Admin
{
    public class DiseaseEntryDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public DiseaseEntryDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public int SaveDisease(DiseaseModel diseaseModel)
        {
          
            string query = "Insert into tblDisease values(@name,@description,@tProcedure)";
            SqlParameter nameParameter = new SqlParameter("@name",diseaseModel.Name);
            _sqlCommand.Parameters.Add(nameParameter);

            SqlParameter descriptionParameter = new SqlParameter("@description", diseaseModel.Description);
            _sqlCommand.Parameters.Add(descriptionParameter);

            SqlParameter procedureParameter = new SqlParameter("@tProcedure", diseaseModel.Procedure);
            _sqlCommand.Parameters.Add(procedureParameter);



            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int rowsAffected = _sqlCommand.ExecuteNonQuery();
            _sqlConnection.Close();
            return rowsAffected;

        }

        public bool IsDiseaseExist(DiseaseModel diseaseModel)
        {
            bool isDiseaseExist = false;
            string query = "Select * from tblDisease where name=@diseaseName";
            _sqlCommand.CommandText = query;
            SqlParameter medicineNameParameter = new SqlParameter("@diseaseName", diseaseModel.Name);
            _sqlCommand.Parameters.Add(medicineNameParameter);
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                isDiseaseExist = true;
            }
            _sqlConnection.Close();
            return isDiseaseExist;

        }

        public List<DiseaseModel> GetAllDisease()
        {
            List<DiseaseModel> diseaseModels = new List<DiseaseModel>();

            string query = "Select * from tblDisease";
            _sqlCommand.CommandText = query;
           
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                DiseaseModel diseaseModel = new DiseaseModel();
                diseaseModel.Id = (int) rdr[0];
                diseaseModel.Name = rdr[1].ToString();
                diseaseModel.Description = rdr[2].ToString();
                diseaseModel.Procedure = rdr[3].ToString();
                diseaseModels.Add(diseaseModel);
            }
            _sqlConnection.Close();
            return diseaseModels;

        }

    }
}