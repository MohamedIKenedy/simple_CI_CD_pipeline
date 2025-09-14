pipeline {
    agent any
    
    options {
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
    }
    
    environment {
        MAVEN_OPTS = '-Dmaven.repo.local=.m2/repository'
    }
    
    stages {
        stage('Preparation') {
            steps {
                echo '=== Starting CI/CD Pipeline ==='
                echo "Workspace: ${env.WORKSPACE}"
                echo "Build Number: ${env.BUILD_NUMBER}"
                echo "Java Version Check:"
                bat 'java -version'
                
                echo '=== Creating logs directory ==='
                bat '''
                    if not exist "logs" mkdir logs
                    echo Pipeline started at %date% %time% > logs\\pipeline.log
                '''
            }
        }
        
        stage('Clean') {
            steps {
                echo '=== Cleaning previous builds ==='
                bat '''
                    echo === Clean Stage Started === >> logs\\pipeline.log
                    mvnw.cmd clean
                    echo === Clean Stage Completed === >> logs\\pipeline.log
                '''
            }
        }
        
        stage('Compile') {
            steps {
                echo '=== Compiling the project ==='
                bat '''
                    echo === Compile Stage Started === >> logs\\pipeline.log
                    mvnw.cmd -B -ntp compile
                    echo === Compile Stage Completed === >> logs\\pipeline.log
                '''
            }
        }
        
        stage('Test') {
            steps {
                echo '=== Running unit tests ==='
                bat '''
                    echo === Test Stage Started === >> logs\\pipeline.log
                    mvnw.cmd -B -ntp test
                    echo === Test Stage Completed === >> logs\\pipeline.log
                '''
            }
            post {
                always {
                    echo '=== Publishing test results ==='
                    junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
                    
                    bat '''
                        if exist "target\\surefire-reports\\*.xml" (
                            echo Test reports generated successfully >> logs\\pipeline.log
                        ) else (
                            echo No test reports found >> logs\\pipeline.log
                        )
                    '''
                }
            }
        }
        
        stage('Package') {
            steps {
                echo '=== Packaging the application ==='
                bat '''
                    echo === Package Stage Started === >> logs\\pipeline.log
                    mvnw.cmd -B -ntp package -DskipTests
                    echo === Package Stage Completed === >> logs\\pipeline.log
                '''
            }
        }
        
        stage('Archive') {
            steps {
                echo '=== Archiving artifacts ==='
                bat '''
                    echo === Archive Stage Started === >> logs\\pipeline.log
                    if exist "target\\*.jar" (
                        echo JAR file created successfully >> logs\\pipeline.log
                        dir target\\*.jar >> logs\\pipeline.log
                    ) else (
                        echo No JAR file found >> logs\\pipeline.log
                    )
                    echo === Archive Stage Completed === >> logs\\pipeline.log
                '''
            }
        }
    }
    
    post {
        always {
            echo '=== Pipeline completed ==='
            bat '''
                echo === Pipeline Finished at %date% %time% === >> logs\\pipeline.log
                echo. >> logs\\pipeline.log
                echo === Final Pipeline Log === >> logs\\pipeline.log
                type logs\\pipeline.log
            '''
        }
        success {
            echo '=== Pipeline completed successfully ==='
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true, onlyIfSuccessful: true
            archiveArtifacts artifacts: 'logs/*.log', fingerprint: true, allowEmptyArchive: true
        }
        failure {
            echo '=== Pipeline failed ==='
            bat 'echo Pipeline failed at %date% %time% >> logs\\pipeline.log'
        }
        cleanup {
            echo '=== Cleaning up workspace ==='
            bat '''
                echo Cleaning up temporary files...
                if exist "logs\\pipeline.log" copy logs\\pipeline.log logs\\pipeline-backup.log
            '''
        }
    }
}
