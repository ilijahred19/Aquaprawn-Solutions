<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Products.aspx.cs" Inherits="Aquaprawn.Products" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
<style>

/* ───────────────────────────────────────── PRODUCT CARD GRID ───────────────────────────────────────── */
.product-page {
    text-align:center;
    padding-top:60px;
    color:white;
}

.product-grid {
    display:flex;
    justify-content:center;
    gap:35px;
    margin-top:45px;
    flex-wrap:wrap;
}

.product-card {
    background:rgba(0,25,40,.78);
    border-radius:22px;
    width:360px;
    padding:28px;
    text-align:center;
    box-shadow:0 8px 25px rgba(0,0,0,.45);
    transition:.35s;
}
.product-card:hover { transform:translateY(-6px); }

.product-card {
    display:flex;
    flex-direction:column;
    justify-content:space-between;
    height:480px;
}

.card-body {
    flex:1; /* expands evenly */
    display:flex;
    flex-direction:column;
}

.product-desc {
    margin-bottom:auto; /* pushes buttons to bottom */
}


/* IMAGES */
.product-img {
    width:100%;
    border-radius:16px;
    margin-bottom:12px;
}

/* TITLE + TEXT */
.product-title { font-size:1.35rem; margin:8px 0; font-weight:800; }
.product-desc  { font-size:.95rem; opacity:.85; margin-bottom:15px; }

/* CTA BUTTON (changes to Order if logged in) */
.product-btn {
    padding:11px 24px;
    border-radius:25px;
    border:none;
    font-size:1rem;
    font-weight:700;
    cursor:pointer;
    transition:.3s;
    background:#6ddfff;
    color:#013648;
}
.product-btn:hover { transform:scale(1.08); background:#9ef7ff; }

.product-btn {
    margin-top:auto; 
}


/* ───────────────────────────────────────── PRODUCT MODAL ───────────────────────────────────────── */
.modal-bg {
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.78);
    backdrop-filter:blur(6px);
    display:none;
    justify-content:center;
    align-items:center;
    z-index:5000;
}

.modal-window {
    background:#062b3a;
    width:520px;
    padding:40px;
    border-radius:22px;
    animation:drop .35s ease-out;
    text-align:center;
    color:#e4fbff;
    position:relative;
}

.close-x {
    position:absolute;
    top:15px; right:22px;
    font-size:32px;
    cursor:pointer;
    color:white;
}

.modal-img { width:100%; border-radius:18px; margin-bottom:18px; }
.modal-title { font-size:1.45rem; font-weight:800; }
.modal-text  { opacity:.92; font-size:1rem; margin-bottom:22px; }

/* Modal CTA auto-updated based on login in .cs */
.modal-action {
    padding:12px 30px;
    border:none;
    border-radius:25px;
    font-weight:800;
    font-size:1.05rem;
    cursor:pointer;
}

@keyframes drop{
    from{ transform:translateY(-25px); opacity:0; }
    to  { transform:translateY(0); opacity:1; }
}

a[href='quote.aspx']:hover {
    background:#67defc;
    color:#013648 !important;
    transform:scale(1.05);
}

.quote-cta {
    padding:12px 35px;
    border-radius:30px;
    border:2px solid #67defc;
    color:#67defc;
    font-weight:700;
    font-size:1.05rem;
    text-decoration:none;
    transition:.3s ease;
}

.quote-cta:hover {
    background:#67defc;
    color:#013648;
    transform:scale(1.05);
}


</style>
</asp:Content>



<asp:Content ID="MainBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="product-page">

    <h1 class="fade-in">Product Catalog</h1>
    <p style="margin-top:-6px;">Cold-chain fresh Midwest Pacific White Shrimp — graded, sized, never frozen.</p>


<% if(Session["email"] == null) { %>
<div style="display:flex; justify-content:center; margin-top:20px; margin-bottom:35px;">
    <a href="quote.aspx" class="quote-cta">Need bulk pricing? Request a Quote →</a>
</div>
<% } %>


    <!-- ====================== PRODUCT GRID ====================== -->
    <div class="product-grid">

        <!-- === 21/25 Premium Grade === -->
        <div class="product-card" onclick="openProduct('2125')">
            <div class="card-body">
            <img src="images/shrimp1.jpg" class="product-img" />
            <div class="product-title">21/25 Count | Premium Grade</div>
            <div class="product-desc">Great balance of size & yield. Clean, sweet flavor.</div>
            </div>
            <button id="btn21_25" runat="server" class="product-btn" type="button"></button>
        </div>


        <!-- === 16/20 Chef Select === -->
        <div class="product-card" onclick="openProduct('1620')">
            <div class="card-body">
            <img src="images/shrimp2.jpg" class="product-img"/>
            <div class="product-title">16/20 Count | Chef Select</div>
            <div class="product-desc">Larger-bodied shrimp ideal for upscale plating.</div>
            </div>
            <button id="btn16_20" runat="server" class="product-btn" type="button"></button>
        </div>


        <!-- === U/15 Signature Large === -->
        <div class="product-card" onclick="openProduct('U15')">
            <div class="card-body">
            <img src="images/shrimp3.jpg" class="product-img"/>
            <div class="product-title">U/15 Count | Signature Large</div>
            <div class="product-desc">Showcase sized. Retains moisture beautifully.</div>
            </div>
            <button id="btnU15" runat="server" class="product-btn" type="button"></button>
        </div>

    </div>
</div>



<!-- ======================== MODAL ======================== -->
<div id="productModal" class="modal-bg">
    <div class="modal-window">

        <span class="close-x" onclick="closeModal()">✕</span>

        <img id="modalImg" class="modal-img" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" />
        <h2 id="modalTitle" class="modal-title"></h2>
        <p id="modalText" class="modal-text"></p>

       <asp:Button ID="modalBtn" runat="server" CssClass="modal-action" OnClick="ModalBtn_Click" />

    </div>
</div>


<script>
// OPEN PRODUCT DETAILS
function openProduct(size){
    const modal = document.getElementById("productModal");
    modal.style.display="flex";

    if(size==="2125"){
        modalImg.src="images/shrimp1.jpg";
        modalTitle.innerText="21/25 Count — Premium Grade";
        modalText.innerText="Balanced size, fresh sweetness, versatile for mid-volume foodservice.";
    }
    if(size==="1620"){
        modalImg.src="images/shrimp2.jpg";
        modalTitle.innerText="16/20 Count — Chef Select";
        modalText.innerText="Higher plate presence, excellent mouthfeel, preferred by upscale kitchens.";
    }
    if(size==="U15"){
        modalImg.src="images/shrimp3.jpg";
        modalTitle.innerText="U/15 Count — Signature Large";
        modalText.innerText="High-impact jumbo sizing. Moisture-retentive and visually elite.";
    }
}

function closeModal(){
    document.getElementById("productModal").style.display="none";
}
</script>

</asp:Content>
