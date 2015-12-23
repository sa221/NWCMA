﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using NWCMADemoApp.Models.AdminModel;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.DAL.Center
{
    public class DoctorEntryDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public DoctorEntryDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public int SaveDoctor(DoctorModel doctorModel)
        {

            string query = "Insert into tblDoctor values(@name,@degree,@specialization,@centerId)";
            SqlParameter nameParameter = new SqlParameter("@name", doctorModel.Name);
            _sqlCommand.Parameters.Add(nameParameter);

            SqlParameter degreeParameter = new SqlParameter("@degree", doctorModel.Degree);
            _sqlCommand.Parameters.Add(degreeParameter);

            SqlParameter specializationParameter = new SqlParameter("@specialization", doctorModel.Specialization);
            _sqlCommand.Parameters.Add(specializationParameter);
            SqlParameter centerIdParameter = new SqlParameter("@centerId", doctorModel.CenterId);
            _sqlCommand.Parameters.Add(centerIdParameter);



            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            int rowsAffected = _sqlCommand.ExecuteNonQuery();
            _sqlConnection.Close();
            return rowsAffected;

        }
        public List<CenterModel> GetAllCenter()
        {
            List<CenterModel> centerModels = new List<CenterModel>();
            string query = "select * from tblCenter";
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

        public List<DoctorModel> GetAllDoctor(int loginId)
        {
            List<DoctorModel> doctorModels = new List<DoctorModel>();
            string query = String.Format("Select * from tblDoctor where centerId="+loginId+"");
            _sqlCommand.CommandText = query;
            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                DoctorModel doctorModel = new DoctorModel();
                doctorModel.Id = (int) rdr[0];
                doctorModel.Name = rdr[1].ToString();
                doctorModel.Degree = rdr[2].ToString();
                doctorModel.Specialization = rdr[3].ToString();
                doctorModels.Add(doctorModel);
            }
            _sqlConnection.Close();
            return doctorModels;
        }

    }
}