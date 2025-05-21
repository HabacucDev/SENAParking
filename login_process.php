<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo = $_POST["correo"];
    $password = $_POST["password"];

    $conn = new mysqli("localhost", "root", "", "prueba_db");

    if ($conn->connect_error) {
        die("Error de conexión: " . $conn->connect_error);
    }

    $stmt = $conn->prepare("SELECT * FROM users WHERE correo = ? AND password = ?");
    $stmt->bind_param("ss", $correo, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $_SESSION['correo'] = $correo;
        header("Location: /frontend/views/dashboard_admin.php");
        exit();
    } else {
        // En caso de error, redirigimos con un mensaje opcional
        header("Location: login.html?error=1");
        exit();
    }

    $conn->close();
}
?>
