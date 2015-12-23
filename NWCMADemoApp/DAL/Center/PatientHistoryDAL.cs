using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.DAL.Center
{
    public class PatientHistoryDal
    {
        
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public PatientHistoryDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }


        public List<PatientInformationModel> GetAllHistory(int voterId)
        {
            List<PatientInformationModel> patientHistoryModels = new List<PatientInformationModel>();
            string query = "SpGetAllPatientHistoryByVoterId";
            _sqlCommand.CommandText = query;
            _sqlCommand.CommandType = CommandType.StoredProcedure;
            _sqlCommand.Parameters.AddWithValue("@voterId", voterId);

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
               PatientInformationModel patientInformationModel = new PatientInformationModel();
                patientInformationModel.Name = rdr[0].ToString();
                patientInformationModel.Address = rdr[1].ToString();
                patientInformationModel.CenterName = rdr[2].ToString();
                patientInformationModel.ServiceDate = rdr[3].ToString();
                patientInformationModel.Doctor = rdr[4].ToString();
                patientInformationModel.Observation = rdr[5].ToString();
                patientInformationModel.DiseaseName = rdr[6].ToString();
                patientInformationModel.MedicineName = rdr[7].ToString();
                patientInformationModel.Dose = rdr[8].ToString();
                patientInformationModel.Quantity = Convert.ToInt32(rdr[9].ToString());
                patientInformationModel.Note = rdr[10].ToString();
                patientHistoryModels.Add(patientInformationModel);
            }
            _sqlConnection.Close();
            return patientHistoryModels;

        }

        public int PatientHistoryEntry(PatientHistoryModel patientHistory)
        {
            string query = "Insert into tblPatientHistory OUTPUT INSERTED.ID values(@serviceDate,@doctorId,@centerId,@observation,@patientId)";
            SqlParameter nameParameter = new SqlParameter("@serviceDate", patientHistory.DateOfServices);
            _sqlCommand.Parameters.Add(nameParameter);

            SqlParameter degreeParameter = new SqlParameter("@doctorId", patientHistory.DoctorId);
            _sqlCommand.Parameters.Add(degreeParameter);

            SqlParameter specializationParameter = new SqlParameter("@centerId", patientHistory.CenterId);
            _sqlCommand.Parameters.Add(specializationParameter);

            SqlParameter centerIdParameter = new SqlParameter("@observation", patientHistory.Observation);
            _sqlCommand.Parameters.Add(centerIdParameter);

            SqlParameter patientIdParameter = new SqlParameter("@patientId", patientHistory.PatientId);
            _sqlCommand.Parameters.Add(patientIdParameter);

            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int treatmentHistoryId = (int) _sqlCommand.ExecuteScalar();
            _sqlConnection.Close();
            return treatmentHistoryId;
        }
    }
}