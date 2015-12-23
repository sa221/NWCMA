using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.DAL.Admin
{
    public class CreateCenterDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public CreateCenterDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public List<DistrictModel> GetAllDistrict()
        {
            List<DistrictModel> districtModels = new List<DistrictModel>();
            string query = "select * from tblDistrict";
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                DistrictModel districtModel = new DistrictModel();
                districtModel.Id = Convert.ToInt32(rdr[0]);
                districtModel.Name = rdr[1].ToString();
                districtModels.Add(districtModel);
            }
            _sqlConnection.Close();
            return districtModels;
        }

        public List<ThanaModel> GetAllThana(DistrictModel districtModel)
        {
            List<ThanaModel> thanaModels = new List<ThanaModel>();
            string query = "select * from tblThana where dId=@dId";

            SqlParameter dIdParameter = new SqlParameter("@dId",districtModel.Id);
            _sqlCommand.Parameters.Add(dIdParameter);
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                ThanaModel thanaModel = new ThanaModel();
                thanaModel.Id = Convert.ToInt32(rdr[0]);
                thanaModel.Name = rdr[1].ToString();
                thanaModels.Add(thanaModel);
            }
            _sqlConnection.Close();
            return thanaModels;
        }

        //xdfcsd sdfsdfsd




        public int SaveCenter(CenterModel centerModel)
        {

            string query = "Insert into tblCenter values(@name,@cCode,@password,@tId,@dId,@type)";            

            SqlParameter nameParameter = new SqlParameter("@name", centerModel.Name);
            _sqlCommand.Parameters.Add(nameParameter);

            SqlParameter codeParameter = new SqlParameter("@cCode", centerModel.Code);
            _sqlCommand.Parameters.Add(codeParameter);

            SqlParameter passwordParameter = new SqlParameter("@password", centerModel.Password);
            _sqlCommand.Parameters.Add(passwordParameter);

            SqlParameter thanaIdParameter = new SqlParameter("@tId", centerModel.ThanaId);
            _sqlCommand.Parameters.Add(thanaIdParameter);
            SqlParameter dictrictIdParameter = new SqlParameter("@dId", centerModel.DistrictId);
            _sqlCommand.Parameters.Add(dictrictIdParameter);
            SqlParameter loginTypeParameter = new SqlParameter("@type", centerModel.LoginType);
            _sqlCommand.Parameters.Add(loginTypeParameter);


            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int rowsAffected = _sqlCommand.ExecuteNonQuery();
            _sqlConnection.Close();
            return rowsAffected;

        }

        public bool IsCenterExist(CenterModel centerModel)
        {
            bool isCenterExist = false;
            string query = "Select * from tblCenter where name=@centerName and tId=@thanaId";
            _sqlCommand.CommandText = query;
            SqlParameter centerNameParameter = new SqlParameter("@centerName", centerModel.Name);
            _sqlCommand.Parameters.Add(centerNameParameter);

            SqlParameter thanaIdParameter = new SqlParameter("@thanaId", centerModel.ThanaId);
            _sqlCommand.Parameters.Add(thanaIdParameter);

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                isCenterExist = true;
            }
            _sqlConnection.Close();
            return isCenterExist;

        }

        public int GetLastIdentity()
        {
            string query = "Select IDENT_CURRENT(\'tblCenter\')";
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int identityValue = Convert.ToInt32(_sqlCommand.ExecuteScalar());
            _sqlConnection.Close();
            return identityValue;
        }

        public List<CenterModel> GetAllCenter()
        {
            int serialNumber = 1;
            List<CenterModel> centerModels = new List<CenterModel>();
            int lastId =  GetLastIdentity();


            string query = "Select * from tblCenter where id=@id";

            SqlParameter lastIdParameter = new SqlParameter("@id",lastId);
            _sqlCommand.Parameters.Add(lastIdParameter);
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                CenterModel centerModel = new CenterModel();
                centerModel.Id = serialNumber;
                centerModel.Name = rdr[1].ToString();
                centerModel.Code = rdr[2].ToString();
                centerModel.Password = rdr[3].ToString();
                centerModels.Add(centerModel);
                serialNumber++;
            }
            _sqlConnection.Close();
            return centerModels;

        }


    }
}