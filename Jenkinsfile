pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        build(quietPeriod: -2, job: '1')
        sh 'mvn install'
      }
    }
  }
}
