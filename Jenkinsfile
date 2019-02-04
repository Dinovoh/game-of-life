pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        build(quietPeriod: -2, job: '1')
        sh '/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/maven3/apache-maven-3.6.0/bin/mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml install'
      }
    }
  }
}