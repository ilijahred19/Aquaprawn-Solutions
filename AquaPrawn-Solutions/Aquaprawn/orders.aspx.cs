using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aquaprawn
{
    public partial class orders : System.Web.UI.Page
    {
        public class InventoryItem
        {
            public int InvId { get; set; }
            public string Description { get; set; }
            public decimal SalePrice { get; set; }
        }

        public class CartItem
        {
            public int InvId { get; set; }
            public int Quantity { get; set; }
            public decimal Price { get; set; }
            public decimal Subtotal => Quantity * Price;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Login.aspx", true);
                return;
            }

            if (!IsPostBack)
                LoadInventory();
        }


        private void LoadInventory()
        {
            List<InventoryItem> items = new List<InventoryItem>();
            string connectionString = SqlDataSource1.ConnectionString;

            string query = @"
                SELECT INV_ID, INV_TYPE, INV_DES, INV_SALE_PRICE
                FROM Inventory 
                WHERE INV_EXTERNAL_SALE = 1 AND INV_QTY > 0 AND INV_SALE_PRICE IS NOT NULL";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        items.Add(new InventoryItem
                        {
                            InvId = (int)r["INV_ID"],
                            Description = $"{r["INV_TYPE"]} - {r["INV_DES"]}",
                            SalePrice = (decimal)r["INV_SALE_PRICE"]
                        });
                    }
                }
            }

            Session["CurrentInventory"] = items;
            rptProducts.DataSource = items;
            rptProducts.DataBind();
        }



        protected void btn_Place(object sender, EventArgs e)
        {
            var inventory = Session["CurrentInventory"] as List<InventoryItem>;
            if (inventory == null) return;

            List<CartItem> cart = new List<CartItem>();
            int totalQty = 0;
            decimal totalPrice = 0;

            foreach (var item in inventory)
            {
                string inputName = "qty_" + item.InvId;
                string qtyString = Request.Form[inputName];

                if (int.TryParse(qtyString, out int qty) && qty > 0)
                {
                    CartItem c = new CartItem
                    {
                        InvId = item.InvId,
                        Quantity = qty,
                        Price = item.SalePrice
                    };
                    cart.Add(c);
                    totalQty += qty;
                    totalPrice += c.Subtotal;
                }
            }

            if (cart.Count == 0) return;

            string connectionString = SqlDataSource1.ConnectionString;
            int customerId = Convert.ToInt32(Session["CUS_ID"]);

            int newOrderId = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // INSERT ORDER HEADER
                    string insertOrderSql = @"
                        INSERT INTO [Order] 
                        (ORD_DATE, ORD_ARRIVAL_DATE, ORD_QTY, ORD_PRICE,
                         ORD_ADD1, ORD_ADD2, ORD_CITY, ORD_STATE, ORD_ZIP,
                         ORD_CCNUM, ORD_EXP, CUS_ID)
                        VALUES
                        (@Date, @Arrival, @Qty, @Price,
                         @Add1, @Add2, @City, @State, @Zip,
                         @CC, @Exp, @Customer);

                        SELECT SCOPE_IDENTITY();";

                    using (SqlCommand cmd = new SqlCommand(insertOrderSql, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@Date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Arrival", DateTime.Now.AddDays(2));
                        cmd.Parameters.AddWithValue("@Qty", totalQty);
                        cmd.Parameters.AddWithValue("@Price", totalPrice);

                        cmd.Parameters.AddWithValue("@Add1", txtAddress1.Text);
                        cmd.Parameters.AddWithValue("@Add2", txtAddress2.Text);
                        cmd.Parameters.AddWithValue("@City", txtCity.Text);
                        cmd.Parameters.AddWithValue("@State", txtState.Text);
                        cmd.Parameters.AddWithValue("@Zip", txtZip.Text);

                        cmd.Parameters.AddWithValue("@CC", txtCCNum.Text);
                        cmd.Parameters.AddWithValue("@Exp", txtExp.Text);

                        cmd.Parameters.AddWithValue("@Customer", customerId);

                        newOrderId = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    // INSERT ORDER ITEMS + UPDATE STOCK
                    string insertItemSql = @"
                        INSERT INTO OrderItems (ORDER_ID, INV_ID, ITEM_QTY, ITEM_PRICE)
                        VALUES (@OrderId, @InvId, @Qty, @Price);";

                    string updateStockSql = @"
                        UPDATE Inventory SET INV_QTY = INV_QTY - @Qty
                        WHERE INV_ID = @InvId;";

                    foreach (var item in cart)
                    {
                        using (SqlCommand cmd = new SqlCommand(insertItemSql, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@OrderId", newOrderId);
                            cmd.Parameters.AddWithValue("@InvId", item.InvId);
                            cmd.Parameters.AddWithValue("@Qty", item.Quantity);
                            cmd.Parameters.AddWithValue("@Price", item.Price);
                            cmd.ExecuteNonQuery();
                        }

                        using (SqlCommand cmd = new SqlCommand(updateStockSql, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@InvId", item.InvId);
                            cmd.Parameters.AddWithValue("@Qty", item.Quantity);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    try
                    {
                        transaction.Rollback();
                    }
                    catch { }

                    ShowClientMessage("Error", "Order placement failed: " + ex.Message);
                    return;
                }
            }

            Response.Redirect("order success.aspx", true);
        }



        private void ShowClientMessage(string title, string message)
        {
            string script = $"alert('{title}: {message}');";
            ClientScript.RegisterStartupScript(this.GetType(), "msg", script);
        }
    }
}
