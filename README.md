# Hello Node — Distribuida

## 1. Descripción General

La aplicación muestra un simple mensaje desde un servidor Node.js:

```js
res.send("Hello World from Santiago — deployed automatically 🚀");
````

Este mensaje se despliega en distintos servicios en la nube utilizando integraciones automáticas.

---

## 2.GitHub

**Pasos realizados:**

1. Inicialicé Git localmente en mi carpeta del proyecto.
2. Agregué todos los archivos del proyecto (`app.js`, `package.json`, `Dockerfile`, etc.).
3. Creé un repositorio público en GitHub llamado `hello-node-santiago`.
4. Conecté mi repositorio local al remoto con:

   ```bash
   git remote add origin https://github.com/stitches221622/hello-node-santiago.git
   git push -u origin main
   ```
5. GitHub ahora contiene el código fuente, el Dockerfile y el flujo automatizado (GitHub Actions).

**Repositorio:**
🔗 [https://github.com/stitches221622/hello-node-santiago](https://github.com/stitches221622/hello-node-santiago)

---

## 3.DockerHub

**Pasos realizados:**

1. Construí la imagen Docker localmente con:

   ```bash
   docker build -t stitches221622/hello-node:latest .
   ```
2. Probé que funcionara correctamente con:

   ```bash
   docker run -p 3000:3000 stitches221622/hello-node
   ```
3. Creé una cuenta en [DockerHub](https://hub.docker.com/).
4. Generé un token de acceso con permisos `Read, Write, Delete`.
5. Configuré GitHub Actions para publicar automáticamente en DockerHub en cada `git push`.

**Repositorio DockerHub:**
🔗 [https://hub.docker.com/r/stitches221622/hello-node](https://hub.docker.com/r/stitches221622/hello-node)

---

## 4. Automatización con GitHub Actions

**Archivo:** `.github/workflows/docker-publish.yml`

Este flujo se ejecuta automáticamente **cada vez que hago un `git push` al branch `main`**.
El proceso:

1. Descarga el código (`checkout`).
2. Inicia sesión en DockerHub con credenciales seguras (secrets).
3. Construye la imagen Docker.
4. Sube la imagen actualizada al repositorio de DockerHub.

```yaml
name: Publish Docker image

on:
  push:
    branches: [ main ]
    paths:
      - 'app.js'
      - 'Dockerfile'
      - 'package.json'
      - '.github/workflows/**'

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Log in to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: stitches221622/hello-node:latest
```

---

## 5. Despliegues

### 🔹 Netlify

**Tipo:** Aplicación estática (frontend)
**Pasos:**

1. Conecté el repositorio de GitHub directamente desde Netlify.
2. Configuré:

   * **Publish directory:** `static`
   * **Build command:** *(vacío)*
3. Netlify detectó automáticamente el proyecto y desplegó la página.

**URL Pública:**
🔗 [https://nombre-random.netlify.app](https://nombre-random.netlify.app)

**Capturas recomendadas:**

* `netlify-config.png` → configuración de deploy
* `netlify-deploy.png` → logs de publicación exitosa
* `netlify-site.png` → sitio funcionando

---

### 🔹 Railway

**Tipo:** Aplicación backend (Node.js con Docker)
**Pasos:**

1. Conecté Railway a mi repositorio GitHub.
2. Railway detectó el `Dockerfile` automáticamente.
3. Se desplegó la aplicación como un servicio web con puerto 3000.
4. Cada vez que hago un `push`, Railway vuelve a construir y desplegar automáticamente.

**URL Pública:**
🔗 [https://hello-node-production.up.railway.app](https://hello-node-production.up.railway.app)

**Capturas recomendadas:**

* `railway-config.png` → configuración del servicio
* `railway-deploy.png` → logs del despliegue
* `railway-site.png` → app funcionando

---

## 6. Conclusión

✅ Flujo completo automatizado:
GitHub → GitHub Actions → DockerHub → Railway / Netlify

Cada cambio que realizo en el código y subo con `git push`:

* Actualiza automáticamente la imagen en DockerHub
* Actualiza la aplicación desplegada en Railway
* No necesito reconstruir ni desplegar manualmente

---

```






