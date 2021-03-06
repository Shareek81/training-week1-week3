using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnApp1
{
    public partial class Shop : System.Web.UI.Page
    {
        SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBLocal"].ConnectionString);

        protected void Page_Init(object sender, EventArgs e)
        {
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Console.WriteLine("Hello");
                myConnection.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM accessories", myConnection);
                SqlDataReader data = cmd.ExecuteReader();
                while (data.Read())
                {
                    product_name.Items.Add(new ListItem(data.GetString(1), data.GetString(1)));
                }
                choosen_product.Text = "Not Yet Choosen";
            }
        }

        protected void product_name_Selected(object sender, EventArgs e)
        {
            choosen_product.Text = product_code.Text+" "+product_name.Text;
        }
    }
}