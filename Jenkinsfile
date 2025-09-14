pipeline {
  agent any
  options {
    timestamps()
    skipDefaultCheckout(false)
  }
  environment {
    // Optional: use a configured JDK installation from Jenkins (Manage Jenkins > Tools > JDK installations)
    // Replace 'jdk17' with your JDK tool name, or remove if agents already provide java.
    // JAVA_HOME = tool name: 'jdk17', type: 'jdk'
    // Example: JAVA_HOME = tool name: 'jdk17'
  }
  stages {
    stage('Build & Test') {
      steps {
        script {
          if (isUnix()) {
            sh 'chmod +x mvnw'
            sh './mvnw -B -ntp clean verify'
          } else {
            bat 'mvnw.cmd -B -ntp clean verify'
          }
        }
      }
      post {
        always {
          junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
        }
      }
    }

    stage('Package') {
      steps {
        script {
          if (isUnix()) {
            sh './mvnw -B -ntp package -DskipTests=false'
          } else {
            bat 'mvnw.cmd -B -ntp package -DskipTests=false'
          }
        }
      }
    }
  }
  post {
    success {
      archiveArtifacts artifacts: 'target/*.jar', fingerprint: true, onlyIfSuccessful: true
      echo 'Build succeeded.'
    }
    failure {
      echo 'Build failed.'
    }
  }
}
