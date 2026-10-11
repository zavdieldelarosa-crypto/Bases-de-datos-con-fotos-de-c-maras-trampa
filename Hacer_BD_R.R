#Hacer bases de datos a partir de la metadata en fotos de cámaras trampa
#install.packages("camtrapR")

library(camtrapR)
Sys.which("exiftool")
#desde Windows Esta líena es para copiar un archivo con coordenadas directo sin tener que cargar el archivo
data <- read.delim("clipboard")
data
str(data)
######
#desde MacOS
data <- read.delim(pipe("pbpaste"))
data
str(data)
####

sitio_1 = data
fotos_sitio_1 <- file.path("Sitio_1")
#fotos_sitio_1_carpeta <- createStationFolders(inDir = fotos_sitio_1, stations = as.character(sitio_1$Station) , createinDir = TRUE)
#especies_sitio_1 <- c("Canis latrans", "Conepatus leuconotus", "Ctenosaura acanthura", "Cuniculus paca", "Dasypus novemcinctus", "Dicotyles tajacu", "Didelphis marsupialis", "Didelphis virginiana", "Eira barbara", "Herpailurus yagouaroundi", "Leopardus pardalis", "Leopardus wiedii", "Lynx rufus", "Mazama temama", "Mephitis macroura", "Nasua narica", "Odocoileus virginianus", "Panthera onca", "Procyon lotor", "Puma concolor", "Sciurus aureogaster", "Sciurus deppei", "Sciurus sp", "Sylvilagus floridanus", "Urocyon cinereoargenteus", "Ursus americanus")
#createSpeciesFolders(inDir = fotos_sitio_1, species = especies_sitio_1, hasCameraFolders = FALSE, removeFolders = FALSE)
tabla_sitio_1_independientes <- recordTable(inDir = fotos_sitio_1, IDfrom = "directory")
write.csv(tabla_sitio_1_independientes, "tabla sitio 1 independientes.csv")
read.csv("tabla sitio 1 independientes.csv", header = T)
