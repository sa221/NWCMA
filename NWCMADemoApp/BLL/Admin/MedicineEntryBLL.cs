using System.Collections.Generic;
using NWCMADemoApp.DAL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.BLL.Admin
{
    public class MedicineEntryBll
    {
        readonly MedicineEntryDal _medicineEntryDal = new MedicineEntryDal();

        public int SaveMedicine(MedicineModel medicineModel)
        {
            return _medicineEntryDal.SaveMedicine(medicineModel);
        }

        public bool IsMedicineExist(MedicineModel medicineModel)
        {
            return _medicineEntryDal.IsMedicineExist(medicineModel);
        }

        public List<MedicineModel> GetAllMedicine(int centerId)
        {
            return _medicineEntryDal.GetAllMedicine(centerId);
        }
        public List<MedicineModel> GetAllMedicine()
        {
            return _medicineEntryDal.GetAllMedicine();
        }
    }
}