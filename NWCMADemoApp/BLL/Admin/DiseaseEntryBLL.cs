using System.Collections.Generic;
using NWCMADemoApp.DAL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.BLL.Admin
{
    public class DiseaseEntryBll
    {
        readonly DiseaseEntryDal _diseaseEntryDal = new DiseaseEntryDal();

        public int SaveDisease(DiseaseModel diseaseModel)
        {
            return _diseaseEntryDal.SaveDisease(diseaseModel);
        }

        public bool IsDiseaseExist(DiseaseModel diseaseModel)
        {
            return _diseaseEntryDal.IsDiseaseExist(diseaseModel);
        }

        public List<DiseaseModel> GetAllDisease()
        {
            return _diseaseEntryDal.GetAllDisease();
        }
    }
}