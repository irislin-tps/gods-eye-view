# Zeabur / container deployment: build the browser bundle, then serve it with
# `vite preview`, which also mounts the /api provider middlewares (flights,
# terrain, CCTV proxies, ...). Keyless mode: no provider secrets baked in.
FROM node:24-alpine
WORKDIR /app

ENV PUPPETEER_SKIP_DOWNLOAD=1
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

ENV HOST=0.0.0.0
EXPOSE 4173
CMD ["sh", "-c", "npm run preview -- --host 0.0.0.0 --port ${PORT:-4173}"]
