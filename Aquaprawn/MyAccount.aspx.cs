using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Aquaprawn
{
    public partial class MyAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["email"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                #if DEBUG
                    lblName.Text = "Ilijah";
                    lblEmail.Text = Session["email"].ToString();
                    lblFullName.Text = "Ilijah Red";
                    lblOrg.Text = "Aquaprawn Solutions";
                    lblPhone.Text = "(555) 014-2025";
                    lblDate.Text = "December 08, 2025";
                    return;
                #endif

                string cs = System.Configuration.ConfigurationManager
                            .ConnectionStrings["AquaPrawnConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(@"
                SELECT CUS_EMAIL, CUS_FNAME, CUS_LNAME, CUS_ORG, CUS_PHONE_NUM, CUS_START_DATE
                FROM Customer WHERE CUS_EMAIL=@email", con);

                    cmd.Parameters.AddWithValue("@email", Session["email"].ToString());
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        lblEmail.Text = dr["CUS_EMAIL"].ToString();
                        lblFullName.Text = $"{dr["CUS_FNAME"]} {dr["CUS_LNAME"]}";
                        lblOrg.Text = dr["CUS_ORG"].ToString();
                        lblPhone.Text = dr["CUS_PHONE_NUM"].ToString();

                        lblDate.Text = Convert.ToDateTime(dr["CUS_START_DATE"])
                                       .ToString("MMMM dd, yyyy");

                        lblName.Text = dr["CUS_FNAME"].ToString();   // <<< THE FIX
                    }
                }
            }
        }

        protected void GoDelete(object sender, EventArgs e)
        {
            Response.Redirect("delete.aspx");
        }
    }
}