<!DOCTYPE html>
<html>
<head>
    <title>Formulario</title>
    <style>
        .error {
            color: red;
        }
        .correcto {
            color: green;
        }
    </style>
</head>
<body>
    <h2>Formulario</h2>
    <?php
    session_start();
    if (isset($_SESSION['errores'])) {
        echo "<div class='error'>";
        foreach ($_SESSION['errores'] as $error) {
            echo $error . "<br>";
        }
        echo "</div>";
        unset($_SESSION['errores']); // Limpiar los errores de la sesión
    }
    $nombre_valor = $_SESSION['nombre_valor'] ?? '';       // Obtener valor o ''
    $documento_valor = $_SESSION['documento_valor'] ?? ''; // Obtener valor o ''
    unset($_SESSION['nombre_valor']);  // Limpiar variables de sesión
    unset($_SESSION['documento_valor']);
    ?>
    <form action="procesar_formulario.php" method="post">
        <div class="grupo__nombre">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="<?php echo htmlspecialchars($nombre_valor); ?>">
            <span class="formulario__input-error">
                <?php
                // Mostrar mensaje de error específico si existe
                if (isset($_SESSION['errores']['nombre'])) {
                    echo $_SESSION['errores']['nombre'];
                }
                ?>
            </span>
        </div>
        <div class="grupo__documento">
            <label for="documento">Documento:</label>
            <input type="text" id="documento" name="documento" value="<?php echo htmlspecialchars($documento_valor); ?>">
            <span class="formulario__input-error">
                <?php
                if (isset($_SESSION['errores']['documento'])) {
                  echo $_SESSION['errores']['documento'];
                }
                ?>
            </span>
        </div>
        <button type="submit">Enviar</button>
    </form>
    <script>
    function goBack() {
        window.location.href = "/frontend/views/dashboard_guardia.html";
    }
    </script>
    <button onclick="goBack()">Go Back</button>
</body>
</html>