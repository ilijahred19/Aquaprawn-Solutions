<%@ Page Title="Quote Submitted" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="quote success.aspx.cs" Inherits="Aquaprawn.quote_success" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>

/* =============== PAGE WRAPPER =============== */
.success-wrapper {
    width: 65%;
    margin: 110px auto;
    text-align: center;
    animation: fadeIn 0.9s ease;
    color: #e8faff;
}

/* =============== CARD =============== */
.success-card {
    background: rgba(9,48,70,0.88);
    padding: 60px 55px;
    border-radius: 22px;
    box-shadow: 0px 12px 32px rgba(0, 0, 0, .45);
    backdrop-filter: blur(5px);
    position: relative;
    overflow: hidden;
}

/* =============== ICON =============== */
.success-icon {
    font-size: 4rem;
    color: #6bdfff;
    animation: popIn .7s ease-out;
}

/* =============== TEXT =============== */
.success-title {
    margin-top: 12px;
    font-size: 2.1rem;
    font-weight: 800;
}

.success-desc {
    font-size: 1.15rem;
    opacity: .9;
    margin-top: 8px;
    margin-bottom: 28px;
}

/* =============== BUTTONS =============== */
.success-btn {
    display: inline-block;
    background: #67defc;
    padding: 12px 34px;
    border-radius: 30px;
    font-size: 1.1rem;
    color: #013648;
    font-weight: 800;
    text-decoration: none;
    margin: 8px;
    transition: .35s;
}

.success-btn:hover {
    background: #9ef7ff;
    transform: scale(1.06);
}

/* =============== SHRIMP ANIMATION =============== */
.success-shrimp {
    position: absolute;
    bottom: 25px;
    left: -150px;
    width: 120px;
    opacity: .9;
    animation: swimAcross 7s ease-out forwards;
}

/* =============== ANIMATIONS =============== */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(18px); }
    to   { opacity: 1; }
}

@keyframes popIn {
    0%   { transform: scale(.3); opacity: 0; }
    80%  { transform: scale(1.18); }
    100% { transform: scale(1); opacity: 1; }
}

@keyframes swimAcross {
    0% { transform: translateX(0); opacity: 0; }
    10% { opacity: 1; }
    50% { transform: translateX(55vw); }
    90% { opacity: 1; }
    100% { transform: translateX(110vw); opacity: 0; }
}

</style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="success-wrapper">
    <div class="success-card">

        <div class="success-icon">✔</div>

        <div class="success-title">Quote Request Submitted</div>

        <div class="success-desc">
            Thank you for your interest in our premium B2B-grade shrimp.<br />
            Our sales team will contact you shortly with pricing & availability.
        </div>

        <a href="default.aspx" class="success-btn">Return to Home</a>
        <a href="Products.aspx" class="success-btn">Browse Products</a>

        <!-- shrimp animation -->
        <img src="images/shrimpicon.png" class="success-shrimp" />

    </div>
</div>

</asp:Content>
