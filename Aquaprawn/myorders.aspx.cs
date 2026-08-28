using System.Data;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class myorders : System.Web.UI.Page
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
                LoadDemoOrders();
#else
                LoadCustomerOrders();
#endif
            }
        }

        private void LoadDemoOrders()
        {
            DataTable orders = new DataTable();

            orders.Columns.Add("ORDER_ID", typeof(int));
            orders.Columns.Add("ORD_Date", typeof(DateTime));
            orders.Columns.Add("ORD_PRICE", typeof(decimal));
            orders.Columns.Add("ORD_ARRIVAL_DATE", typeof(DateTime));

            orders.Rows.Add(
                1048,
                DateTime.Today.AddDays(-3),
                87.96m,
                DateTime.Today.AddDays(2)
            );

            orders.Rows.Add(
                1047,
                DateTime.Today.AddDays(-30),
                137.94m,
                DateTime.Today.AddDays(-28)
            );

            gvMyOrders.DataSourceID = string.Empty;
            gvMyOrders.DataSource = orders;
            gvMyOrders.DataBind();
        }
        private void LoadCustomerOrders()
        {
            object customerId = Session["CUS_ID"];
            if (customerId == null) return;

            ContentPlaceHolder cp = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
            SqlDataSource ds = cp?.FindControl("SqlDataSource1") as SqlDataSource;

            if (ds == null)
            {
                Response.Write("<div class='error-message'>Could not locate order data source.</div>");
                return;
            }

            try
            {
                ds.SelectParameters["CUS_ID"].DefaultValue = customerId.ToString();
            }
            catch (Exception ex)
            {
                Response.Write($"<div class='error-message'>Parameter Error: {ex.Message}</div>");
                return;
            }

            GridView gvMyOrders = cp.FindControl("gvMyOrders") as GridView;
            if (gvMyOrders != null)
            {
                try
                {
                    gvMyOrders.DataSourceID = "SqlDataSource1";
                    gvMyOrders.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write($"<div class='error-message'>Data Error: {ex.Message}</div>");
                }
            }
        }
    }
}
