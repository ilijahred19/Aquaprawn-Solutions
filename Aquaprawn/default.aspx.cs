using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ShowWelcomeToast"] != null)
            {
                welcomeToast.Visible = true;  // 🔥 enables UI banner
                Session.Remove("ShowWelcomeToast");
            }
        }

    }
}