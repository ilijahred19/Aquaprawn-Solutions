<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="Login.aspx.cs" Inherits="Aquaprawn.Login" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ===========================
            LOGIN PAGE UI
        =========================== */
        .login-container {
            width: 45%;
            margin: 85px auto;
            text-align: center;
            animation: fadeIn 1.1s;
        }

        .login-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: #e9faff;
            margin-bottom: 15px;
        }

        .login-sub {
            opacity: 0.85;
            margin-bottom: 28px;
            font-size: 1.02rem;
            color: #daf3fc;
        }

        .login-box {
            background: rgba(9, 48, 70, 0.88);
            padding: 45px 48px;
            border-radius: 20px;
            box-shadow: 0 6px 25px rgba(0,0,0,0.45);
            backdrop-filter: blur(4px);
            text-align: left;
            color: #dff8ff;
        }

        .login-box label {
            font-weight: 700;
            margin-top: 12px;
            display:block;
        }

        .login-box input {
            width: 100%;
            padding:12px;
            border-radius:10px;
            border:none;
            margin-top:6px;
            margin-bottom:16px;
            background:#e7faff;
            font-size:1rem;
        }

        /* 🔥 Login button */
        .btn-login {
            width:100%;
            background:#67defc;
            color:#013648;
            font-weight:800;
            border:none;
            padding:12px;
            border-radius:30px;
            cursor:pointer;
            font-size:1.1rem;
            transition:.35s;
            margin-top:10px;
        }
        .btn-login:hover { background:#94efff; transform:scale(1.05); }

        /* Link to signup */
        .login-footer {
            margin-top:15px;
            text-align:center;
        }
        .login-footer a {
            color:#7fe3ff;
            font-weight:600;
            text-decoration:none;
        }
        .login-footer a:hover { text-decoration:underline; }

        /* Animations */
        @keyframes fadeIn {
            from {opacity:0; transform:translateY(18px);}
            to   {opacity:1; transform:translateY(0);}
        }
    </style>
</asp:Content>


<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">

        <div class="login-title">Welcome!</div>
        <div class="login-sub">Access your Aquaprawn account</div>

        <asp:Label ID="lblLoginError" runat="server" ForeColor="Salmon"></asp:Label>

        <div class="login-box">

            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" />

            <label>Password</label>
            <asp:TextBox ID="txtPass" TextMode="Password" runat="server" />

            <asp:Button ID="btnLogin" Text="Login" runat="server" CssClass="btn-login" OnClick="btnLogin_Click"/>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>" DeleteCommand="DELETE FROM [Customer] WHERE [CUS_ID] = @CUS_ID" InsertCommand="INSERT INTO [Customer] ([CUS_ORG], [CUS_FNAME], [CUS_LNAME], [CUS_START_DATE], [CUS_PHONE_NUM], [CUS_EMAIL], [CUS_PASS]) VALUES (@CUS_ORG, @CUS_FNAME, @CUS_LNAME, @CUS_START_DATE, @CUS_PHONE_NUM, @CUS_EMAIL, @CUS_PASS)" SelectCommand="SELECT * FROM [Customer] WHERE ([CUS_EMAIL] = @CUS_EMAIL)" UpdateCommand="UPDATE [Customer] SET [CUS_ORG] = @CUS_ORG, [CUS_FNAME] = @CUS_FNAME, [CUS_LNAME] = @CUS_LNAME, [CUS_START_DATE] = @CUS_START_DATE, [CUS_PHONE_NUM] = @CUS_PHONE_NUM, [CUS_EMAIL] = @CUS_EMAIL, [CUS_PASS] = @CUS_PASS WHERE [CUS_ID] = @CUS_ID">
                <DeleteParameters>
                    <asp:Parameter Name="CUS_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CUS_ORG" Type="String" />
                    <asp:Parameter Name="CUS_FNAME" Type="String" />
                    <asp:Parameter Name="CUS_LNAME" Type="String" />
                    <asp:Parameter DbType="Date" Name="CUS_START_DATE" />
                    <asp:Parameter Name="CUS_PHONE_NUM" Type="String" />
                    <asp:Parameter Name="CUS_EMAIL" Type="String" />
                    <asp:Parameter Name="CUS_PASS" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="CUS_EMAIL" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CUS_ORG" Type="String" />
                    <asp:Parameter Name="CUS_FNAME" Type="String" />
                    <asp:Parameter Name="CUS_LNAME" Type="String" />
                    <asp:Parameter DbType="Date" Name="CUS_START_DATE" />
                    <asp:Parameter Name="CUS_PHONE_NUM" Type="String" />
                    <asp:Parameter Name="CUS_EMAIL" Type="String" />
                    <asp:Parameter Name="CUS_PASS" Type="String" />
                    <asp:Parameter Name="CUS_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>

        <div class="login-footer">
            Not a member yet? <a href="Join.aspx">Register Here</a>
        </div>
    </div>
</asp:Content>
