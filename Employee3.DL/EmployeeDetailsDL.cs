using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data.SqlClient;

namespace Employee3.DL
{
    public class EmployeeDetailsDL
    {
        private SqlConnection con;
        public EmployeeDetailsDL()
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBLocal"].ConnectionString);
        }
        public List<DTO.Division> GetDivisions()
        {
            List<DTO.Division> _divisions = new List<DTO.Division>();
            con.Open();
            SqlCommand query = new SqlCommand("SELECT * FROM Division");
            SqlDataReader data = query.ExecuteReader();
            while (data.Read())
            {
                DTO.Division _div = new DTO.Division();
                _div.DivisionID = data.GetInt32(0);
                _div.DivisionName = data.GetString(1);
                _divisions.Add(_div);
            }
            data.Close();
            con.Close();
            return _divisions;
        }
    }
}
