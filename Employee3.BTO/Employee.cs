using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Employee3.DTO
{
    public class Employee
    {
        public int employeeId { get; set; }
        public string employeeName { get; set; }
        public string joiningDate { get; set; }
        public string project { get; set; }
        public int division { get; set; }
        public int manager { get; set; }
        public string divisionName { get; set; }
        public string managerName { get; set; }
    }
}
