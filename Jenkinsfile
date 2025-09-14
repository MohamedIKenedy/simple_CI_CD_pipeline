pipeline {
  agent any
  options { timestamps() }
  stages {
    stage('Build and Test') {
      steps {
        script {
          if (isUnix()) {
            sh 'chmod +x mvnw || true; ./mvnw -B -ntp clean verify'
          } else {
            bat 'mvnw.cmd -B -ntp clean verify'
          }
        }
      }
      post {
        always {
          junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
          archiveArtifacts artifacts: 'target/*.jar', fingerprint: true, onlyIfSuccessful: true
        }
      }
    }
  }
}
