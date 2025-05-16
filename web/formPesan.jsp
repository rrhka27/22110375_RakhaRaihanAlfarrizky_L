<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%
    List<Map<String, Object>> filmList = (List<Map<String, Object>>) application.getAttribute("filmList");
    String filmIndexParam = request.getParameter("filmIndex");
    int filmIndex = 0;

    if (filmIndexParam != null && !filmIndexParam.isEmpty()) {
        try {
            filmIndex = Integer.parseInt(filmIndexParam);
            if (filmIndex < 0 || filmIndex >= filmList.size()) {
                filmIndex = 0;
            }
        } catch (NumberFormatException e) {
            filmIndex = 0;
        }
    }

    Map<String, Object> selectedFilm = filmList.get(filmIndex);
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Form Pemesanan Tiket - Bioskop Online</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f2f6fc;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background-color: #5b43f1;
            border: none;
        }
        .btn-primary:hover {
            background-color: #3e2bd4;
        }
        .film-poster {
            width: 100%;
            height: auto;
            border-radius: 12px;
            margin-bottom: 15px;
        }
        .form-label {
            font-weight: 500;
        }
        .highlight {
            background-color: #e6f0ff;
            padding: 8px 12px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row mb-4 text-center">
            <div class="col">
                <h1 class="fw-bold">🎬 CineMax</h1>
                <p class="lead text-muted">Form Pemesanan Tiket</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <div class="card p-4">
                    <div class="card-body">
                        <h4 class="mb-3">Film: <span class="text-primary"><%= selectedFilm.get("judul") %></span></h4>
                        <img src="Asset/img/<%= selectedFilm.get("image") %>" alt="Poster Film" class="film-poster">

                        <form action="struk.jsp" method="post">
                            <input type="hidden" name="filmIndex" value="<%= filmIndex %>">

                            <div class="mb-3">
                                <label for="namaPemesan" class="form-label">Nama Pemesan</label>
                                <input type="text" class="form-control" id="namaPemesan" name="namaPemesan" required>
                            </div>

                            <div class="mb-3">
                                <label for="jumlahTiket" class="form-label">Jumlah Tiket</label>
                                <input type="number" class="form-control" id="jumlahTiket" name="jumlahTiket" min="1" max="10" required>
                            </div>

                            <div class="mb-4">
                                <label for="jamTayang" class="form-label">Jam Tayang</label>
                                <select class="form-select highlight" id="jamTayang" name="jamTayang" required>
                                    <% String[] jamTayang = (String[]) selectedFilm.get("jamTayang");
                                       for(String jam : jamTayang) { %>
                                        <option value="<%= jam %>"><%= jam %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">🎟️ Pesan Sekarang</button>
                                <a href="index.jsp" class="btn btn-outline-secondary">⬅️ Kembali ke Daftar Film</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
