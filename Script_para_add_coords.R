#Hacer bases de datos a partir de la metadata en fotos de cámaras trampa
#install.packages("camtrapR") en caso de no tener el paquete

library(camtrapR)
Sys.which("exiftool")

# 0 Cargar tu tabla de coordenadas desde el portapapeles (en Windows)
data <- read.delim("clipboard")
head(data) # Verifica que se vea la columna ID, X y Y


# 1. Cargar tu tabla de coordenadas desde el portapapeles (en macOS)
# Tus columnas son: ID, X, Y
data <- read.delim(pipe("pbpaste"))
head(data) # Verifica que se vea la columna ID, X y Y

# 2. Definir ruta de las fotos
fotos_sitio_1 <- file.path("Sitio_1")

# 3. Generar la tabla de registros independientes con camtrapR (su columna se llama "Station")
tabla_sitio_1_independientes <- recordTable(inDir = fotos_sitio_1, IDfrom = "directory")

# 4. UNIR LAS COORDENADAS INDICANDO LAS COLUMNAS DIFERENTES:
# Relacionamos 'Station' (de las fotos) con 'ID' (de tu tabla copiada)
tabla_con_coordenadas <- merge(
  tabla_sitio_1_independientes, 
  data, 
  by.x = "Station",  # Nombre de la columna en la tabla de camtrapR
  by.y = "ID",       # Nombre de la columna en tu archivo copiado de Excel
  all.x = TRUE
)

# 5. Opcional: Reordenar las columnas para que X y Y queden justo al lado de Station
# (Esto pone a Station, X, Y y luego todas las demás columnas de la tabla)
nombres_cols <- names(tabla_con_coordenadas)
columnas_ordenadas <- c("Station", "X", "Y", nombres_cols[!nombres_cols %in% c("Station", "X", "Y")])
tabla_con_coordenadas <- tabla_con_coordenadas[, columnas_ordenadas]

# 6. Guardar la nueva tabla resultante con coordenadas ordenadas
write.csv(tabla_con_coordenadas, "tabla_sitio_1_con_coordenadas.csv", row.names = FALSE)

# Leer para comprobar el resultado final
read.csv("tabla_sitio_1_con_coordenadas.csv", header = TRUE)
