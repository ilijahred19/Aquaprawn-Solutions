using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters["CUS_EMAIL"].DefaultValue = txtEmail.Text.Trim();

            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            if (dv.Count > 0)
            {
                string storedPass = dv[0]["CUS_PASS"].ToString();

                if (storedPass == txtPass.Text.Trim())
                {
                    // Login Success
                    Session["CUS_ID"] = dv[0]["CUS_ID"].ToString();
                    Session["CUS_NAME"] = dv[0]["CUS_FNAME"].ToString();
                    Session["email"] = txtEmail.Text;

                    // Trigger login success modal (new!)
                    Session["LoginSuccess"] = "true";

                    Response.Redirect("default.aspx", false);
                }
                else
                {
                    lblLoginError.Text = "Incorrect password.";
                }
            }
            else
            {
                lblLoginError.Text = "Email not found.";
            }

        }
    }
}