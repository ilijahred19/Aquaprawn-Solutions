<%@ Page Title="Order Success" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="order success.aspx.cs" Inherits="Aquaprawn.order_success" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>

/* Center wrapper */
.success-wrapper {
    width: 65%;
    margin: 110px auto;
    text-align:center;
    animation: fadeIn .9s ease;
    color:#e8faff;
}

/* Success card */
.success-card {
    background: rgba(9,48,70,0.88);
    padding: 60px 55px;
    border-radius: 22px;
    box-shadow: 0px 12px 32px rgba(0,0,0,.45);
    backdrop-filter: blur(5px);
    position:relative;
    overflow:hidden;
}

/* Animated checkmark */
.success-icon {
    font-size:4rem;
    color:#67defc;
    animation: popIn .7s ease-out;
}

/* Text */
.success-title {
    font-size:2.2rem;
    font-weight:800;
    margin-top:12px;
}
.success-desc {
    font-size:1.1rem;
    opacity:.9;
    margin:6px 0 24px 0;
}

/* CTA buttons */
.success-btn {
    display:inline-block;
    background:#67defc;
    padding:12px 36px;
    border-radius:30px;
    color:#013648;
    font-weight:800;
    font-size:1.1rem;
    margin:10px;
    border:none;
    cursor:pointer;
    transition:.3s;
    text-decoration:none;
}
.success-btn:hover { transform:scale(1.06); background:#9eedff; }

/* Little shrimp animation */
.success-shrimp {
    position:absolute;
    bottom:25px;
    left:-150px;
    width:120px;
    opacity:.9;
    animation: shrimpSwim 8s ease-out forwards;
}

/* Animations */
@keyframes fadeIn {
    from { opacity:0; transform:translateY(18px); }
    to   { opacity:1; }
}
@keyframes popIn {
    0% { transform:scale(.3); opacity:0; }
    80% { transform:scale(1.18); }
    100% { transform:scale(1); opacity:1; }
}
@keyframes shrimpSwim {
    0%   { transform:translateX(0) scaleX(1); opacity:0; }
    8%   { opacity:1; }
    45%  { transform:translateX(55vw) scaleX(1); }
    80%  { transform:translateX(90vw) scaleX(1); opacity:1; }
    100% { transform:translateX(110vw) scaleX(1); opacity:0; }
}

</style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="success-wrapper">
    <div class="success-card">

        <div class="success-icon">✔</div>

        <div class="success-title">Order Confirmed</div>
        <div class="success-desc">
            We've received your order! Our team is preparing packaging and logistics now.
        </div>

        <a href="myorders.aspx" class="success-btn">View My Orders</a>
        <a href="default.aspx" class="success-btn">Return Home</a>

        <!-- Tiny shrimp animation -->
        <img src="images/shrimpicon.png" class="success-shrimp" />

    </div>
</div>

</asp:Content>
