using System;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.DAL.Admin
{
    public class LoginDal
    {

        private readonly SqlCommand _sqlCommand;
        private readonly SqlConnection _sqlConnection;

        public LoginDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;

        }

        public bool IsCodePasswordExist(LoginModel loginModel)
        {
            bool isCodePasswordExist = false;
            

            string query = "Select * from tblLogin where code=@code and password=@password";
            SqlParameter codeParameter = new SqlParameter("@code",loginModel.Code);
            _sqlCommand.Parameters.Add(codeParameter);

            SqlParameter passwordParameter = new SqlParameter("@password",loginModel.Password);
            _sqlCommand.Parameters.Add(passwordParameter);

            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                isCodePasswordExist = true;
            }
            _sqlConnection.Close();
          
            return isCodePasswordExist;
        }

        public LoginModel GetLoginTypeAndName(LoginModel loginModel)
        {
            LoginModel aLoginModel = new LoginModel();
            string query = "select id,type,name from tblLogin  where code=@loginCode and password=@loginPassword";
            
            SqlParameter codeParameter = new SqlParameter("@loginCode", loginModel.Code);
            _sqlCommand.Parameters.Add(codeParameter);

            SqlParameter passwordParameter = new SqlParameter("@loginPassword", loginModel.Password);
            _sqlCommand.Parameters.Add(passwordParameter);

            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                aLoginModel.Id = Convert.ToInt32(rdr[0]); 
                aLoginModel.LoginType = Convert.ToInt16(rdr[1]);
                aLoginModel.LoginName = rdr[2].ToString();

            }
            _sqlConnection.Close();

            return aLoginModel;

        }


    }
}