<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="orderdetails.aspx.cs" Inherits="Aquaprawn.orderdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

/* ========== PAGE TITLES ========== */
.page-title {
    font-size:2.4rem;
    font-weight:800;
    text-align:center;
    margin-top:50px;
    color:#e8faff;
}
.page-sub {
    text-align:center;
    color:#bfeaff;
    opacity:.85;
    margin-top:-6px;
}
hr.title-divider {
    width:60%;
    margin:20px auto 35px;
    border:0;
    height:1px;
    background:rgba(255,255,255,0.12);
}

/* ========== BACK BUTTON ========== */
.back-btn {
    display:inline-block;
    padding:10px 26px;
    background:#67defc;
    color:#013648;
    font-size:1rem;
    font-weight:800;
    border-radius:26px;
    text-decoration:none;
    transition:.3s ease;
}
.back-btn:hover {
    background:#9ef7ff;
    transform:translateY(-2px);
}

/* ========== CARD CONTAINER ========== */
.details-container {
    width:80%;
    margin:0 auto 50px;
    background:rgba(9,48,70,0.92);
    border-radius:22px;
    padding:40px;
    box-shadow:0 10px 30px rgba(0,0,0,.45);
    backdrop-filter:blur(5px);
    color:#e8faff;
}

/* ========== SECTION HEADERS ========== */
.section-header {
    font-size:1.45rem;
    font-weight:800;
    color:#7af6ff;
    margin-bottom:15px;
    padding-bottom:10px;
    border-bottom:2px solid rgba(255,255,255,0.14);
}

/* ========== SUMMARY GRID ========== */
.detail-group {
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(250px, 1fr));
    gap:22px;
    margin-bottom:35px;
}

.detail-box {
    background:#114261;
    padding:18px;
    border-radius:12px;
}
.detail-label {
    color:#9bc2d8;
    font-weight:700;
    font-size:.9rem;
    text-transform:uppercase;
}
.detail-value {
    margin-top:5px;
    font-size:1.1rem;
    font-weight:700;
}

/* ========== ITEMS TABLE ========== */
.items-table {
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    border-radius:12px;
    overflow:hidden;
    box-shadow:0 6px 20px rgba(0,0,0,.35);
}

.items-table th {
    background:#1a537a;
    color:#e9faff;
    padding:14px;
    text-align:left;
    font-weight:700;
}

.items-table td {
    padding:12px 14px;
    background:#0f3c5b;
    color:#dff7ff;
}
.items-table tr:nth-child(even) td { background:#0d3248; }
.items-table tr:hover td { background:#1a577a; transition:.25s; }

.error-message {
    margin-top:20px;
    padding:15px;
    background:rgba(255,55,55,.12);
    border:1px solid #ff7a7a;
    color:#ffb7b7;
    border-radius:12px;
}

</style>

</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- ================= PAGE TITLES ================= -->
<h1 class="page-title">🦐 Order #<asp:Literal ID="litOrderId" runat="server"></asp:Literal> Details</h1>
<p class="page-sub">Summary, shipping, and itemized breakdown</p>
<hr class="title-divider" />


<div class="details-container">

    <!-- ================= ORDER SUMMARY SECTION ================= -->
    <h2 class="section-header">Order Summary & Shipping</h2>

    <asp:SqlDataSource ID="dsOrderHeader" runat="server"
        ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>"
        SelectCommand="
            SELECT ORDER_ID, ORD_SHIPPING, ORD_ADD1, ORD_ADD2,
                   ORD_CITY, ORD_STATE, ORD_PRICE, ORD_ARRIVAL_DATE
            FROM [Order]
            WHERE ORDER_ID = @ORDER_ID">
        <SelectParameters>
            <asp:Parameter Name="ORDER_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:FormView ID="fvOrderSummary" runat="server" DataSourceID="dsOrderHeader">
        <ItemTemplate>

            <div class="detail-group">

                <div class="detail-box">
                    <span class="detail-label">Order ID</span>
                    <span class="detail-value"><%# Eval("ORDER_ID") %></span>
                </div>

                <div class="detail-box">
                    <span class="detail-label">Address Line 1</span>
                    <span class="detail-value"><%# Eval("ORD_ADD1") %></span>
                </div>

                <div class="detail-box">
                    <span class="detail-label">Address Line 2</span>
                    <span class="detail-value"><%# Eval("ORD_ADD2") %></span>
                </div>

                <div class="detail-box">
                    <span class="detail-label">City, State</span>
                    <span class="detail-value"><%# Eval("ORD_CITY") %>, <%# Eval("ORD_STATE") %></span>
                </div>

                <div class="detail-box">
                    <span class="detail-label">Estimated Arrival</span>
                    <span class="detail-value"><%# Eval("ORD_ARRIVAL_DATE", "{0:d}") %></span>
                </div>

                <div class="detail-box" style="grid-column:1 / -1; background:#076d91;">
                    <span class="detail-label">Order Total</span>
                    <span class="detail-value" style="font-size:1.5rem;">
                        <%# Eval("ORD_PRICE", "{0:C}") %>
                    </span>
                </div>

            </div>

        </ItemTemplate>
    </asp:FormView>



    <!-- ================= ITEM BREAKDOWN ================= -->
    <h2 class="section-header">Itemized Breakdown</h2>

    <asp:SqlDataSource ID="dsOrderItems" runat="server"
        ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>"
        SelectCommand="
            SELECT
                I.INV_TYPE + ' - ' + I.INV_DES AS ITEM_NAME,
                OI.ITEM_QTY,
                OI.ITEM_PRICE,
                (OI.ITEM_QTY * OI.ITEM_PRICE) AS LINE_TOTAL
            FROM OrderItems OI
            INNER JOIN Inventory I ON OI.INV_ID = I.INV_ID
            WHERE OI.ORDER_ID = @ORDER_ID">
        <SelectParameters>
            <asp:Parameter Name="ORDER_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="gvOrderItems" runat="server"
        DataSourceID="dsOrderItems"
        CssClass="items-table"
        GridLines="None"
        AutoGenerateColumns="False">

        <Columns>
            <asp:BoundField DataField="ITEM_NAME" HeaderText="Product" />
            <asp:BoundField DataField="ITEM_QTY" HeaderText="Qty" />
            <asp:BoundField DataField="ITEM_PRICE" HeaderText="Unit Price" DataFormatString="{0:C}" />
            <asp:BoundField DataField="LINE_TOTAL" HeaderText="Line Total" DataFormatString="{0:C}" />
        </Columns>

    </asp:GridView>

    <!-- ================= BACK BUTTON ================= -->
<div style="text-align:center; margin-top:25px; margin-bottom:10px;">
    <a href="myorders.aspx" class="back-btn">← 🦐 Back to My Orders</a>
</div>

</div>

</asp:Content>
