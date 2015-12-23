using System;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.DAL.Center
{
    public class PatientDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public PatientDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public int NumberOfService(int id)
        {
            string query = string.Format("select * from tblPatientHistory where patientId = " + id);
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            int numberOfServieces = 0;
            while (rdr.Read())
            {
                numberOfServieces++;
            }
            _sqlConnection.Close();
            return numberOfServieces;
        }

        public int PatientEntry(PatientModel patient)
        {
            string query = "Insert into tblPatient values(@voterId,@name,@address,@age); select SCOPE_IDENTITY(); ";
            SqlParameter nameParameter = new SqlParameter("@voterId", patient.VoterId);
            _sqlCommand.Parameters.Add(nameParameter);

            SqlParameter degreeParameter = new SqlParameter("@name", patient.Name);
            _sqlCommand.Parameters.Add(degreeParameter);

            SqlParameter specializationParameter = new SqlParameter("@address", patient.Address);
            _sqlCommand.Parameters.Add(specializationParameter);
            SqlParameter centerIdParameter = new SqlParameter("@age", patient.Age);
            _sqlCommand.Parameters.Add(centerIdParameter);

            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int patientId = (int) _sqlCommand.ExecuteScalar();
            _sqlConnection.Close();
            return patientId;
        }

        public bool IsExistPatient(int patientId)
        {
            string query = string.Format("select * from tblPatient where voterId = " + patientId);
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            if (rdr.Read())
            {
                rdr.Close();
                _sqlConnection.Close();
                return true;
            }
            rdr.Close();
            _sqlConnection.Close();
            return false;
        }
        public PatientModel GetPationtInfo(int patientId)
        {
            string query = string.Format("select * from tblPatient where voterId = " + patientId);
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            PatientModel patient = new PatientModel();
            while (rdr.Read())
            {
                patient.Id = Convert.ToInt32(rdr["id"].ToString());
                patient.VoterId = patientId;
                patient.Name= rdr["name"].ToString();
                patient.Address = rdr["address"].ToString();
                patient.Age = Convert.ToInt32(rdr["age"].ToString());
            }
            rdr.Close();
            _sqlConnection.Close();
            return patient;
        }

        public int GetPationtId(int patientId)
        {
            string query = string.Format("select * from tblPatient where voterId = " + patientId);
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            int id = 0;
            while (rdr.Read())
            {
                id = Convert.ToInt32(rdr["id"].ToString());
            }
            rdr.Close();
            _sqlConnection.Close();
            return id;
        }
    }
}