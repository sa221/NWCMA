using System.Collections.Generic;
using NWCMADemoApp.DAL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.BLL.Admin
{
    public class SendMedicineBll
    {
        readonly SendMedicineDal _sendMedicineDal = new SendMedicineDal();


        public List<CenterModel> GetAllCenterName(ThanaModel thanaModel)
        {
            return _sendMedicineDal.GetAllCenter(thanaModel);
        }

        public List<MedicineModel> GetAllMedicineName()
        {
            return _sendMedicineDal.GetAllMedicine();
        }

        public int GetSelectedMedicineId(string medicineName)
        {
            return _sendMedicineDal.GetSelectedMedicineId(medicineName);
        }

        public int SaveSendMedicine(SendMedicineModel sendMedicineModel)
        {
            return _sendMedicineDal.SaveSendMedicine(sendMedicineModel);
        }
        public int UpdateSendMedicine(SendMedicineModel sendMedicineModel)
        {
            return _sendMedicineDal.UpdateSendMedicine(sendMedicineModel);
        }
        public bool IsMedicineQuantityExist(SendMedicineModel sendMedicineModel)
        {
            return _sendMedicineDal.IsMedicineQuantityExist(sendMedicineModel);
        }

    }
}