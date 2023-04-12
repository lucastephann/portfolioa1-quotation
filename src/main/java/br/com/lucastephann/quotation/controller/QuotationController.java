package br.com.lucastephann.quotation.controller;

import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/quotation")
public class QuotationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double currentUSDQuotation = this.getCurrentUSDQuotation();

        request.setAttribute("quotation", currentUSDQuotation);
        request.getRequestDispatcher("quotation/quotation.jsp").forward(request, response);
    }

    private double getCurrentUSDQuotation() throws IOException {
        // https://docs.awesomeapi.com.br/api-de-moedas
        URL url = new URL("https://economia.awesomeapi.com.br/last/USD-BRL");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            String response = in.lines().reduce("", String::concat);
            JSONObject json = new JSONObject(response);
            return round(json.getJSONObject("USDBRL").getDouble("ask")); // ask - valor de venda da moeda
        }
    }

    private static double round(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
}
