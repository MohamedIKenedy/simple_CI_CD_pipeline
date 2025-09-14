# Simple Jenkins Pipeline Java Project

This is a basic Java project using Maven, designed to demonstrate a simple Jenkins CI/CD pipeline. It includes:
- A main class that prints "Hello, Jenkins!"
- A unit test for the main class
- Instructions for building, testing, and setting up Jenkins

## Project Structure
- `src/main/java` - Java source code
- `src/test/java` - Unit tests
- `pom.xml` - Maven configuration

## How to Build and Test
1. Make sure you have Java (JDK 8 or later) and Maven installed.
2. Open a terminal in the project directory.
3. Run `mvn clean package` to build and test the project.

## Jenkins Pipeline
A `Jenkinsfile` will be added to automate build and test steps. Follow the instructions in this README and the Jenkinsfile comments to set up your pipeline.
