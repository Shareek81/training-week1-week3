using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using Employee3.DTO;

namespace EmployeeDetail.DL
{
    public class EmployeeDL
    {
        private SqlConnection con;
        public EmployeeDL()
        {
            string conStr = "Data Source=MSHAREE-IN-LE01\\SQLEXPRESS;Initial Catalog=shareek_learn;Integrated Security=True";
            con = new SqlConnection(conStr);
        }

        public List<Division> GetDivisions()
        {
            List<Division> _divisions = new List<Division>();
            con.Open();
            SqlCommand query = new SqlCommand("SELECT * FROM Division", con);
            SqlDataReader data = query.ExecuteReader();
            while (data.Read())
            {
                Division div = new Division();
                div.divisionId = data.GetInt32(0);
                div.divisionName = data.GetString(1);
                _divisions.Add(div);
            }
            data.Close();
            con.Close();
            return _divisions;
        }

        public List<Manager> GetManagers(string _divisionId)
        {
            List<Manager> _managers = new List<Manager>(); 
            con.Open();
            SqlCommand query = new SqlCommand("SELECT * FROM Manager WHERE Division LIKE '"+_divisionId+"'", con);
            SqlDataReader data = query.ExecuteReader();
            while (data.Read())
            {
                Manager m = new Manager();
                m.managerId = data.GetInt32(0);
                m.managerName = data.GetString(1);
                m.division = data.GetInt32(2);
                _managers.Add(m);
            }
            data.Close();
            con.Close();
            return _managers;
        }

        public List<Employee> GetEmployees()
        {
            List<Employee> _employees = new List<Employee>();
            con.Open();
            SqlCommand query = new SqlCommand("SELECT *,(SELECT DivisionName FROM Division WHERE Division.DivisionID=Employees.Division) AS DivisionName,(SELECT ManagerName FROM Manager WHERE Manager.ManagerID = Employees.Manager) AS ManagerName FROM Employees", con);
            SqlDataReader data = query.ExecuteReader();
            while (data.Read())
            {
                Employee emp = new Employee();
                emp.employeeId = data.GetInt32(0);
                emp.employeeName = data.GetString(1);
                emp.joiningDate = data.GetDateTime(2).ToString("dd-MMM-yyyy");
                emp.project = data.GetString(3);
                emp.divisionName = data.GetString(6);
                emp.managerName = data.GetString(7);
                _employees.Add(emp);
            }
            data.Close();
            con.Close();
            return _employees;
        }
        public string InsertEmp(Employee emp)
        {
            SqlCommand sql;
            con.Open();
            sql = new SqlCommand("DELETE FROM Employees WHERE EmployeeID Like '" + emp.employeeId + "'", con);
            sql.ExecuteNonQuery();
            sql = new SqlCommand("INSERT INTO Employees VALUES('"+emp.employeeName+"','"+emp.joiningDate+"','"+emp.project+"',"+emp.division+","+emp.manager+")", con);
            sql.ExecuteNonQuery();
            con.Close();
            return "success";
        }
        public string DeleteEmp(string _id)
        {
            SqlCommand sql;
            con.Open();
            sql = new SqlCommand("DELETE FROM Employees WHERE EmployeeID Like '" + _id + "'", con);
            sql.ExecuteNonQuery();
            con.Close();
            return "success";
        }
    }
}
