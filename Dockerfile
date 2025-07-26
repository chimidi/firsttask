# Stage 1: Build the JAR
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the JAR
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.war app.war


# Expose the port your app will listen on
EXPOSE 8080

# Set the entry point to run the JAR
ENTRYPOINT ["java", "-jar", "app.war", "--server.port=8080"]
