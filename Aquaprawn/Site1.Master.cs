using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool loggedIn = Session["email"] != null;

            phGuest.Visible = !loggedIn;
            phUser.Visible = loggedIn;
        }
    }
}