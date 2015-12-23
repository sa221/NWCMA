using System.Collections.Generic;
using NWCMADemoApp.DAL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.BLL.Admin
{
    public class CreateCenterBll
    {
        readonly CreateCenterDal _createCenterDal = new CreateCenterDal();

        public List<DistrictModel> GetAllDistrict()
        {
            return _createCenterDal.GetAllDistrict();
        }


        public List<ThanaModel> GetAllThana(DistrictModel districtModel)
        {
            return _createCenterDal.GetAllThana(districtModel);
        }




        //dfrd dfgrsgre




        public int SaveCenter(CenterModel centerModel)
        {
            return _createCenterDal.SaveCenter(centerModel);
        }

        public bool IsCenterExist(CenterModel centerModel)
        {
            return _createCenterDal.IsCenterExist(centerModel);
        }

        public List<CenterModel> GetAllCenter()
        {
            return _createCenterDal.GetAllCenter();
        }
    }
}