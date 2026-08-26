<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="default.aspx.cs" Inherits="Aquaprawn._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            text-align: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- 🔥 Welcome Toast -->
<div id="welcomeToast" runat="server" visible="false" class="toast">
    🦐 Welcome aboard, <b><%= Session["CUS_NAME"] %></b>!
</div>


    <!-- ========================= HERO BANNER ========================= -->
    <div class="hero-container">
        <div class="hero-overlay">
            <h1 class="hero-title">Ocean-Grade Quality, Delivered.</h1>
            <p class="hero-sub">
                Aquaprawn provides premium prawns and seafood distribution with controlled handling,
                reliable logistics, and consistency you can trust.
            </p>

<!-- If NOT logged in, show onboarding buttons -->
<% if(Session["email"] == null) { %>
<div>
    <a href="Join.aspx" class="btn-primary">Become a Partner</a>
    <a href="Login.aspx" class="btn-outline">Client Login</a>
    <a href="quote.aspx" class="btn-outline" style="margin-left:10px;">
            Request a Quote
    </a>
</div>
<% } %>
        </div>
    </div>

    <% if(Session["LoginSuccess"] != null) { %>
<div class="modal-overlay" id="loginModal">
    <div class="modal-box">
        <div class="modal-check">✔</div>
        <h2>Login Successful</h2>
        <p>Welcome back to Aquaprawn.</p>
        <button class="modal-btn" onclick="document.getElementById('loginModal').style.display='none'">
            Continue
        </button>
    </div>
</div>
<% Session.Remove("LoginSuccess"); } %>


    <!-- ========================= ABOUT SECTION ========================= -->
   <section class="section fade-in">
    <h2>Who We Are</h2>
    <p>
        Aquaprawn Solutions is a Midwest-based B2B shrimp supplier built on one
        promise: <b>fresh, traceable, never-frozen Pacific White Shrimp</b> delivered directly to
        restaurants, grocers, and food distributors who refuse to compromise on quality.
        While the majority of shrimp in the U.S. is imported and frozen, Aquaprawn grows 
        and transports product locally within the region, maintaining texture, sweetness,
        and cellular integrity that frozen supply chains simply cannot match.
    </p>
    <p>
        Based near Chicago, our proximity gives buyers something no coastal operation
        can, <b>rapid delivery from harvest to kitchen</b>. We’re moving seafood distribution
        beyond the freezer and into a new standard of premium freshness.
    </p>
</section>



    <!-- ========================= SERVICE CARDS ========================= -->
<section class="section fade-in">
    <h2>Why Aquaprawn?</h2>

    <div class="card-container">

        <div class="card">
            <div class="card-title">Never-Frozen Freshness</div>
            <div class="card-desc">
                Over 90% of U.S. shrimp is frozen before arrival. 
                Ours isn’t. We harvest local and deliver cold-chain fresh,
                preserving natural texture and flavor unmatched by imports.
            </div>
        </div>

        <div class="card">
            <div class="card-title">Midwest Supply Advantage</div>
            <div class="card-desc">
                With Chicago as our distribution hub, we reach regional buyers quickly 
                without international delays, reducing breakdown, waste, and transport time.
            </div>
        </div>

        <div class="card">
            <div class="card-title">Reliable B2B Scalability</div>
            <div class="card-desc">
                Built for restaurants, retail chains & food service procurement. 
                Consistent volume, year-round production, and responsive sales coordination.
            </div>
        </div>

    </div>
</section>

<section class="highlight-section fade-in">
    <h2>Fresh Over Frozen. Local Over Imported.</h2>
    <p>
        We supply businesses that refuse to compromise on quality.
        Fresh, traceable, cold-chain shrimp grown in the Midwest,
        delivered without the cellular breakdown of freezing.
    </p>

<% if(Session["email"] == null) { %>
    <a href="Join.aspx" class="btn-highlight">Request Supplier Access</a>
<% } else { %>
    <a href="products.aspx" class="btn-highlight">Browse Catalog</a>
<% } %>
</section>


    <!-- ========================= IMAGE STRIP (OPTIONAL) ========================= -->
    <section class="section fade-in">
        <h2>Our Product Tier</h2>
        <p>     Available sizing, grading, and handling tailored to commercial procurement requirements.</p>

        <div class="image-row">
            <img src="images/shrimp1.jpg" />
            <img src="images/shrimp3.jpg" />
            <img src="images/shrimp2.jpg" />
        </div>
    </section>


</asp:Content>
