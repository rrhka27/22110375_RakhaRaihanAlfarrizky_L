<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%
    // Get film list from application scope
    List<Map<String, Object>> filmList = (List<Map<String, Object>>) application.getAttribute("filmList");
    
    // Get form parameters
    String filmIndexParam = request.getParameter("filmIndex");
    String namaPemesan = request.getParameter("namaPemesan");
    String jumlahTiketParam = request.getParameter("jumlahTiket");
    String jamTayang = request.getParameter("jamTayang");
    
    // Validate parameters
    if (filmIndexParam == null || namaPemesan == null || jumlahTiketParam == null || jamTayang == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    int filmIndex = 0;
    int jumlahTiket = 1;
    
    try {
        filmIndex = Integer.parseInt(filmIndexParam);
        jumlahTiket = Integer.parseInt(jumlahTiketParam);
        
        // Check if film index is valid
        if (filmIndex < 0 || filmIndex >= filmList.size()) {
            response.sendRedirect("index.jsp");
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Get selected film
    Map<String, Object> selectedFilm = filmList.get(filmIndex);
    String judulFilm = (String) selectedFilm.get("judul");
    int hargaTiket = (Integer) selectedFilm.get("hargaTiket");
    int totalHarga = hargaTiket * jumlahTiket;
    
    // Store transaction data in session for reference
    Map<String, Object> transaksi = new HashMap<>();
    transaksi.put("namaPemesan", namaPemesan);
    transaksi.put("judulFilm", judulFilm);
    transaksi.put("jamTayang", jamTayang);
    transaksi.put("jumlahTiket", jumlahTiket);
    transaksi.put("hargaTiket", hargaTiket);
    transaksi.put("totalHarga", totalHarga);
    
    session.setAttribute("lastTransaction", transaksi);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CineMax - Struk Pemesanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .struk {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .struk-header {
            text-align: center;
            margin-bottom: 20px;
            border-bottom: 1px dashed #ccc;
            padding-bottom: 10px;
        }
        .struk-content {
            margin-bottom: 20px;
        }
        .struk-footer {
            border-top: 1px dashed #ccc;
            padding-top: 10px;
            text-align: center;
        }
        .struk-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .print-button {
            cursor: pointer;
        }
        @media print {
            .no-print {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col">
                <h1 class="text-center">CineMax</h1>
                <h3 class="text-center mb-4">Struk Pemesanan Tiket</h3>
            </div>
        </div>
        
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="struk">
                    <div class="struk-header">
                        <h4>STRUK PEMESANAN TIKET</h4>
                        <p><%=new java.util.Date()%></p>
                    </div>
                    
                    <div class="struk-content">
                        <div class="struk-item">
                            <span>Nama Pemesan:</span>
                            <span><%= namaPemesan %></span>
                        </div>
                        <div class="struk-item">
                            <span>Film:</span>
                            <span><%= judulFilm %></span>
                        </div>
                        <div class="struk-item">
                            <span>Jam Tayang:</span>
                            <span><%= jamTayang %></span>
                        </div>
                        <div class="struk-item">
                            <span>Jumlah Tiket:</span>
                            <span><%= jumlahTiket %></span>
                        </div>
                        <div class="struk-item">
                            <span>Harga per Tiket:</span>
                            <span>Rp <%= hargaTiket %></span>
                        </div>
                        <div class="struk-item">
                            <span><strong>Total Harga:</strong></span>
                            <span><strong>Rp <%= totalHarga %></strong></span>
                        </div>
                    </div>
                    
                    <div class="struk-footer">
                        <p>Terima kasih telah memesan tiket di Bioskop Online.</p>
                        <p>Silahkan tunjukkan struk ini pada petugas.</p>
                    </div>
                </div>
                
                <div class="d-grid gap-2 mt-4 no-print">
                    <button onclick="window.print()" class="btn btn-success print-button">Cetak Struk</button>
                    <a href="index.jsp" class="btn btn-primary">Kembali ke Daftar Film</a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>