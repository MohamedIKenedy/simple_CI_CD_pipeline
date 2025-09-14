pipeline {
  agent any
  options {
    timestamps()
    skipDefaultCheckout(false)
  }
  stages {
    stage('Build') {
      steps {
        script {
          if (isUnix()) {
            sh '''
              set -euxo pipefail
              mkdir -p logs
              chmod +x mvnw
              ./mvnw -B -ntp clean compile -DskipTests 2>&1 | tee logs/build.log
            '''
          } else {
            bat '''
              powershell -NoProfile -ExecutionPolicy Bypass -Command "^ 
                $ErrorActionPreference='Stop'; ^
                if(!(Test-Path 'logs')){ New-Item -ItemType Directory -Force -Path 'logs' | Out-Null }; ^
                & .\\mvnw.cmd -B -ntp clean compile -DskipTests 2^>^&1 | Tee-Object -FilePath 'logs\\build.log'; ^
                if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE } ^
              "
            '''
          }
        }
      }
      post {
        always {
          archiveArtifacts allowEmptyArchive: true, artifacts: 'logs/build.log', onlyIfSuccessful: false
        }
      }
    }

    stage('Test') {
      steps {
        script {
          if (isUnix()) {
            sh '''
              set -euxo pipefail
              ./mvnw -B -ntp test 2>&1 | tee logs/test.log
            '''
          } else {
            bat '''
              powershell -NoProfile -ExecutionPolicy Bypass -Command "^ 
                $ErrorActionPreference='Stop'; ^
                & .\\mvnw.cmd -B -ntp test 2^>^&1 | Tee-Object -FilePath 'logs\\test.log'; ^
                if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE } ^
              "
            '''
          }
        }
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
        script {
          if (isUnix()) {
            sh '''
              set -euxo pipefail
              ./mvnw -B -ntp package -DskipTests=false 2>&1 | tee -a logs/build.log
            '''
          } else {
            bat '''
              powershell -NoProfile -ExecutionPolicy Bypass -Command "^ 
                $ErrorActionPreference='Stop'; ^
                & .\\mvnw.cmd -B -ntp package -DskipTests=false 2^>^&1 | Tee-Object -FilePath 'logs\\build.log' -Append; ^
                if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE } ^
              "
            '''
          }
        }
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
