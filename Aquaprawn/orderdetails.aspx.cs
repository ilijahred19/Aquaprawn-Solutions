using System;
using System.Data;
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

#if DEBUG
                int demoOrderId;

                if (!int.TryParse(Request.QueryString["orderid"], out demoOrderId))
                {
                    demoOrderId = 1048;
                }

                LoadDemoOrderDetails(demoOrderId);
                return;
#endif

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
        private void LoadDemoOrderDetails(int orderId)
        {
            litOrderId.Text = orderId.ToString();

            DataTable orderSummary = new DataTable();

            orderSummary.Columns.Add("ORDER_ID", typeof(int));
            orderSummary.Columns.Add("ORD_ADD1", typeof(string));
            orderSummary.Columns.Add("ORD_ADD2", typeof(string));
            orderSummary.Columns.Add("ORD_CITY", typeof(string));
            orderSummary.Columns.Add("ORD_STATE", typeof(string));
            orderSummary.Columns.Add("ORD_PRICE", typeof(decimal));
            orderSummary.Columns.Add("ORD_ARRIVAL_DATE", typeof(DateTime));

            orderSummary.Rows.Add(
                orderId,
                "123 Ocean Drive",
                "Suite 202",
                "Dallas",
                "TX",
                87.96m,
                DateTime.Today.AddDays(2)
            );

            fvOrderSummary.DataSourceID = string.Empty;
            fvOrderSummary.DataSource = orderSummary;
            fvOrderSummary.DataBind();

            DataTable orderItems = new DataTable();

            orderItems.Columns.Add("ITEM_NAME", typeof(string));
            orderItems.Columns.Add("ITEM_QTY", typeof(int));
            orderItems.Columns.Add("ITEM_PRICE", typeof(decimal));
            orderItems.Columns.Add("LINE_TOTAL", typeof(decimal));

            orderItems.Rows.Add(
                "21/25 Count - Premium Grade",
                2,
                18.99m,
                37.98m
            );

            orderItems.Rows.Add(
                "U/15 Count - Signature Large",
                2,
                24.99m,
                49.98m
            );

            gvOrderItems.DataSourceID = string.Empty;
            gvOrderItems.DataSource = orderItems;
            gvOrderItems.DataBind();
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
