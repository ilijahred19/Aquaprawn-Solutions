<%@ Page Title="Place Order" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="orders.aspx.cs" Inherits="Aquaprawn.orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

/* ======================== PAGE TITLE ======================== */
.page-title {
    font-size:2.4rem;
    font-weight:800;
    margin-top:40px;
    color:#e8faff;
    text-align:center;
}

.page-sub {
    text-align:center;
    color:#bfeaff;
    opacity:.85;
    margin-top:-6px;
    margin-bottom:35px;
}

.order-form-container {
    width:90%;
    margin:0 auto 50px;
    background:rgba(9,48,70,0.92);
    box-shadow:0 10px 35px rgba(0,0,0,.45);
    backdrop-filter:blur(5px);
    padding:45px;
    border-radius:22px;
}

/* ======================== REPEATER PRODUCT LIST ======================== */
.product-item {
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#0e3a51;
    padding:18px;
    border-radius:14px;
    margin-bottom:14px;
    box-shadow:0 4px 12px rgba(0,0,0,.35);
}

.product-name {
    font-size:1.1rem;
    font-weight:700;
    color:#e9faff;
}

.product-price {
    font-size:1rem;
    color:#8feaff;
}

/* Quantity Input */
.qty-input {
    width:80px;
    padding:8px;
    border-radius:10px;
    border:2px solid #1c70a6;
    background:#062033;
    color:white;
    text-align:center;
    font-weight:bold;
    font-size:1rem;
}

/* ======================== CHECKOUT FORM ======================== */
.checkout-grid {
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:28px;
    margin-top:40px;
}

.form-section {
    background:rgba(14,60,82,.65);
    padding:28px;
    border-radius:18px;
    border:1px solid rgba(255,255,255,.08);
    box-shadow:0 6px 18px rgba(0,0,0,.4);
}

.form-section h3 {
    font-size:1.35rem;
    font-weight:800;
    color:#7af6ff;
    border-bottom:2px solid rgba(255,255,255,.12);
    padding-bottom:10px;
    margin-bottom:20px;
}

.form-group label {
    display:block;
    font-weight:600;
    margin-bottom:5px;
    opacity:.8;
    color:#bfeaff;
}

.form-control {
    width:100%;
    padding:12px;
    font-size:1rem;
    border-radius:10px;
    border:none;
    background:#012b3c;
    color:white;
    box-shadow:inset 0 0 8px rgba(0,0,0,.25);
}
.form-control:focus {
    outline:none;
    border:1px solid #7af6ff;
    box-shadow:0 0 8px rgba(122,246,255,.5);
}

/* ======================== SUBMIT BUTTON ======================== */
.btn-checkout {
    width:100%;
    padding:15px;
    font-size:1.3rem;
    font-weight:800;
    border:none;
    border-radius:30px;
    background:#67defc;
    color:#013648;
    cursor:pointer;
    transition:.35s;
    margin-top:20px;
}

.btn-checkout:hover {
    transform:scale(1.05);
    background:#9ef7ff;
}

.full-width {
    grid-column:1 / -1;
    margin-top:18px;
}

</style>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>" 
    SelectCommand="SELECT * FROM [Inventory] WHERE ([INV_EXTERNAL_SALE] = @INV_EXTERNAL_SALE)">
    <SelectParameters>
        <asp:Parameter DefaultValue="1" Name="INV_EXTERNAL_SALE" Type="Boolean" />
    </SelectParameters>
</asp:SqlDataSource>


<h1 class="page-title">🦐 Place Your Order</h1>
<p class="page-sub">Select quantities, enter shipping details, and confirm your purchase.</p>

<div class="order-form-container">

    <!-- ============= PRODUCT LIST ============= -->
    <asp:Repeater ID="rptProducts" runat="server">
        <ItemTemplate>
            <div class="product-item">
                <div class="product-info">
                    <div class="product-name"><%# Eval("Description") %></div>
                    <div class="product-price"><%# Eval("SalePrice", "{0:C}") %> / unit</div>
                </div>

                <div class="quantity-control">
                    <label>Qty</label>
                    <input type="number"
                           name='qty_<%# Eval("InvId") %>'
                           class="qty-input"
                           min="0" value="0" />
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>


    <!-- ============= CHECKOUT FORM ============= -->
    <div class="checkout-grid">

        <!-- SHIPPING -->
        <div class="form-section">
            <h3>Shipping Address</h3>

            <div class="form-group">
                <label>Address Line 1</label>
                <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" placeholder="123 Ocean Drive"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAdd1" runat="server" ControlToValidate="txtAddress1" ForeColor="#ff6b6b" ErrorMessage="Required" />
            </div>

            <div class="form-group">
                <label>Address Line 2 (Optional)</label>
                <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>City</label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>State</label>
                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Zip Code</label>
                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>


        <!-- PAYMENT -->
        <div class="form-section">
            <h3>Payment Information</h3>

            <div class="form-group">
                <label>Card Number</label>
                <asp:TextBox ID="txtCCNum" runat="server" CssClass="form-control" placeholder="XXXX-XXXX-XXXX-XXXX"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Expiration (MM/YY)</label>
                <asp:TextBox ID="txtExp" runat="server" CssClass="form-control" placeholder="MM/YY"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>CVV</label>
                <input type="text" class="form-control" style="width:90px;" placeholder="123" />
            </div>
        </div>

        <!-- SUBMIT -->
        <div class="full-width">
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Confirm & Place Order"
                CssClass="btn-checkout" OnClick="btn_Place" />
        </div>

    </div>

</div>

</asp:Content>
