FROM node:14.4.0-alpine AS build
WORKDIR /build
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:14.4.0-alpine
WORKDIR /app
COPY --from=build /build/package*.json ./
RUN npm install --only=production
COPY --from=build /build/dist ./dist
EXPOSE 3000
CMD ["node", "dist/main"]