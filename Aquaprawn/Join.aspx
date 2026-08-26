<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Join.aspx.cs" Inherits="Aquaprawn.WebForm2" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ============================
           REGISTER PAGE UI
        ============================ */
        .register-container {
            width: 60%;
            margin: 60px auto;
            text-align: center;
            animation: fadeIn 1s;
        }

        .register-container h2 {
            font-size: 2rem;
            font-weight: 800;
            color: #e9faff;
        }

        .register-subtext {
            font-size: 1rem;
            opacity: 0.85;
            margin-bottom: 28px;
        }

        .register-card {
            background: rgba(9, 48, 70, 0.85);
            padding: 45px;
            border-radius: 20px;
            box-shadow: 0 6px 25px rgba(0,0,0,0.45);
            backdrop-filter: blur(4px);
            color: #dff8ff;
            text-align: left;
        }

        .register-card label {
            font-weight: 700;
            margin-top: 12px;
            display: block;
        }

        .register-card input {
            width: 100%;
            padding: 11px;
            border-radius: 10px;
            border: none;
            margin-top: 6px;
            margin-bottom: 14px;
            background: #e7faff;
            font-size: 1rem;
        }

        .register-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;       /* spacing between buttons */
            margin-top: 18px;
}

        /* Keep button sizing consistent */
        .register-buttons .btn-register,
        .register-buttons .btn-clear {
    width: 45%;
    text-align: center;
        }


        .btn-register, .btn-clear {
            padding: 11px 30px;
            font-size: 1rem;
            border-radius: 28px;
            font-weight: bold;
            margin-top: 22px;
            cursor: pointer;
            border: none;
        }

        .btn-register {
            background: #67defc;
            color: #013648;
            transition: .3s;
            margin-right: 10px;
        }
        .btn-register:hover { background: #94efff; transform: scale(1.05); }

        .btn-clear {
            background: #67defc;
            color: #013648;
            transition: .3s;
            margin-right: 10px;
        }
        .btn-clear:hover { background: #94efff; transform: scale(1.05); }

        /* Fade-in animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</asp:Content>


<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="register-container">
        <h2>Create an Aquaprawn Account</h2>
        <p class="register-subtext">Unlock premium access to product information & future ordering.</p>

        <asp:Label ID="lblPrimaryKeyError" runat="server" ForeColor="Red"></asp:Label>

        <div class="register-card">

            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                ControlToValidate="txtEmail" ErrorMessage="Email Required" ForeColor="Red" />

            <label>Confirm Email</label>
            <asp:TextBox ID="txtEmailC" runat="server" />
            <asp:CompareValidator ID="cvEmail" runat="server"
                ControlToCompare="txtEmail" ControlToValidate="txtEmailC"
                ErrorMessage="Emails must match" ForeColor="Red" />

            <label>Password</label>
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" />
            <asp:RequiredFieldValidator ID="rfvPass" runat="server" 
                ControlToValidate="txtPass" ErrorMessage="Password Required" ForeColor="Red" />

            <label>Confirm Password</label>
            <asp:TextBox ID="txtPassC" runat="server" TextMode="Password" />
            <asp:CompareValidator ID="cvPass" runat="server"
                ControlToCompare="txtPass" ControlToValidate="txtPassC"
                ErrorMessage="Passwords must match" ForeColor="Red" />

            <label>First Name</label>
            <asp:TextBox ID="txtFname" runat="server" />
            <asp:RequiredFieldValidator ID="rfvFname" runat="server"
                ControlToValidate="txtFname" ErrorMessage="First Name Required" ForeColor="Red" />

            <label>Last Name</label>
            <asp:TextBox ID="txtLname" runat="server" />
            <asp:RequiredFieldValidator ID="rfvLname" runat="server"
                ControlToValidate="txtLname" ErrorMessage="Last Name Required" ForeColor="Red" />

            <label>Organization</label>
            <asp:TextBox ID="txtOrganization" runat="server" />
            <asp:RequiredFieldValidator ID="rfvOrganization" runat="server"
                ControlToValidate="txtOrganization" ErrorMessage="Organization Required" ForeColor="Red" />

            <label>Phone Number</label>
            <asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" />

            <div class="register-buttons">
                <asp:Button ID="btJoin" runat="server" Text="Register" CssClass="btn-register" OnClick="btJoin_Click" />
                <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="btn-clear" OnClick="Button1_Click" CausesValidation="False" />
            </div>


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
    </div>

</asp:Content>
