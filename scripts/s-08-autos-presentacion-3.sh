#!/bin/bash
#@Autor: Emanuel Flores Martínez
#@Fecha creación: dd/mm/yyyy
#@Descripción: Copia archivos binarios

#En caso de no econtrar el directorio, extrae el contenido del zip
if [ ! -d "/tmp/bdd/proyecto-final/imagenes/autos" ]; then
  echo "Copiando zip de autos"
  mkdir -p /tmp/bdd/proyecto-final/imagenes/autos
  unzip carga-inicial/imagenes/autos.zip -d /tmp/bdd/proyecto-final/imagenes

else
  echo "Las imagenes para autos ya fueron copiadas."
fi

if [ ! -d "/tmp/bdd/proyecto-final/imagenes/recibos" ]; then
  echo "Copiando zip de recibos de pago"
  mkdir -p /tmp/bdd/proyecto-final/imagenes/recibos
  unzip carga-inicial/imagenes/recibos.zip -d /tmp/bdd/proyecto-final/imagenes
else
  echo "Las imagenes para recibos ya fueron copiadas."
fi

chmod 755 /tmp/bdd/proyecto-final
chmod 755 /tmp/bdd/proyecto-final/imagenes
chmod 755 /tmp/bdd/proyecto-final/imagenes/autos
chmod 755 /tmp/bdd/proyecto-final/imagenes/recibos