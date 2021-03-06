using Employee3.DL;
using System;
using System.Collections.Generic;

namespace Employee3.BL
{
    public class EmployeeDetailsBL
    {
        private EmployeeDetailsDL edl;
        public EmployeeDetailsBL()
        {
            edl = new EmployeeDetailsDL();
        }
        public List<DTO.Division> GetDivisions()
        {
            return edl.GetDivisions();
        }
    }
}
