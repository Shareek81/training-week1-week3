using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace LearnApp1
{
    public partial class Employee : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBLocal"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlCommand _query;
                SqlDataReader _data;
                con.Open();
                _query = new SqlCommand("SELECT * FROM Division", con);
                _data = _query.ExecuteReader();
                while (_data.Read())
                {
                    emp_div.Items.Add(new ListItem(_data.GetString(1), _data.GetInt32(0) + ""));
                }
                _data.Close();
                _query = new SqlCommand("SELECT DivisionID FROM Division WHERE DivisionName = 'Transportation Enterprise'", con);
                _data = _query.ExecuteReader();
                if (_data.Read())
                {
                    int _divId = _data.GetInt32(0);
                    emp_div.Items.FindByValue(_divId + "").Selected = true;
                    _data.Close();
                    con.Close();
                    setManagers(_divId+"");
                    // Console.WriteLine("Hello");
                }
            }
        }

        protected void setManagers(string divId)
        {
            SqlCommand _query;
            SqlDataReader _data;
            con.Open();
            _query = new SqlCommand("SELECT DISTINCT ManagerID,ManagerName FROM Manager WHERE Division = " + divId, con);
            _data = _query.ExecuteReader();
            while(_data.Read())
            {
                manager.Items.Add(new ListItem(_data.GetString(1), _data.GetInt32(0) + ""));
            }
            _data.Close();
            con.Close();
        }

        [System.Web.Services.WebMethod]
        public static void InsertEmp(string _name, string _date, string _project, int _division, int _manager)
        {
            SqlConnection _con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBLocal"].ConnectionString);
            _con.Open();
            string sql = "INSERT INTO Employees VALUES('"+_name+"','"+_date+"','"+_project+"',"+_division+","+_manager+")";
            new SqlCommand(sql, _con).ExecuteNonQuery();

        }

        protected void emp_div_SelectedIndexChanged(object sender, EventArgs e)
        {
            manager.Items.Clear();
            setManagers(emp_div.SelectedValue);
        }
    }
}