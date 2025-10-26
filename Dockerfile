# --------- Stage 1: Chuẩn bị dependencies (cache tốt) ---------
FROM node:22-alpine AS deps
WORKDIR /app

# Chỉ copy manifest để tận dụng cache
COPY package*.json ./
COPY client/package*.json ./client/
COPY server/package*.json ./server/

RUN npm install
# --------- Stage 2: Build client ---------
FROM node:22-alpine AS build
WORKDIR /app
# Copy node_modules đã cài sẵn từ stage deps để khỏi cài lại
COPY --from=deps /app/node_modules ./node_modules
# Copy toàn bộ source
COPY . .
# Build client (theo scripts của bạn)
RUN npm run build

# --------- Stage 3: Runtime gọn nhẹ ---------
FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
# Copy mã nguồn server (đã có node_modules tối thiểu ở stage deps)
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/server ./server

# Copy artifact build của client (dist) để server phục vụ static (nếu bạn cấu hình express.static)
COPY --from=build /app/client/dist ./client/dist
EXPOSE 3000

CMD ["node", "server/index.js"]