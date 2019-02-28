pipeline {
  agent any
  
  tools {
    jdk 'jdk8'
    maven 'maven3'
  }
  
  stages {
    
    stage('Compile') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml compile'
      }
    }  
    
    stage('Unit test') {
      steps {
        sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml test'
      }
    }
    
//    stage('Test coverage with cobertura') {
//      steps {
//        sh "mvn -U test cobertura:cobertura -Dcobertura.report.format=xml"
//      }
//    }

//    stage('Test coverage with jacoco') {
//      steps {
//       jacoco()
//      }
//    }          
      
    stage('Static analysis with SonarQube') {
      steps {
        sh "mvn sonar:sonar -Dsonar.host.url=${env.SONARQUBE_HOST}"
      }
    }  
   
    stage('Build') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml install -Dmaven.test.skip=true'
      }
      
      post {
        always {
          junit '**/target/*-reports/TEST-*.xml'
//        step([$class: 'CoberturaPublisher', coberturaReportFile: '**/coverage.xml'])
//        step([ $class: 'JacocoPublisher' ] )
        }
      }
    }
  }
}
