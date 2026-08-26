<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="myorders.aspx.cs" Inherits="Aquaprawn.myorders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>

/* ===================== PAGE TITLE ===================== */
.page-title {
    font-size:2.4rem;
    color:white;
    font-weight:800;
    text-align:center;
    margin-top:40px;
    margin-bottom:10px;
}

.page-sub {
    text-align:center;
    opacity:.85;
    color:#cdefff;
    margin-bottom:25px;
    font-size:1rem;
}

hr.section-divider {
    width:60%;
    margin:0 auto 30px;
    border:0;
    height:1px;
    background:rgba(255,255,255,0.15);
}

/* ===================== CARD CONTAINER ===================== */
.order-history-container {
    background:rgba(9,48,70,0.92);
    backdrop-filter:blur(4px);
    border:1px solid rgba(255,255,255,.08);
    padding:35px;
    border-radius:20px;
    box-shadow:0 8px 26px rgba(0,0,0,.45);
    width:80%;
    margin:0 auto;
}

/* ===================== GRIDVIEW ===================== */
.orders-grid-view {
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    border-radius:12px;
    overflow:hidden;
    box-shadow:0 8px 20px rgba(0,0,0,.35);
}

.orders-grid-view th {
    background:#1a537a;
    color:#e9faff;
    font-size:1rem;
    font-weight:700;
    padding:14px;
    text-align:left;
    letter-spacing:.4px;
}

.orders-grid-view td {
    background:#103d58;
    color:#dff7ff;
    padding:12px 14px;
    border-bottom:1px solid rgba(255,255,255,.05);
}

.orders-grid-view tr:nth-child(even) td {
    background:#0d3248;
}

.orders-grid-view tr:hover td {
    background:#1a577a;
    transition:.2s ease;
}

/* ===================== EMPTY STATE ===================== */
.empty-orders {
    padding:30px;
    text-align:center;
    color:#bfeaff;
    font-size:1.2rem;
}

.empty-orders a {
    color:#67defc;
    font-weight:700;
    text-decoration:none;
}

/* ERROR MESSAGE */
.error-message {
    margin-top:20px;
    padding:14px;
    border-radius:12px;
    background:rgba(255,50,50,.1);
    border:1px solid #ff6b6b;
    color:#ffb3b3;
    font-weight:700;
}

</style>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- SQL SOURCE -->
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>"
    SelectCommand="SELECT * FROM [Order] WHERE ([CUS_ID] = @CUS_ID) ORDER BY [ORDER_ID] DESC">
    <SelectParameters>
        <asp:Parameter Name="CUS_ID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>


<!-- ===================== TITLE ===================== -->
<h1 class="page-title">🦐 Your Recent Orders</h1>
<p class="page-sub">Track your purchases, arrivals, and order details.</p>
<hr class="section-divider" />


<!-- ===================== ORDER CARD ===================== -->
<div class="order-history-container">

<asp:GridView ID="gvMyOrders" runat="server"
    AutoGenerateColumns="false"
    CssClass="orders-grid-view"
    GridLines="None"
    DataKeyNames="ORDER_ID">

    <Columns>

        <asp:BoundField DataField="ORDER_ID" HeaderText="Order #" />
        <asp:BoundField DataField="ORD_Date" HeaderText="Date Placed" DataFormatString="{0:d}" />
        <asp:BoundField DataField="ORD_PRICE" HeaderText="Total" DataFormatString="{0:C}" />
        <asp:BoundField DataField="ORD_ARRIVAL_DATE" HeaderText="Arrival" DataFormatString="{0:d}" />
        <asp:HyperLinkField Text="View Details"
            DataNavigateUrlFields="ORDER_ID"
            DataNavigateUrlFormatString="orderdetails.aspx?orderid={0}" />

    </Columns>

    <EmptyDataTemplate>
        <!-- CUSTOM EMPTY TEMPLATE -->
        <div class="empty-orders">
            You have no previous orders yet.<br/><br/>
            <a href="products.aspx">Browse the Catalog →</a>
        </div>
    </EmptyDataTemplate>

</asp:GridView>


</div>

</asp:Content>
