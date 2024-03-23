# Stage 1: Build the Go application
FROM golang:alpine AS builder

WORKDIR /go/src/app

# Copy the Go source code
COPY . .

# Build the Go application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/bin/app

# Stage 2: Create a minimal Docker image to run the application
FROM alpine:latest

# Copy the built executable from the previous stage
COPY --from=builder /go/bin/app /usr/local/bin/app

# Set the working directory for the application
WORKDIR /usr/local/bin

# Expose the port on which the Go application will run
EXPOSE 80

# Command to run the Go application
CMD ["app"]
