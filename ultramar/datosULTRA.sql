# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : ultramarina


SET FOREIGN_KEY_CHECKS=0;

USE `ultramarina`;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

# IDEmpleado:3:49703
# ClaveU:253:0
# Contra:3:32801
# Nombre:253:1
# APaterno:253:1
# AMaterno:253:0
# Tipo:3:32768
# Activo:3:32769

INSERT INTO `empleados` (`IDEmpleado`, `ClaveU`, `Contra`, `Nombre`, `APaterno`, `AMaterno`, `Tipo`, `Activo`) VALUES 
  (1,NULL,2303,'Enrique','Fernández','Jaimes',0,1),
  (2,NULL,2303,'Sofía','Gabián','Domínguez',0,1);

COMMIT;

#
# Data for the `division` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# area:3:32768
# estatus:3:32768

INSERT INTO `division` (`clave`, `nombre`, `area`, `estatus`) VALUES 
  (1,'Entradas',1,0),
  (2,'Sopas',1,0),
  (3,'Pollos',1,1),
  (4,'Preparadas',2,1),
  (5,'Tequila',2,1),
  (6,'Carnes',1,1),
  (7,'Wiskhy',2,1);

COMMIT;

#
# Data for the `bebidas` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# descripcion:253:0
# materia0:3:32768
# materia1:3:32768
# materia2:3:32768
# materia3:3:32768
# materia4:3:32768
# materia5:3:32768
# materia6:3:32768
# materia7:3:32768
# materia8:3:32768
# materia9:3:32768
# cantidad0:5:32768
# cantidad1:5:32768
# cantidad2:5:32768
# cantidad3:5:32768
# cantidad4:5:32768
# cantidad5:5:32768
# cantidad6:5:32768
# cantidad7:5:32768
# cantidad8:5:32768
# cantidad9:5:32768
# precioC:5:32768
# precioB:5:32768
# division:3:32768
# estatus:3:32768
# alcoholica:3:32768

INSERT INTO `bebidas` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precioC`, `precioB`, `division`, `estatus`, `alcoholica`) VALUES 
  (1,'Tequila Jimador','Reposado',1,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,10.00,100.00,5,1,1),
  (2,'Piña Colada','Refrescante y tropical',6,7,0,0,0,0,0,0,0,0,0.150,0.450,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,10.00,0.00,4,1,1),
  (3,'Don Julio Conmemorativo','Añejado por 12 años',9,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,500.00,5,1,1),
  (4,'Paloma Jimador','Refrescante y Tradicional',1,8,0,0,0,0,0,0,0,0,0.200,0.600,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,0.00,4,1,1);

COMMIT;

#
# Data for the `alimentos` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# descripcion:253:0
# materia0:3:32768
# materia1:3:32768
# materia2:3:32768
# materia3:3:32768
# materia4:3:32768
# materia5:3:32768
# materia6:3:32768
# materia7:3:32768
# materia8:3:32768
# materia9:3:32768
# cantidad0:5:32768
# cantidad1:5:32768
# cantidad2:5:32768
# cantidad3:5:32768
# cantidad4:5:32768
# cantidad5:5:32768
# cantidad6:5:32768
# cantidad7:5:32768
# cantidad8:5:32768
# cantidad9:5:32768
# precio:5:32768
# division:3:32768
# estatus:3:32768

INSERT INTO `alimentos` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precio`, `division`, `estatus`) VALUES 
  (1,'Pechuga Parmesana','Pechuga de Pollo con Queso Parmesano y Arroz Blanco',5,2,3,4,0,0,0,0,0,0,0.500,0.200,0.750,0.100,0.000,0.000,0.000,0.000,0.000,0.000,60.00,3,1),
  (2,'Pechuga a la Plancha','Pechuga de Pollo y Arroz Blanco',5,2,12,4,0,0,0,0,0,0,0.500,0.200,0.120,0.100,0.000,0.000,0.000,0.000,0.000,0.000,50.00,3,1),
  (3,'Carne Asada','Carne Asada con Frijoles y guacamole',10,11,0,0,0,0,0,0,0,0,0.300,0.150,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,80.00,6,1);

COMMIT;

