pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        build(quietPeriod: -2, job: '1')
        sh '/var/lib/jenkins/tools/hudson.tasks.Maven_MavenInstallation/maven-builder/bin/mvn install'
      }
    }
  }
}