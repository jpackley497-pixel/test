# Stage 1: Build
FROM node:20 AS build

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json pnpm-workspace.yaml ./

# Install pnpm globally
RUN npm install -g pnpm

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the project
COPY . .

# Build the project
RUN pnpm run build

# Stage 2: Serve
FROM node:20-alpine

# Install a lightweight static server
RUN npm install -g serve

# Copy built files from previous stage
COPY --from=build /app/dist /app/dist

# Set working directory
WORKDIR /app

# Use Koyeb's port environment variable
ENV PORT=$PORT

# Expose the port
EXPOSE $PORT

# Command to start the server
CMD ["sh", "-c", "serve -s dist -l $PORT"]
