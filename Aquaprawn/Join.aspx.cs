using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Linq.Expressions;

namespace Aquaprawn
{
    public partial class WebForm2 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btJoin_Click(object sender, EventArgs e)
        {
            
            // 1) Manual Form Safety Checks
            
            if (txtEmail.Text != txtEmailC.Text)
            {
                lblPrimaryKeyError.Text = "Emails must match.";
                return;
            }

            if (txtPass.Text != txtPassC.Text)
            {
                lblPrimaryKeyError.Text = "Passwords must match.";
                return;
            }


            
            // 2) Use SqlDataSource to Insert
           
            SqlDataSource1.InsertParameters["CUS_ORG"].DefaultValue = txtOrganization.Text;
            SqlDataSource1.InsertParameters["CUS_FNAME"].DefaultValue = txtFname.Text;
            SqlDataSource1.InsertParameters["CUS_LNAME"].DefaultValue = txtLname.Text;
            SqlDataSource1.InsertParameters["CUS_START_DATE"].DefaultValue = DateTime.Now.ToString();
            SqlDataSource1.InsertParameters["CUS_PHONE_NUM"].DefaultValue = txtPhone.Text;
            SqlDataSource1.InsertParameters["CUS_EMAIL"].DefaultValue = txtEmail.Text;
            SqlDataSource1.InsertParameters["CUS_PASS"].DefaultValue = txtPass.Text;

            try
            {
                SqlDataSource1.Insert();   

                Session["NewUser"] = "true";
                Session["email"] = txtEmail.Text;
                Session["ShowWelcomeToast"] = "true"; // enables 🦐 toast banner


                string cs = System.Configuration.ConfigurationManager
                    .ConnectionStrings["AquaPrawnConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT CUS_FNAME, CUS_LNAME, CUS_ORG, CUS_PHONE_NUM, CUS_START_DATE " +
                        "FROM Customer WHERE CUS_EMAIL=@email", con);

                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        Session["CUS_NAME"] = dr["CUS_FNAME"].ToString();
                        Session["CUS_ORG"] = dr["CUS_ORG"].ToString();
                        Session["CUS_PHONE"] = dr["CUS_PHONE_NUM"].ToString();
                        Session["CUS_START"] = dr["CUS_START_DATE"].ToString();
                    }
                }

                Session["NewUser"] = "true";   // <-- this triggers 🎉
                Response.Redirect("default.aspx", false); // homepage after sign-up
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                    lblPrimaryKeyError.Text = "That email already exists.";
                else
                    lblPrimaryKeyError.Text = "Registration failed (SQL Error " + ex.Number + ")";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //===============================
            // CLEAR INPUTS
            //===============================
            txtEmail.Text = "";
            txtEmailC.Text = "";
            txtPass.Text = "";
            txtPassC.Text = "";
            txtFname.Text = "";
            txtLname.Text = "";
            txtOrganization.Text = "";
            txtPhone.Text = "";
            lblPrimaryKeyError.Text = "";
        }
    }
}