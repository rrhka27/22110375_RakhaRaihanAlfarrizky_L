<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%
    // Initialize film data if not exists in application scope
    if (application.getAttribute("filmList") == null) {
        List<Map<String, Object>> filmList = new ArrayList<>();
        
        // Film 1
        Map<String, Object> film1 = new HashMap<>();
        film1.put("judul", "Komang");
        film1.put("genre", "Romance");
        film1.put("durasi", 169);
        film1.put("hargaTiket", 45000);
        film1.put("jamTayang", new String[]{"10:00", "13:30", "17:00", "20:30"});
        film1.put("image", "Poster-komang-3.jpg");  // Placeholder for image name
        film1.put("deskripsi", "Kisah haru seorang ayah Bali yang mencari keadilan atas kematian anaknya. Penuh emosi dan budaya lokal.");
        
        // Film 2
        Map<String, Object> film2 = new HashMap<>();
        film2.put("judul", "Modal Nekad");
        film2.put("genre", "Komedi");
        film2.put("durasi", 181);
        film2.put("hargaTiket", 50000);
        film2.put("jamTayang", new String[]{"09:30", "13:00", "16:30", "20:00"});
        film2.put("image", "modal-nekad.jpg");
        film2.put("deskripsi", "Komedi anak muda yang nekat bangun bisnis dari nol. Kocak, inspiratif, dan relatable banget!.");
        // Film 3
        Map<String, Object> film3 = new HashMap<>();
        film3.put("judul", "Pabrik Gula");
        film3.put("genre", "Horor");
        film3.put("durasi", 132);
        film3.put("hargaTiket", 40000);
        film3.put("jamTayang", new String[]{"11:00", "14:30", "18:00", "21:30"});
        film3.put("image", "pabrik-gula.jpg");
        film3.put("deskripsi", "Dokumenter kritis tentang sejarah dan realita kelam industri gula di Indonesia. Manis di luar, getir di dalam.");
        // Add films to list
        filmList.add(film1);
        filmList.add(film2);
        filmList.add(film3);
        
        // Store in application scope
        application.setAttribute("filmList", filmList);
    }
    
    // Get film list from application scope
    List<Map<String, Object>> filmList = (List<Map<String, Object>>) application.getAttribute("filmList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineMax - Bioskop Online</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #032541;
            --secondary-color: #01b4e4;
            --accent-color: #90cea1;
            --dark-color: #333;
            --light-color: #f4f4f4;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f3f5;
            color: var(--dark-color);
        }
        
        .navbar {
            background-color: var(--primary-color);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
        }
        
        .navbar-brand {
            color: var(--accent-color) !important;
            font-weight: 700;
            font-size: 1.8rem;
        }
        
        .navbar-brand span {
            color: var(--secondary-color);
        }
        
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('https://via.placeholder.com/1920x800');
            background-size: cover;
            background-position: center;
            opacity: 0.2;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .section-title {
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--secondary-color), var(--accent-color));
        }
        
        .film-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            height: 100%;
        }
        
        .film-card:hover {
           height: 100%;
           border-radius: 10px;
        }
        
        .film-image {
            height: 250px;
            background-size: contain;          
            background-position: center;     
            background-repeat: no-repeat;    
            border-top-left-radius: 10px;   
            border-top-right-radius: 10px;
            
        }
        
        .film-card .card-body {
            padding: 20px;
        }
        
        .film-title {
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--primary-color);
        }
        
        .film-genre {
            background-color: var(--secondary-color);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            display: inline-block;
        }
        
        .film-duration {
            margin: 10px 0;
            color: #666;
        }
        
        .film-price {
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .showtimes {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin: 15px 0;
        }
        
        .showtime-badge {
            background-color: #eee;
            border-radius: 5px;
            padding: 5px 8px;
            font-size: 0.8rem;
            margin-right: 5px;
            margin-bottom: 5px;
        }
        
        .btn-book {
            background: linear-gradient(to right, var(--secondary-color), var(--accent-color));
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 25px;
            border-radius: 30px;
            transition: all 0.3s;
        }
        
        .btn-book:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(1, 180, 228, 0.4);
        }
        
        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }
        
        .film-desc {
            color: #666;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        @media (max-width: 768px) {
            .hero-section {
                padding: 40px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Cine<span>Max</span></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Beranda</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center hero-content">
                    <h1 class="display-4 fw-bold mb-3">Selamat Datang di CineMax</h1>
                    <p class="lead mb-4">Temukan dan nikmati film terbaru dengan pengalaman menonton terbaik.</p>
                    
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="row mb-5">
            <div class="col-12">
                <h2 class="section-title">Film Saat Ini</h2>
            </div>
        </div>
        
        <div class="row">
            <% for(int i = 0; i < filmList.size(); i++) { 
                Map<String, Object> film = filmList.get(i);
            %>
                <div class="col-md-4 mb-4">
                    <div class="film-card card h-100">
                        <!-- Using placeholder.com for film images -->
                        <div class="film-image" style="background-image: url('Asset/img/<%= film.get("image") %>');"></div>
                        <div class="card-body">
                            <h3 class="film-title"><%= film.get("judul") %></h3>
                            <span class="film-genre"><%= film.get("genre") %></span>
                            <p class="film-duration mt-2">
                                <i class="far fa-clock me-2"></i><%= film.get("durasi") %> menit
                            </p>
                            <p class="film-desc"><%= film.get("deskripsi") %></p>
                            <p class="film-price">Rp <%= String.format("%,d", film.get("hargaTiket")) %></p>
                            
                            <p class="fw-bold mb-2">Jam Tayang:</p>
                            <div class="showtimes">
                                <% String[] jamTayang = (String[]) film.get("jamTayang");
                                   for(String jam : jamTayang) { %>
                                    <span class="showtime-badge"><i class="far fa-clock me-1"></i><%= jam %></span>
                                <% } %>
                            </div>
                            
                            <div class="mt-4">
                                <a href="formPesan.jsp?filmIndex=<%= i %>" class="btn btn-book w-100">
                                    <i class="fas fa-ticket-alt me-2"></i>Pesan Tiket
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h5 class="mb-3">CineMax</h5>
                    <p>Nikmati pengalaman menonton film terbaik dengan layanan pemesanan tiket online yang mudah dan cepat.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                   
                </div>
                <div class="col-md-4">
                    <h5 class="mb-3">Hubungi Kami</h5>
                    <p><i class="fas fa-map-marker-alt me-2"></i> Jl. Merdeka No. 123, Jakarta</p>
                    <p><i class="fas fa-phone me-2"></i> (021) 1234-5678</p>
                    <p><i class="fas fa-envelope me-2"></i> info@cinemax.com</p>
                </div>
            </div>
            <hr class="my-4 bg-light">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 CineMax. Dikembangkan untuk UAS Java JSP.</p>
            </div>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>