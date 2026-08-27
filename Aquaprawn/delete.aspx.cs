using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Aquaprawn
{
    public partial class delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Must match MyAccount + Login session name
            if (Session["email"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Session["email"] != null)
                {
                    emailDisplay.InnerText = Session["email"].ToString();
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string sessionEmail = Session["email"].ToString();
            string typedEmail = txtConfirmEmail.Text.Trim();

            if (typedEmail != sessionEmail)
            {
                Response.Write("<script>alert('Email does not match.');</script>" );
                return;
            }

            if (Context.IsDebuggingEnabled)
            {
                Session.Clear();
                Session.Abandon();

                Response.Redirect("deleteSuccess.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            using (SqlConnection con = new SqlConnection(SqlDataSource1.ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(SqlDataSource1.DeleteCommand, con);
                cmd.Parameters.AddWithValue("@CUS_EMAIL", sessionEmail);
                cmd.ExecuteNonQuery();
            }

            Session.Abandon();
            Response.Redirect("deleteSuccess.aspx");
        }
    }
}
