FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# copy from the other (builder) phase
COPY --from=builder /app/build /usr/share/nginx/html
# nginx will start by itself; do not have to enter specific running command