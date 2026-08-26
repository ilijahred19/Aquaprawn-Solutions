<%@ Page Title="Account Deleted" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" Inherits="Aquaprawn.deleteSuccess" %>

<asp:Content ID="SuccessHead" ContentPlaceHolderID="head" runat="server">
<style>

    /* ================================
         DELETE SUCCESS PAGE STYLE
    =================================*/
    .success-wrapper{
        width:60%;
        margin:110px auto;
        text-align:center;
        animation:fadeIn 1.1s ease-in-out;
    }

    .success-box{
        background:rgba(8,50,75,0.92);
        padding:55px;
        border-radius:22px;
        box-shadow:0px 12px 30px rgba(0,0,0,0.45);
        color:#dff8ff;
        backdrop-filter:blur(6px);
        animation:floatUp .6s ease-out;
    }

    .success-icon{
        font-size:68px;
        margin-bottom:10px;
        color:#6df4ff;
    }

    .success-title{
        font-size:2.1rem;
        font-weight:800;
        margin-bottom:8px;
    }

    .success-text{
        opacity:.9;
        font-size:1.15rem;
        margin-bottom:25px;
    }

.btn-home{
    display:inline-block;
    padding:12px 30px;
    background:#67defc;
    color:#013648;
    font-size:1.1rem;
    font-weight:700;
    border-radius:28px;
    text-decoration:none;
    transition:0.3s;
}

.btn-home:hover{
    background:#94efff;
    transform:scale(1.06);
}


    /* Soft Entry Animations */
    @keyframes fadeIn{ from{opacity:0;} to{opacity:1;} }
    @keyframes floatUp{ 
        from{transform:translateY(25px);opacity:0;} 
        to{transform:translateY(0); opacity:1;}
    }

</style>
</asp:Content>


<asp:Content ID="SuccessMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="success-wrapper">
        <div class="success-box">

            <div class="success-icon">✔</div>
            <div class="success-title">Account Deleted Successfully</div>

            <p class="success-text">
                Your Aquaprawn profile has been released back into the ocean.<br/>
                We appreciate the time you swam with us. 🦐🌊
            </p>

            <a href="default.aspx" class="btn-home">Return to Home</a>


        </div>
    </div>

</asp:Content>
