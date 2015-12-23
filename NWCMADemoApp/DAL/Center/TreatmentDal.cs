using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using NWCMADemoApp.Models.CenterModel;
using NWCMADemoApp.Pages.Center;

namespace NWCMADemoApp.DAL.Center
{
    public class TreatmentDal
    {
        private readonly SqlConnection _sqlConnection;
        private readonly SqlCommand _sqlCommand;

        public TreatmentDal()
        {
            _sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString);
            _sqlCommand = new SqlCommand();
            _sqlCommand.Connection = _sqlConnection;
        }

        public bool TreatementEntry(List<TreatmentModel> treatments)
        {
            if (treatments.Count > 0)
            {
                
                try
                {
                    foreach (TreatmentModel treatment in treatments)
                    {
                        _sqlCommand.Parameters.Clear();
                        string query = "Insert into tblTreatment values(@diseaseId,@medicineId,@doesId,@indicationId,@quantity,@note,@treatmentHistoryId,@patientId)";
                        _sqlCommand.Parameters.Add("@diseaseId", treatment.DiseaseId);
                        _sqlCommand.Parameters.Add("@medicineId", treatment.MedicineId);
                        _sqlCommand.Parameters.Add("@doesId", treatment.DoseId);
                        _sqlCommand.Parameters.Add("@indicationId", treatment.IndicationId);
                        _sqlCommand.Parameters.Add("@quantity", treatment.Quantiry);
                        _sqlCommand.Parameters.Add("@note", treatment.Note);
                        _sqlCommand.Parameters.Add("@treatmentHistoryId", treatment.TreatmentHistoryId);
                        _sqlCommand.Parameters.Add("@patientId", treatment.PatientId);
                        _sqlCommand.CommandText = query;

                        _sqlConnection.Open();
                        _sqlCommand.ExecuteNonQuery();
                        _sqlConnection.Close();
                    }
                }
                catch (Exception exception)
                {
                    _sqlConnection.Close();
                    Debug.WriteLine(exception);
                    return false;
                }
                
            }
            return true;

        }

        public int GetQuantity(int medicineId, int centerId)
        {
            int quantity = 0;
            _sqlCommand.Parameters.Clear();
            string query = "select quantity from tblProvidedMedicine where medicineId=@medicineId and centerId = @centerId";
            _sqlCommand.Parameters.Add("@medicineId", medicineId);
            _sqlCommand.Parameters.Add("@centerId", centerId);
            _sqlCommand.CommandText = query;

            _sqlConnection.Open();
            SqlDataReader rdr = _sqlCommand.ExecuteReader();
            while (rdr.Read())
            {
                quantity = (int) rdr[0];
            }
            _sqlConnection.Close();
            return quantity;
        }

        public bool UpdateQuantity(List<TreatmentModel> treatments, int centerId)
        {
           
            try
            {
                foreach (TreatmentModel treatment in treatments)
                {
                    int quantity = GetQuantity(treatment.MedicineId, centerId);
                    quantity -= treatment.Quantiry;
                    _sqlCommand.Parameters.Clear();
                    string query = "update tblProvidedMedicine set quantity=@newQuantity where medicineId=@medicinId and centerId = @centerId";
                    _sqlCommand.Parameters.Add("@newQuantity", quantity);
                    _sqlCommand.Parameters.Add("@medicinId", treatment.MedicineId);
                    _sqlCommand.Parameters.Add("@centerId", centerId);
                    _sqlCommand.CommandText = query;

                    _sqlConnection.Open();
                    _sqlCommand.ExecuteNonQuery();
                    _sqlConnection.Close();
                }
                
            }
            catch (Exception exception)
            {
                Debug.WriteLine(exception);
                _sqlConnection.Close();
                return false;
            }
            
            return true;
        }



    }
}