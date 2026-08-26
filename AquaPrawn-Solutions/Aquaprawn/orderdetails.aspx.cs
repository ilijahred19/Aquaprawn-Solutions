using System;
using System.Web.UI;

namespace Aquaprawn
{
    public partial class orderdetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Require login
                if (Session["CUS_ID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Validate orderId parameter
                if (int.TryParse(Request.QueryString["orderid"], out int orderId))
                {
                    LoadOrderDetails(orderId);
                }
                else
                {
                    Response.Write("<div class='error-message'>Invalid Order ID.</div>");
                }
            }
        }

        private void LoadOrderDetails(int orderId)
        {
            // Display Order ID
            litOrderId.Text = orderId.ToString();

            // Set parameters
            dsOrderHeader.SelectParameters["ORDER_ID"].DefaultValue = orderId.ToString();
            dsOrderItems.SelectParameters["ORDER_ID"].DefaultValue = orderId.ToString();

            // Bind data
            fvOrderSummary.DataBind();
            gvOrderItems.DataBind();

            // Basic validation
            if (fvOrderSummary.DataItemCount == 0)
            {
                Response.Write("<div class='error-message'>Order not found or unauthorized.</div>");
            }
        }
    }
}
