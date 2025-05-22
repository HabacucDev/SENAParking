<?php
require_once 'reg_acces_funciones.php'; // Incluye el archivo de validaciones

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Obtener los datos del formulario
    $nombre = $_POST['nombre'] ?? '';  // Usar ?? para evitar errores si no existe
    $documento = $_POST['documento'] ?? '';

    // 2. Validar los datos
    $errores = []; // Array para almacenar los mensajes de error
    $errores['nombre'] = validarNombre($nombre);
    $errores['documento'] = validarDocumento($documento);

    // 3. Filtrar los errores (eliminar los valores null)
    $errores = array_filter($errores);

    // 4. Comprobar si hay errores
    if (empty($errores)) {
        // Si no hay errores, procesar los datos (guardar en la base de datos, etc.)
        echo "Formulario enviado correctamente.";
        // Aquí iría tu lógica para guardar los datos en la base de datos
    } else {
        // Si hay errores, mostrar un mensaje al usuario o redirigir al formulario
        // con los errores.  La forma más común es redirigir y usar una sesión.
        session_start();
        $_SESSION['errores'] = $errores;
        $_SESSION['nombre_valor'] = $nombre;       // Guardar el valor del nombre
        $_SESSION['documento_valor'] = $documento; // Guardar el valor del documento
        header('Location: tu_formulario.php'); // Redirige al formulario
        exit;
    }
} else {
    // Si el formulario no se envió por POST, redirigir a la página del formulario
    header('Location: tu_formulario.php');
    exit;
}
?>
