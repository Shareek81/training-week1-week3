using Employee3.DTO;
using EmployeeDetail.DL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmployeeDetails.BL
{
    public class EmployeeBL
    {
        EmployeeDL edl;
        public EmployeeBL()
        {
            edl = new EmployeeDL();
        }
        public List<Division> GetDivisions()
        {
            return edl.GetDivisions();
        }

        public List<Manager> GetManagers(string _divisionId)
        {
            return edl.GetManagers(_divisionId);
        }
        public List<Employee> GetEmployees()
        {
            return edl.GetEmployees();
        }
        public string InsertEmp(Employee emp)
        {
            return edl.InsertEmp(emp);
        }
        public string DeleteEmp(string _id)
        {
            return edl.DeleteEmp(_id);
        }
    }
}
