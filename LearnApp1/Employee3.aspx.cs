using Employee3.DTO;
using EmployeeDetails.BL;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnApp1
{
    public partial class Employee3 : System.Web.UI.Page
    {

        private EmployeeBL ebl;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ebl = new EmployeeBL();
                foreach (var div in ebl.GetDivisions())
                {
                    emp_div.Items.Add(new ListItem(div.divisionName, div.divisionId + ""));
                    if (div.divisionName == "Transportation Enterprise")
                    {
                        List<Manager> _managers = new EmployeeBL().GetManagers(div.divisionId + "");
                        foreach (var _manager in _managers)
                        {
                            manager.Items.Add(new ListItem(_manager.managerName, _manager.managerId + ""));
                        }
                    }
                }
            }
        }
        [System.Web.Services.WebMethod]
        public static string PopulateManager(string _division)
        {
            /*List<Manager> res = new List<Manager>()
            {
                new Manager {managerId = 1,managerName = "Shareek" }
            };*/
            return JsonConvert.SerializeObject(new EmployeeBL().GetManagers(_division));
        }

        [System.Web.Services.WebMethod]
        public static string GetEmployees()
        {
            return JsonConvert.SerializeObject(new EmployeeBL().GetEmployees());
        }

        [System.Web.Services.WebMethod]
        public static string InsertEmp(string _id, string _name, string _date, string _project, int _division, int _manager)
        {
            global::Employee3.DTO.Employee emp = new global::Employee3.DTO.Employee()
            {
                employeeId = Convert.ToInt32(_id),
                employeeName = _name,
                joiningDate = _date,
                project = _project,
                division = _division,
                manager = _manager
            };
            return new EmployeeBL().InsertEmp(emp);
        }

        [System.Web.Services.WebMethod]
        public static string DeleteEmp(string _id)
        {
            return new EmployeeBL().DeleteEmp(_id);
        }
    }
}