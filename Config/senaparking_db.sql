-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-01-2025 a las 06:15:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `senaparking_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` bigint(20) NOT NULL,
  `usuarios_sistema_id` bigint(20) DEFAULT NULL,
  `puede_ver_reportes` tinyint(1) DEFAULT 0,
  `puede_ver_trazabilidad_guardas` tinyint(1) DEFAULT 0,
  `puede_registrar_usuarios` tinyint(1) DEFAULT 0,
  `puede_eliminar_usuarios` tinyint(1) DEFAULT 0,
  `puede_modificar_usuarios` tinyint(1) DEFAULT 0,
  `puede_consultar_usuarios` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_acceso`
--

CREATE TABLE `registros_acceso` (
  `id` bigint(20) NOT NULL,
  `usuarios_sistema_id` bigint(20) DEFAULT NULL,
  `accion` enum('Ingreso','Salida','Reportes') DEFAULT NULL,
  `marca_tiempo` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_actividad_usuarios`
--

CREATE TABLE `registros_actividad_usuarios` (
  `id` bigint(20) NOT NULL,
  `usuarios_sistema_id` bigint(20) DEFAULT NULL,
  `actividad` varchar(255) NOT NULL,
  `marca_tiempo` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_parqueadero`
--

CREATE TABLE `usuarios_parqueadero` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cedula` varchar(255) NOT NULL,
  `tarjeta_propiedad` varchar(255) DEFAULT NULL,
  `correo_institucional` varchar(255) DEFAULT NULL,
  `numero_contacto` varchar(255) DEFAULT NULL,
  `tipo_usuario` enum('Servidor público','Contratista','Trabajador Oficial','Visitante Autorizado','Aprendiz') NOT NULL,
  `hora_entrada` timestamp NULL DEFAULT NULL,
  `hora_salida` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_sistema`
--

CREATE TABLE `usuarios_sistema` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `rol` enum('Guarda','Supervisor','Director general') NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `numero_contacto` varchar(255) NOT NULL,
  `nombre_usuario` varchar(255) NOT NULL,
  `contraseña` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehículos`
--

CREATE TABLE `vehiculos` (
  `id` bigint(20) NOT NULL,
  `placa` varchar(255) NOT NULL,
  `modelo` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `tipo_vehiculo` enum('Ciclas','Carros','Vehículos Oficiales','Aulas Móviles') NOT NULL,
  `usuarios_parqueadero_id` bigint(20) DEFAULT NULL,
  `hora_entrada` timestamp NOT NULL DEFAULT current_timestamp(),
  `hora_salida` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `vehiculos`
--
DELIMITER $$
CREATE TRIGGER `before_vehiculos_insert` BEFORE INSERT ON `vehiculos` FOR EACH ROW BEGIN
    DECLARE tipo_usuario_actual VARCHAR(255);
    
    -- Obtener el tipo de usuario del usuario de parqueadero
    SELECT tipo_usuario INTO tipo_usuario_actual
    FROM usuarios_parqueadero
    WHERE id = NEW.usuarios_parqueadero_id;
    
    -- Verificar la restricción
    IF tipo_usuario_actual = 'Aprendiz' AND NEW.tipo_vehiculo <> 'Ciclas' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los usuarios de tipo Aprendiz solo pueden ingresar Ciclas';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_vehiculos_update` BEFORE UPDATE ON `vehiculos` FOR EACH ROW BEGIN
    DECLARE tipo_usuario_actual VARCHAR(255);
    
    -- Obtener el tipo de usuario del usuario de parqueadero
    SELECT tipo_usuario INTO tipo_usuario_actual
    FROM usuarios_parqueadero
    WHERE id = NEW.usuarios_parqueadero_id;
    
    -- Verificar la restricción
    IF tipo_usuario_actual = 'Aprendiz' AND NEW.tipo_vehiculo <> 'Ciclas' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los usuarios de tipo Aprendiz solo pueden ingresar Ciclas';
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_sistema_id` (`usuarios_sistema_id`);

--
-- Indices de la tabla `registros_acceso`
--
ALTER TABLE `registros_acceso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_sistema_id` (`usuarios_sistema_id`);

--
-- Indices de la tabla `registros_actividad_usuarios`
--
ALTER TABLE `registros_actividad_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_sistema_id` (`usuarios_sistema_id`);

--
-- Indices de la tabla `usuarios_parqueadero`
--
ALTER TABLE `usuarios_parqueadero`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cedula` (`cedula`);

--
-- Indices de la tabla `usuarios_sistema`
--
ALTER TABLE `usuarios_sistema`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo_electronico` (`correo_electronico`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `usuarios_parqueadero_id` (`usuarios_parqueadero_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registros_acceso`
--
ALTER TABLE `registros_acceso`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registros_actividad_usuarios`
--
ALTER TABLE `registros_actividad_usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios_parqueadero`
--
ALTER TABLE `usuarios_parqueadero`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios_sistema`
--
ALTER TABLE `usuarios_sistema`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`usuarios_sistema_id`) REFERENCES `usuarios_sistema` (`id`);

--
-- Filtros para la tabla `registros_acceso`
--
ALTER TABLE `registros_acceso`
  ADD CONSTRAINT `registros_acceso_ibfk_1` FOREIGN KEY (`usuarios_sistema_id`) REFERENCES `usuarios_sistema` (`id`);

--
-- Filtros para la tabla `registros_actividad_usuarios`
--
ALTER TABLE `registros_actividad_usuarios`
  ADD CONSTRAINT `registros_actividad_usuarios_ibfk_1` FOREIGN KEY (`usuarios_sistema_id`) REFERENCES `usuarios_sistema` (`id`);

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `vehiculos_ibfk_1` FOREIGN KEY (`usuarios_parqueadero_id`) REFERENCES `usuarios_parqueadero` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
