<%@ Page Title="My Account" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="MyAccount.aspx.cs" Inherits="Aquaprawn.MyAccount" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
<style>

    /* =========================
           MY ACCOUNT UI
    ========================= */
    .account-container {
        width: 65%;
        margin: 100px auto;
        text-align:center;
        animation: fadeIn 1.1s ease;
        color:#e8faff;
    }

    .account-card {
        background:rgba(9,48,70,0.88);
        padding:55px;
        border-radius:20px;
        box-shadow:0 8px 28px rgba(0,0,0,0.5);
        backdrop-filter:blur(4px);
    }

    .account-title {
        font-size:2.3rem;
        font-weight:800;
        margin-bottom:10px;
    }

    .account-sub {
        opacity:.9;
        font-size:1.1rem;
        margin-bottom:30px;
    }

    /* Buttons */
    .account-btn {
        display:block;
        width:60%;
        margin:14px auto;
        padding:13px;
        font-size:1.1rem;
        border-radius:28px;
        border:none;
        cursor:pointer;
        font-weight:700;
        transition:.35s;
    }

    .btn-update { background:#67defc; color:#013648; }
    .btn-update:hover { background:#94efff; transform:scale(1.05); }

    .btn-delete { background:#ff6c6c; color:white; }
    .btn-delete:hover { background:#ff8888; transform:scale(1.05); }

    .btn-logout { background:#174d63; color:#e6faff; }
    .btn-logout:hover { background:#236a86; transform:scale(1.05); }

    /* Animation */
    @keyframes fadeIn {
        from { opacity:0; transform:translateY(14px);}
        to   { opacity:1; transform:translateY(0); }
    }

    /* Account Info Box */
.info-box{
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.18);
    backdrop-filter:blur(3px);
    padding:25px 30px;
    border-radius:15px;
    margin-bottom:30px;
}

/* Individual Rows */
.info-row{
    display:flex;
    justify-content:space-between;
    padding:10px 0;
    border-bottom:1px solid rgba(255,255,255,0.10);
}
.info-row:last-child{ border-bottom:none; }

/* Label + Value styling */
.label{
    font-weight:700;
    opacity:0.85;
}

.value{
    color:#c6f6ff;
    font-weight:600;
}


</style>
</asp:Content>


<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="account-container">

    <div class="account-card">

        <div class="account-title">My Account</div>
        <div class="account-sub">
            Welcome, <asp:Label ID="lblName" runat="server" />!
        </div>

        <!-- ==============================
              Account Information Summary
        =============================== -->
        <div class="info-box">

            <div class="info-row">
                <span class="label">Email:</span>
                <asp:Label ID="lblEmail" runat="server" CssClass="value"></asp:Label>
            </div>

            <div class="info-row">
                <span class="label">Name:</span>
                <asp:Label ID="lblFullName" runat="server" CssClass="value"></asp:Label>
            </div>

            <div class="info-row">
                <span class="label">Organization:</span>
                <asp:Label ID="lblOrg" runat="server" CssClass="value"></asp:Label>
            </div>

            <div class="info-row">
                <span class="label">Phone:</span>
                <asp:Label ID="lblPhone" runat="server" CssClass="value"></asp:Label>
            </div>

            <div class="info-row">
                <span class="label">Member Since:</span>
                <asp:Label ID="lblDate" runat="server" CssClass="value"></asp:Label>
            </div>

        </div>


        <!-- ACTION BUTTONS -->
        <asp:Button CssClass="account-btn btn-update" Text="Update Account" runat="server" PostBackUrl="~/update.aspx" />
        <asp:Button CssClass="account-btn btn-delete" Text="Delete Account" runat="server" PostBackUrl="~/delete.aspx" />
        <asp:Button CssClass="account-btn btn-logout" Text="Log Off" runat="server" PostBackUrl="~/Logoff.aspx"/>

    </div>
</div>


</asp:Content>

