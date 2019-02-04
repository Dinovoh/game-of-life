pipeline {
  agent any
  tools {
    jdk 'jdk8'
    maven 'maven3'
  }
  stages {
    stage('Build') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml install'
      }
    }
  }
}
