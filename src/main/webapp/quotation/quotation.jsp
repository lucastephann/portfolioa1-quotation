<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Cotação do Dolar</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <style>
        body {
            background-color: #cccccc;
        }

        .container-fluid {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card-wrapper {
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border-radius: 0.5rem;
        }
    </style>
</head>

<body>
<div class="container-fluid">
    <div class="card-wrapper">
        <div class="card">
            <div class="card-header">
                Cotação do Dolar (Câmbio atual: R$ <%= request.getAttribute("quotation") %>)
            </div>
            <div class="card-body">
                <form>
                    <div class="form-group">
                        <label for="value" class="mb-1">Digite o valor em reais</label>
                        <div class="input-group">
                            <input id="value" type="text" class="form-control" aria-label="Valor em reais">
                            <div class="input-group-append">
                                <button class="btn btn-secondary" type="button" onclick="quote()">Cotar</button>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="result" class="mb-1">Valor em dólares</label>
                        <input id="result" type="text" class="form-control" disabled aria-label="Valor em dólares">
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

<script>
  function quote() {
    const currentUsdQuotation = <%= request.getAttribute("quotation") %>;
    const value = parseFloat(document.getElementById("value").value);
    const result = value / currentUsdQuotation;

    document.getElementById("result").value = result.toFixed(2);
  }
</script>

</html>
