using System.Collections.Generic;
using NWCMADemoApp.DAL.Center;
using NWCMADemoApp.Models.AdminModel;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.BLL.Center
{
    public class DoctorEntryBll
    {
        readonly DoctorEntryDal _doctorEntryDal = new DoctorEntryDal();

        public List<CenterModel> GetAllCenter()
        {
            return _doctorEntryDal.GetAllCenter();
        }
        public int SaveDoctor(DoctorModel doctorModel)
        {
            return _doctorEntryDal.SaveDoctor(doctorModel);
        }
        public List<DoctorModel> GetAllDoctor(int loginId)
        {
            return _doctorEntryDal.GetAllDoctor(loginId);
        }
    }
}