# Laboratorio de Trivy

Repositorio de apoyo para la masterclass de Trivy. Todas las credenciales que contiene son falsas.

## Contenido

- `vulnerable-app/` app Flask con dependencias antiguas, secretos de mentira en `config.py` y un Dockerfile con malas prácticas.
- `fixed-app/` la misma app corregida, para comparar.
- `iac/bad/` y `iac/fixed/` Terraform inseguro y su versión corregida.
- `scripts/` preparación y copia de seguridad de las salidas.
- `outputs/` aquí se guardan las salidas del plan B.

## Antes de la clase

```bash
./scripts/prepare.sh
./scripts/save-outputs.sh
```

Requiere Docker y conexión a internet. La primera descarga la base de datos de Trivy.

## Atajo en la terminal

```bash
source scripts/common.sh
trivy image nginx:alpine
```

Con eso `trivy` funciona como comando normal, ejecutado en Docker.

## Ensayo

Las salidas exactas dependen del día en que se descargue la base de datos. Ensaya todo una vez antes de la clase y no te fíes de números concretos de memoria.
# lab-trivy
