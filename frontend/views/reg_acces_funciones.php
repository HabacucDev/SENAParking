 <?php

/**
 *() Valida si un campo está vacío.
 */
function validarCampoRequerido(string $valor, string $nombreCampo): ?string {
    if (empty(trim($valor))) {
        return "$nombreCampo es un campo requerido.";
    }
    return null;
}

/**
 * Valida la longitud de un string.
 */
function validarLongitud(string $valor, string $nombreCampo, int $minimo, int $maximo): ?string {
    $longitud = strlen($valor);
    if ($longitud < $minimo) {
        return "$nombreCampo debe tener al menos $minimo caracteres.";
    }
    if ($longitud > $maximo) {
        return "$nombreCampo no puede tener más de $maximo caracteres.";
    }
    return null;
}

/**
 * Valida un string contra un patrón de expresión regular.
 */
function validarFormato(string $valor, string $nombreCampo, string $patron, string $mensajeError): ?string {
    if (!preg_match($patron, $valor)) {
        return "$nombreCampo $mensajeError";
    }
    return null;
}

/**
 * Valida el nombre (letras y longitud).
 */
function validarNombre(string $nombre, string $nombreCampo = 'Nombre'): ?string {
    $errorRequerido = validarCampoRequerido($nombre, $nombreCampo);
    if ($errorRequerido !== null) {
        return $errorRequerido;
    }
    return validarLongitud($nombre, $nombreCampo, 4, 70);
    // Alternativamente, se podría usar:
    // return validarFormato($nombre, $nombreCampo, '/^[a-zA-ZÀ-ÿ]{4,70}$/', 'debe contener solo letras y tener entre 4 y 70 caracteres.');
}

/**
 * Valida el documento (números y longitud).
 */
function validarDocumento(string $documento, string $nombreCampo = 'Documento'): ?string {
    $errorRequerido = validarCampoRequerido($documento, $nombreCampo);
    if ($errorRequerido !== null) {
        return $errorRequerido;
    }
    return validarLongitud($documento, $nombreCampo, 6, 10);
    // Alternativamente:
    // return validarFormato($documento, $nombreCampo, '/^\d{6,10}$/', 'debe contener solo números y tener entre 6 y 10 dígitos.');
}
?>