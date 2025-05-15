<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="AdsoDeveloperSolutions801">
    <meta name="course" content="ADSO 2873801">
    <link rel="icon" type="image/x-icon" href="/frontend/public/images/favicon.ico">
    <link rel="stylesheet" href="/frontend/public/css/styles.css">
    <link href="/frontend/public/css/bootstrap.min.css" rel="stylesheet">
    <meta name="theme-color" content="#000000">
    <meta http-equiv="refresh" content="60">
    <title>Login | SENAParking</title>
</head>

<body class="bg-login">
    <!-- Contenedor para el header -->
    <div id="header-container"></div>

    <!-- Logo SENA -->
    <img src="/frontend/public/images/logo_sena.png" alt="Logo SENA"
        style="position: absolute; top: 100px; right: 70px; width: 100px;">

    <!-- Contenedor de registro -->
    <div class="register-container">
        <form method="POST">

            <div class="row mb-3" id="grupo__correo">
                <div class="col-12">
                    <label for="correo_electronico" class="form-label">Email:</label>
                    <input type="email" class="form-control formulario__input" name="correo" id="correo_electronico" placeholder="Email" required>
                    <p class="formulario__input-error">El correo solo puede contener letras, números, puntos, guiones y guión bajo.</p>
                </div>
            </div>

            <div class="row mb-3" id="grupo__password">
                <div class="col-12">
                    <label for="password" class="form-label">Contraseña:</label>
                    <input type="password" class="form-control formulario__input" name="password" id="password" placeholder="Contraseña" required>
                    <p class="formulario__input-error">La contraseña tiene que ser de 4 a 12 dígitos.</p>
                </div>
            </div>

            <!-- Botón de envío -->
            <div class="row">
                <div class="col-12">
                    <button type="submit" class="btn btn-dark py-3 btn-hover" id="singbtn">Ingresar</button>
                </div>
            </div>
        </form>

        <a href="/forgot-password" class="text-muted mt-3" style="font-size: 14px;">¿Olvidaste tu contraseña?</a>

        <?php
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $correo = $_POST["correo"];
            $password = $_POST["password"];

            $conn = new mysqli("localhost", "root", "", "prueba_db");

            if ($conn->connect_error) {
                die("Error de conexión: " . $conn->connect_error);
            }

            // Usamos sentencia preparada para evitar inyección SQL
            $stmt = $conn->prepare("SELECT * FROM users WHERE correo = ? AND password = ?");
            $stmt->bind_param("ss", $correo, $password);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                // Iniciar sesión y redirigir
                session_start();
                $_SESSION['correo'] = $correo;
                header("Location: /frontend/views/dashboard_admin.php");
                exit();
            } else {
                echo "<p style='color:red;'>Correo o contraseña incorrectos</p>";
            }

            $conn->close();
        }
        ?>
    </div>

    <!-- Scripts -->
    <script src="/frontend/public/js/scriptsDOM.js"></script>
    <script src="/frontend/public/js/validacion_login.js"></script>
</body>

</html>
