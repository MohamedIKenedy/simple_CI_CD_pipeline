# Simple Jenkins Pipeline Java Project

This is a basic Java project using Maven, designed to demonstrate a simple Jenkins CI/CD pipeline with multiple stages and comprehensive logging.

## Project Structure
- `src/main/java` - Java source code
- `src/test/java` - Unit tests
- `pom.xml` - Maven configuration
- `Jenkinsfile` - Jenkins pipeline definition
- `logs/` - Pipeline execution logs (created during build)

## Local Build and Test
1. Make sure you have Java (JDK 8 or later) installed
2. Open a terminal in the project directory
3. Run the Maven wrapper commands:
   ```bash
   # Clean and compile
   .\mvnw.cmd clean compile
   
   # Run tests
   .\mvnw.cmd test
   
   # Package the application
   .\mvnw.cmd package
   ```

## Jenkins Pipeline Features

The `Jenkinsfile` includes the following stages:

### 1. **Preparation Stage**
- Displays environment information
- Creates logs directory
- Checks Java version

### 2. **Clean Stage**
- Cleans previous build artifacts
- Logs the clean operation

### 3. **Compile Stage**
- Compiles the Java source code
- Logs compilation results

### 4. **Test Stage**
- Runs unit tests
- Publishes test results
- Archives test reports

### 5. **Package Stage**
- Creates JAR file
- Skips tests during packaging (already run in Test stage)

### 6. **Archive Stage**
- Verifies JAR creation
- Logs artifact information

## Pipeline Logging

The pipeline creates comprehensive logs in the `logs/` directory:
- `pipeline.log` - Main pipeline execution log
- All stages append their status to this log
- Timestamps are included for each operation
- Final log is displayed at the end of execution

## Setting Up Jenkins

1. **Install Jenkins** on your system
2. **Create a new Pipeline job**:
   - Go to Jenkins → New Item
   - Enter job name (e.g., "Simple Java Pipeline")
   - Select "Pipeline" and click OK

3. **Configure the Pipeline**:
   - In the job configuration, scroll to "Pipeline" section
   - Select "Pipeline script from SCM"
   - Choose your SCM (Git, etc.)
   - Enter your repository URL
   - Set the branch (e.g., `*/main`)
   - Set Script Path to `Jenkinsfile`

4. **Run the Pipeline**:
   - Click "Build Now"
   - Monitor the console output
   - Check the archived artifacts and logs

## What the Pipeline Does

✅ **Multi-stage execution** with clear separation of concerns  
✅ **Comprehensive logging** with timestamps  
✅ **Windows batch command compatibility**  
✅ **Test result publishing** with JUnit integration  
✅ **Artifact archiving** for JAR files and logs  
✅ **Error handling** with proper cleanup  
✅ **Environment information** display  

## Troubleshooting

- **Java not found**: Ensure Java is installed and in PATH
- **Maven commands fail**: Use the Maven wrapper (`mvnw.cmd`) instead of `mvn`
- **Pipeline fails on Windows**: The Jenkinsfile is optimized for Windows batch commands
- **No test results**: Check that tests are in `src/test/java` directory

## Project Output

When successful, the pipeline will:
- Generate a JAR file in `target/` directory
- Create test reports in `target/surefire-reports/`
- Archive build logs in `logs/` directory
- Display comprehensive execution information
