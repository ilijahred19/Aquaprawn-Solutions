using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class quote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No login required for a quote
        }

        protected void btJoin_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(SqlDataSource1.ConnectionString))
                using (SqlCommand cmd = new SqlCommand(SqlDataSource1.InsertCommand, con))
                {
                    cmd.Parameters.AddWithValue("@NCUS_PH", txtPH.Text.Trim());
                    cmd.Parameters.AddWithValue("@NCUS_ORG_NAME", txtORGNAME.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                Response.Redirect("quote success.aspx", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                lblError.Text = "Submission failed. Please try again later.";
            }
        }
    }
}