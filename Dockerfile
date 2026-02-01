# Build stage
FROM node:13-alpine AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production
COPY src ./src
COPY spec ./spec

# Production stage
FROM node:13-alpine
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/src ./src
COPY --from=build /app/spec ./spec
COPY package.json ./
CMD ["node", "src/index.js"]