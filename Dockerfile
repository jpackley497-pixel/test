# Use Node 20
FROM node:20

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

# Serve the built files using a lightweight server
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-l", "3000"]
