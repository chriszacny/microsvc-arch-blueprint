# Use an official Node.js runtime as the base image
FROM node:alpine

# Set the working directory in the container
RUN mkdir /app
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React app
# TODO (cmz): this isn't being used ATM, package the build later with Express, et. al.
RUN npm run build

# Set environment variables if needed (e.g., for production)
# ENV REACT_APP_API_URL=https://api.example.com

# Expose the port that the app will run on (default for create-react-app is 3000)
EXPOSE 3000

# Command to start the app
CMD ["npm", "start"]
