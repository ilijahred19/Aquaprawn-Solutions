<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="delete.aspx.cs" Inherits="Aquaprawn.delete" %>
<asp:Content ID="DeleteHead" ContentPlaceHolderID="head" runat="server">
<style>
.delete-container {
    width: 50%;
    margin: 80px auto;
    animation: fadeIn 1s;
    text-align: center;
}

.delete-box {
    background: rgba(9,48,70,0.90);
    padding: 45px;
    border-radius: 22px;
    box-shadow: 0px 10px 25px rgba(0,0,0,.4);
    color:#dff8ff;
    text-align:left;
}

.delete-box label {
    font-weight:bold;
    margin-top:14px;
    display:block;
}

.delete-box input {
    width:100%;
    padding:11px;
    border-radius:10px;
    margin-top:6px;
    border:none;
    background:#e7faff;
}

.warning-msg {
    margin-top:20px;
    font-size:1.15rem;
    color:#ffb3b3;
    font-weight:700;
    text-align:center;
}

.delete-btns {
    display:flex;
    justify-content:center;
    gap:12px;
    margin-top:30px;
}

.btn-delete {
    background:#6ddfff;
    color:#013648;
    font-weight:800;
    padding:12px 32px;
    border-radius:30px;
    border:none;
    cursor:pointer;
    font-size:1.05rem;
    transition:.35s;
}
.btn-delete:hover{ background:#ff7777; transform:scale(1.05); }

.btn-cancel {
    background:#6ddfff;
    color:#013648;
    padding:12px 32px;
    border-radius:30px;
    font-weight:800;
    border:none;
    cursor:pointer;
    font-size:1.05rem;
}
.btn-cancel:hover{ background:#9ef0ff; transform:scale(1.05); }

@keyframes fadeIn { from{opacity:0;} to{opacity:1;} }

.delete-warning {
    margin-top:20px;
    font-size:1.1rem;
    opacity:.9;
    text-align:center;
}

.email-tag {
    background:#00384f;
    color:#82f2ff;
    padding:6px 14px;
    border-radius:14px;
    font-weight:700;
    letter-spacing:.5px;
    margin-left:6px;
    text-shadow:0 0 6px rgba(0,200,255,.7);
}

</style>
</asp:Content>


<asp:Content ID="DeleteMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="delete-container">
    <h2 style="color:#e9faff; font-size:2rem; font-weight:800;">Delete Account</h2>
    <p style="opacity:.85; margin-bottom:25px;">Once deleted, your account cannot be recovered.</p>

    <div class="delete-box">

        <label>Confirm Email</label>
        <asp:TextBox ID="txtConfirmEmail" runat="server" />

        <p class="delete-warning">
            You are logged in as: <span id="emailDisplay" runat="server" class="email-tag"></span>
        </p>

        <div class="warning-msg">
            ⚠ This action is permanent  
            <br /> Type your email to confirm deletion.
        </div>

        <div class="delete-btns">
            <asp:Button ID="btnDelete" runat="server" CssClass="btn-delete" Text="Delete Account" OnClick="btnDelete_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn-cancel" Text="Cancel" PostBackUrl="~/MyAccount.aspx" />
        </div>

    </div>
</div>

<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>"
    DeleteCommand="DELETE FROM [Customer] WHERE [CUS_EMAIL] = @CUS_EMAIL">
    <DeleteParameters>
        <asp:Parameter Name="CUS_EMAIL" Type="String" />
    </DeleteParameters>
</asp:SqlDataSource>

</asp:Content>
