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

                LoadCustomerOrders();
            }
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
