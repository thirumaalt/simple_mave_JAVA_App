# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Compile and package the application (assuming Maven is used)
RUN ./mvnw package

# Specify the JAR file to run
ENTRYPOINT ["java", "-jar", "target/simple-java-maven-app-1.0-SNAPSHOT.jar"]
