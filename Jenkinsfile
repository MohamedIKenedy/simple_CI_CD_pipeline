pipeline {
  agent { label 'linux' }
  options {
    timestamps()
    skipDefaultCheckout(false)
  }
  stages {
    stage('Build') {
      steps {
        sh '''
          set -euxo pipefail
          mkdir -p logs
          chmod +x mvnw
          ./mvnw -B -ntp clean compile -DskipTests 2>&1 | tee logs/build.log
        '''
      }
      post {
        always {
          archiveArtifacts allowEmptyArchive: true, artifacts: 'logs/build.log', onlyIfSuccessful: false
        }
      }
    }

    stage('Test') {
      steps {
        sh '''
          set -euxo pipefail
          ./mvnw -B -ntp test 2>&1 | tee logs/test.log
        '''
      }
      post {
        always {
          junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
          archiveArtifacts allowEmptyArchive: true, artifacts: 'logs/test.log', onlyIfSuccessful: false
        }
      }
    }

    stage('Package') {
      steps {
        sh '''
          set -euxo pipefail
          ./mvnw -B -ntp package -DskipTests=false 2>&1 | tee -a logs/build.log
        '''
      }
      post {
        success {
          archiveArtifacts artifacts: 'target/*.jar', fingerprint: true, onlyIfSuccessful: true
        }
      }
    }
  }
  post {
    always {
      archiveArtifacts allowEmptyArchive: true, artifacts: 'logs/*.log', onlyIfSuccessful: false
    }
  }
}
