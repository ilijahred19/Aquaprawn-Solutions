<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="update.aspx.cs" Inherits="Aquaprawn.update" %>
<asp:Content ID="UpdateHead" ContentPlaceHolderID="head" runat="server">
<style>
/* ============================
    UPDATE PAGE UI — FINAL
============================ */
.update-container {
    width: 60%;
    margin: 65px auto;
    text-align: center;
    animation: fadeIn .9s;
}

.update-title {
    font-size: 2.1rem;
    font-weight: 800;
    color: #e9faff;
    letter-spacing: .5px;
}

.update-sub {
    font-size: 1rem;
    opacity: .85;
    color: #bfe9ff;
    margin-bottom: 28px;
}

/* Card matches register structure but deeper tone */
.update-card {
    background: rgba(9, 48, 70, 0.87);
    padding: 45px;
    border-radius: 22px;
    box-shadow: 0 7px 25px rgba(0,0,0,0.45);
    backdrop-filter: blur(4px);
    color: #dff8ff;
    text-align: left;
}

/* --- Field & label spacing identical to Register --- */
.update-card label {
    font-weight: 700;
    margin-top: 12px;
    display: block;
}

.update-card input {
    width: 100%;
    padding: 11px;
    border-radius: 10px;
    border: none;
    margin-top: 6px;
    margin-bottom: 14px;
    background: #e7faff;
    font-size: 1rem;
}

.update-card input[readonly] {
    background:#0e3a51;       /* darker so it stands out */
    color:#9fd7ff;            /* light text to show it's info only */
    cursor:not-allowed;       /* universal “you can't edit me” indicator */
    font-weight:700;
    border:2px solid #298fb8;
}


/* ============================
      Buttons Like Register
============================ */
.update-buttons {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 18px;
}

.update-buttons .btn-update,
.update-buttons .btn-cancel {
    width: 45%;
    padding: 11px 30px;
    font-size: 1rem;
    border-radius: 28px;
    font-weight: 700;
    cursor: pointer;
    border: none;
    transition: .3s;
    text-align: center;
}

.btn-update {
    background: #67defc;
    color: #013648;
}
.btn-update:hover { background: #94efff; transform: scale(1.05); }

.btn-cancel {
    background: #67defc;
    color: #013648;
}
.btn-cancel:hover { background: #94efff; transform: scale(1.05); }

/* ============================
       Success Modal Styling
============================ */
.modal-overlay {
    position: fixed;
    top:0; left:0;
    width:100%; height:100%;
    background: rgba(0,0,0,.65);
    backdrop-filter: blur(6px);
    display:flex;
    justify-content:center;
    align-items:center;
    z-index:9999;
    animation: fadeIn .4s ease-out;
}

.modal-box {
    background:#08344d;
    color:#dffaff;
    text-align:center;
    padding:40px 60px;
    border-radius:18px;
    box-shadow:0 0 30px rgba(0,200,255,.4);
    animation: drop .45s ease-out;
}

.modal-check {
    font-size:50px;
    color:#6af0ff;
    margin-bottom:10px;
}

.modal-btn {
    margin-top:20px;
    padding:12px 30px;
    border:none;
    border-radius:25px;
    font-size:1.1rem;
    font-weight:700;
    cursor:pointer;
    background:#6ddfff;
    color:#013d50;
}
.modal-btn:hover { transform:scale(1.08); background:#9ef7ff; }

/* Animations */
@keyframes fadeIn { from{opacity:0;} to{opacity:1;} }
@keyframes drop { from{transform:translateY(-20px);opacity:0;} to{opacity:1;} }

</style>
</asp:Content>


<asp:Content ID="UpdateMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="update-container">
    <div class="update-title">Update Account</div>
    <div class="update-sub">Modify your profile details safely and securely.</div>
    <asp:Label ID="lblStatus" runat="server" Visible="false" ForeColor="Salmon" Font-Size="Large"></asp:Label>

    <div class="update-card">

        <!-- Email (Locked) -->
        <label>Email</label>
        <asp:TextBox ID="txtEmail" runat="server" ReadOnly="True"/>

        <!-- Password -->
        <label>Password</label>
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password"/>

        <!-- Confirm -->
        <label>Confirm Password</label>
        <asp:TextBox ID="txtPassConfirm" runat="server" TextMode="Password"/>
        <asp:CompareValidator ID="cvPass" runat="server"
            ControlToValidate="txtPassConfirm" ControlToCompare="txtPass"
            ErrorMessage="Passwords must match" ForeColor="Salmon" Display="Dynamic" />

        <!-- First Name -->
        <label>First Name</label>
        <asp:TextBox ID="txtFname" runat="server"/>

        <!-- Last Name -->
        <label>Last Name</label>
        <asp:TextBox ID="txtLname" runat="server"/>

        <!-- Organization -->
        <label>Organization</label>
        <asp:TextBox ID="txtOrg" runat="server"/>

        <!-- Phone -->
        <label>Phone Number</label>
        <asp:TextBox ID="txtPhone" runat="server"/>

        <div class="update-buttons">
            <asp:Button ID="btnSave" Text="Save Changes" CssClass="btn-update" runat="server" OnClick="btnSave_Click"/>
            <asp:Button ID="btnCancel" Text="Return" CssClass="btn-cancel" runat="server" PostBackUrl="~/MyAccount.aspx"/>
        </div>
</div>

    <div id="successModal" runat="server" visible="false" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-check">✔</div>
        <h2>Profile Updated</h2>
        <p>Your changes have been saved successfully.</p>

        <asp:Button ID="btnCloseModal" runat="server" Text="Close" CssClass="modal-btn"
                    OnClick="btnCloseModal_Click"/>
    </div>
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
</asp:Content>
