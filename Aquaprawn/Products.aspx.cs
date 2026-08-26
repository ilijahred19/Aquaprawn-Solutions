using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool loggedIn = Session["email"] != null;

            // Update product buttons
            btn21_25.InnerText = loggedIn ? "Place Order" : "Request Quote";
            btn16_20.InnerText = loggedIn ? "Place Order" : "Request Quote";
            btnU15.InnerText = loggedIn ? "Place Order" : "Request Quote";

            // Modal version
            modalBtn.Text = loggedIn ? "Place Order" : "Request Quote";
            modalBtn.Style["background"] = loggedIn ? "#1fff8e" : "#6ddfff";
            modalBtn.Style["color"] = loggedIn ? "#003a17" : "#013648";
        }
        protected void ModalBtn_Click(object sender, EventArgs e)
        {
            if (Session["email"] != null)
            {
                Response.Redirect("orders.aspx", true);
            }
            else
            {
                Response.Redirect("quote.aspx", true);
            }
        }
    }
}