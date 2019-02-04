pipeline {
  agent any
  
  tools {
    jdk 'jdk8'
    maven 'maven3'
  }
  
  stages {
    
    stage('Unit test with cobertura') {
      
      steps {
        sh "mvn -U clean test cobertura:cobertura -Dcobertura.report.format=xml"
      }
    }
    stage('Build') {
      
      steps {
        //build(quietPeriod: -2, job: '1')
        sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml install'
      }
      
      post {
        always {
          junit '**/target/*-reports/TEST-*.xml'
          step([$class: 'CoberturaPublisher', coberturaReportFile: 'target/site/cobertura/coverage.xml'])
        }
      }
    }
  }  
}
