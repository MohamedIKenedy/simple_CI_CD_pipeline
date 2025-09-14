pipeline {
  agent any
  options { timestamps() }
  stages {
    stage('Build') {
      steps {
        script {
          if (isUnix()) {
            sh 'chmod +x mvnw || true; ./mvnw -B -ntp clean package -DskipTests'
          } else {
            bat 'mvnw.cmd -B -ntp clean package -DskipTests'
          }
        }
      }
    }
    stage('Test') {
      steps {
        script {
          if (isUnix()) {
            sh './mvnw -B -ntp test'
          } else {
            bat 'mvnw.cmd -B -ntp test'
          }
        }
      }
      post {
        always {
          junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
        }
      }
    }
  }
  post {
    success {
      archiveArtifacts artifacts: 'target/*.jar', fingerprint: true, onlyIfSuccessful: true
    }
  }
}
