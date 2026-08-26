<%@ Page Title="Logout" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Logoff.aspx.cs" Inherits="Aquaprawn.Logoff" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
<style>
    /* ==========================
       LOGOFF PAGE UI
    ========================== */
    .logout-container {
        width: 70%;
        margin: 120px auto;
        text-align:center;
        animation: fadeIn 1.1s ease;
        color: #e7faff;
    }

    .logout-card {
        background: rgba(9, 48, 70, 0.85);
        padding: 60px 50px;
        border-radius: 20px;
        box-shadow: 0 8px 28px rgba(0,0,0,0.55);
        backdrop-filter: blur(3px);
    }

    .logout-icon {
        font-size: 4rem;
        color: #67defc;
        animation: popIn .8s ease;
    }

    .logout-container h2 {
        margin-top:15px;
        font-size:2.1rem;
        font-weight:800;
    }

    .logout-container p {
        opacity:0.85;
        font-size:1.1rem;
        margin-top:10px;
        margin-bottom:30px;
    }

    .btn-home {
        background:#67defc;
        color:#013648;
        border:none;
        padding:12px 38px;
        border-radius:30px;
        font-weight:700;
        text-decoration:none;
        font-size:1.09rem;
        transition:.35s;
        display:inline-block;
        margin-top:5px;
    }
    .btn-home:hover {
        background:#94efff;
        transform:scale(1.05);
    }

    /* Animations */
    @keyframes fadeIn {
        from {opacity:0; transform:translateY(18px);}
        to   {opacity:1; transform:translateY(0);}
    }
    @keyframes popIn {
        0% {transform:scale(0.3); opacity:0;}
        75%{transform:scale(1.2);}
        100%{transform:scale(1);}
    }
</style>
</asp:Content>


<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="logout-container">
        <div class="logout-card">

            <div class="logout-icon">🔒</div>

            <h2>You’ve been logged out.</h2>
            <p>Thank you for visiting Aquaprawn!</p>

            <a href="default.aspx" class="btn-home">Return Now</a>

        </div>
    </div>
</asp:Content>
