# --- Stage 1: Build the Spring Boot App with Maven + JDK 21 ---
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install -DskipTests

# --- Stage 2: Run the app using JDK 21 Runtime ---
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=builder /app/target/backend-0.0.2-SNAPSHOT.jar app.jar

# Expose backend port
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
