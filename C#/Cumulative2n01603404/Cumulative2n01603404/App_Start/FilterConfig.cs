using System.Web;
using System.Web.Mvc;

namespace Cumulative2n01603404
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
