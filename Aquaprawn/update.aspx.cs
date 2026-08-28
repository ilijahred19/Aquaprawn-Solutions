using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // USER MUST BE LOGGED IN
            if (Session["email"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Only load data first time, not on button clicks
            if (!IsPostBack)
            {
            #if DEBUG
                txtEmail.Text = Session["email"].ToString();
                txtFname.Text = "Ilijah";
                txtLname.Text = "Red";
                txtOrg.Text = "Aquaprawn Solutions";
                txtPhone.Text = "(555) 014-2025";
            #else
                LoadUserData();
            #endif
            }
        }

        private void LoadUserData()
        {
            string email = Session["email"].ToString();
            txtEmail.Text = email; // locked field

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AquaPrawnConnectionString"].ConnectionString))
            {
                string query = "SELECT CUS_FNAME, CUS_LNAME, CUS_ORG, CUS_PHONE_NUM, CUS_PASS FROM Customer WHERE CUS_EMAIL=@email";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFname.Text = reader["CUS_FNAME"].ToString();
                    txtLname.Text = reader["CUS_LNAME"].ToString();
                    txtOrg.Text = reader["CUS_ORG"].ToString();
                    txtPhone.Text = reader["CUS_PHONE_NUM"].ToString();
                    txtPass.Text = reader["CUS_PASS"].ToString();
                }

                con.Close();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtPass.Text != txtPassConfirm.Text)
            {
                lblStatus.Visible = true;
                lblStatus.Text = "❗ Passwords do not match.";
                return;
            }

            #if DEBUG
                if (!string.IsNullOrWhiteSpace(txtFname.Text))
                {
                    Session["CUS_NAME"] = txtFname.Text.Trim();
                }

                successModal.Visible = true;
                return;
            #endif

            string email = Session["email"].ToString();

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AquaPrawnConnectionString"].ConnectionString))
            {
                string update = @"UPDATE Customer SET 
                          CUS_FNAME=@fname,
                          CUS_LNAME=@lname,
                          CUS_ORG=@org,
                          CUS_PHONE_NUM=@phone,
                          CUS_PASS=@pass
                          WHERE CUS_EMAIL=@email";

                SqlCommand cmd = new SqlCommand(update, con);

                cmd.Parameters.AddWithValue("@fname", txtFname.Text);
                cmd.Parameters.AddWithValue("@lname", txtLname.Text);
                cmd.Parameters.AddWithValue("@org", txtOrg.Text);
                cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@pass", txtPass.Text);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            successModal.Visible = true; // 🔥 Show modal on success
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            successModal.Visible = false;
        }
    }
}
