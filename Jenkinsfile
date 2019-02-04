pipeline {
  agent any
  
  tools {
    jdk 'jdk8'
    maven 'maven3'
  }
  
  stages {
    
    stage('cobertura') {
      steps {
        sh "mvn -U clean test cobertura:cobertura -Dcobertura.report.format=xml"
      }
    }
    
//    stage('Sonar') {
//      steps {
//        sh "mvn sonar:sonar -Dsonar.host.url=${env.SONARQUBE_HOST}"
//      }
//    }  
    
//    stage('jacoco') {
//      steps {
//       jacoco()
//      }
//    }    
    
    stage('Build') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml install'
      }
      
      post {
        always {
          junit '**/target/*-reports/TEST-*.xml'
          step([$class: 'CoberturaPublisher', coberturaReportFile: '**/coverage.xml'])
          step([ $class: 'JacocoPublisher' ] )
        }
      }
    }
  }
}
