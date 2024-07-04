# Stage 1: Build the application
FROM maven:3.8.6-openjdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper scripts and .mvn directory into the container
COPY .mvn .mvn
COPY mvnw .
COPY mvnw.cmd .

# Copy the pom.xml file to download dependencies
COPY pom.xml .

# Download the project dependencies
RUN ./mvnw dependency:go-offline

# Copy the rest of the project files
COPY . .

# Build the application
RUN ./mvnw package

# Stage 2: Run the application
FROM openjdk:8-jre-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/simple-java-maven-app-1.0-SNAPSHOT.jar .

# Run the application
ENTRYPOINT ["java", "-jar", "simple-java-maven-app-1.0-SNAPSHOT.jar"]
