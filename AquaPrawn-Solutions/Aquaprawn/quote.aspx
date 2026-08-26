<%@ Page Title="Request a Quote" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="quote.aspx.cs" Inherits="Aquaprawn.quote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

/* ====================== PAGE TITLE ====================== */
.page-title {
    font-size:2.4rem;
    font-weight:800;
    margin-top:45px;
    color:#e8faff;
    text-align:center;
}

.page-sub {
    text-align:center;
    color:#bfeaff;
    opacity:.85;
    margin-top:-8px;
    margin-bottom:30px;
}

/* ====================== FORM CONTAINER ====================== */
.quote-container {
    width:75%;
    margin:0 auto 55px;
    background:rgba(9,48,70,0.92);
    border-radius:22px;
    padding:45px 50px;
    backdrop-filter:blur(5px);
    box-shadow:0 12px 35px rgba(0,0,0,.45);
}

/* ====================== FORM CARD ====================== */
.form-section {
    background:rgba(14,60,82,.65);
    border:1px solid rgba(255,255,255,.08);
    padding:30px;
    border-radius:18px;
    box-shadow:0 6px 20px rgba(0,0,0,.4);
}

.form-section h3 {
    font-size:1.4rem;
    font-weight:800;
    color:#7af6ff;
    padding-bottom:10px;
    border-bottom:2px solid rgba(255,255,255,.15);
    margin-bottom:22px;
}

/* ====================== FORM FIELDS ====================== */
.form-group {
    margin-bottom:20px;
}

.form-group label {
    display:block;
    font-weight:600;
    color:#cceefe;
    margin-bottom:6px;
}

.form-control {
    width:100%;
    padding:12px;
    border-radius:10px;
    background:#012b3c;
    border:none;
    color:white;
    font-size:1rem;
    box-shadow:inset 0 0 8px rgba(0,0,0,.25);
}

.form-control:focus {
    outline:none;
    border:1px solid #7af6ff;
    box-shadow:0 0 8px rgba(122,246,255,.4);
}

/* ====================== SUBMIT BUTTON ====================== */
.btn-quote {
    display:block;
    width:100%;
    padding:15px;
    font-size:1.25rem;
    font-weight:800;
    border-radius:30px;
    background:#67defc;
    color:#013648;
    border:none;
    cursor:pointer;
    transition:.35s;
    margin-top:18px;
}

.btn-quote:hover {
    transform:scale(1.05);
    background:#9ef7ff;
}

/* ====================== ERROR LABEL ====================== */
#error {
    margin-top:15px;
    color:#ff7a7a;
    font-weight:700;
    text-align:center;
}

</style>

</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- ====================== SQL Source ====================== -->
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:AquaPrawnConnectionString %>"
    InsertCommand="INSERT INTO [NewCustomer] ([NCUS_PH], [NCUS_ORG_NAME]) VALUES (@NCUS_PH, @NCUS_ORG_NAME)">
    <InsertParameters>
        <asp:Parameter Name="NCUS_PH" Type="String" />
        <asp:Parameter Name="NCUS_ORG_NAME" Type="String" />
    </InsertParameters>
</asp:SqlDataSource>


<!-- ====================== HEADER ====================== -->
<h1 class="page-title">🧾 Commercial Quote Request</h1>
<p class="page-sub">Provide your organization’s information and we’ll reach out with tailored pricing.</p>



<!-- ====================== FORM CARD ====================== -->
<div class="quote-container">

    <div class="form-section">

        <h3>Your Business Information</h3>

        <p style="color:#9bb6c8; margin-bottom:25px;">
            Perfect for restaurants, grocers, institutions, and B2B partners purchasing in bulk.
        </p>

        <!-- ORG NAME -->
        <div class="form-group">
            <label>Organization Name</label>
            <asp:TextBox ID="txtORGNAME" runat="server" CssClass="form-control"
                placeholder="Company, Seafood Distributor, Restaurant"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvORGNAME" runat="server"
                ControlToValidate="txtORGNAME" ErrorMessage="Organization name is required"
                ForeColor="#ff6b6b" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <!-- PHONE -->
        <div class="form-group">
            <label>Contact Phone Number</label>
            <asp:TextBox ID="txtPH" runat="server" CssClass="form-control"
                placeholder="(555) 555-5555"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPH" runat="server"
                ControlToValidate="txtPH" ErrorMessage="Phone number is required"
                ForeColor="#ff6b6b" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <!-- SUBMIT -->
        <asp:Button ID="btJoin" runat="server" Text="Submit Quote Request"
            CssClass="btn-quote" OnClick="btJoin_Click" />

        <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

    </div>

</div>

</asp:Content>
