using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Helpers
{
    static class ServiceHelper<SearchObject, Model> where SearchObject : class where Model : class
    {
        public static async Task<List<Model>> Load(string apiRoute, ComboBox cmb, string displayMember, string valueMember, SearchObject searchObject = null)
        {
            var service = new APIService(apiRoute);
            List<Model> models = await service.Get<List<Model>>(searchObject);
            cmb.DataSource = models;
            cmb.DisplayMember = displayMember;
            cmb.ValueMember = valueMember;

            return models;
        }
    }
}



