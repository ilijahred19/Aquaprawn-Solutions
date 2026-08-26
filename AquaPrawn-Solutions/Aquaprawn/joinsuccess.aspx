<%@ Page Title="Registration Success" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="joinsuccess.aspx.cs" Inherits="Aquaprawn.joinsuccess" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ============================
           SUCCESS PAGE UI
        ============================ */
        .success-wrapper {
            width: 70%;
            margin: 100px auto;
            text-align: center;
            animation: fadeIn 1.2s ease;
            color: #e7faff;
        }

        .success-card {
            background: rgba(9, 48, 70, 0.85);
            padding: 60px 50px;
            border-radius: 20px;
            box-shadow: 0 8px 28px rgba(0,0,0,0.55);
            backdrop-filter: blur(3px);
        }

        .success-icon {
            font-size: 4.2rem;
            font-weight: bold;
            color: #67defc;
            animation: popIn .9s ease;
        }

        .success-wrapper h2 {
            margin-top: 18px;
            font-size: 2.2rem;
            font-weight: 800;
        }

        .success-wrapper p {
            opacity: 0.9;
            font-size: 1.1rem;
            margin-top: 10px;
            margin-bottom: 30px;
        }

        .btn-login {
            background: #67defc;
            color: #013648;
            font-weight: 700;
            border:none;
            padding: 12px 36px;
            border-radius: 30px;
            cursor:pointer;
            font-size:1.1rem;
            transition:.3s;
            text-decoration:none;
        }

        .btn-login:hover {
            background:#94efff;
            transform:scale(1.06);
        }

        /* Animations */
        @keyframes fadeIn {
            from {opacity:0; transform:translateY(20px);}
            to {opacity:1; transform:translateY(0);}
        }

        @keyframes popIn {
            0% {transform:scale(0.3); opacity:0;}
            80% {transform:scale(1.2);}
            100% {transform:scale(1); opacity:1;}
        }
    </style>
</asp:Content>


<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="success-wrapper">
        <div class="success-card">

            <div class="success-icon">✔</div>

            <h2>Welcome to Aquaprawn.</h2>
            <p>Your registration was successful! You now have access to the system.</p>

            <a href="Login.aspx" class="btn-login">Proceed to Login</a>

        </div>
    </div>

</asp:Content>
