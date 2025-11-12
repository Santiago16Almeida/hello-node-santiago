# Dockerfile - Node.js simple
FROM node:18-alpine

# Crear directorio de trabajo
WORKDIR /usr/src/app

# Copiar package.json y package-lock.json (si existe) para optimizar cache
COPY package*.json ./

# Instalar dependencias (production)
RUN npm ci --only=production

# Copiar el resto de archivos de la app
COPY . .

# Puerto en que la app escuchará
ENV PORT=3000
EXPOSE 3000

# Comando para iniciar la app
CMD ["npm", "start"]
