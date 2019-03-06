pipeline {
  agent {
      label 'Build_Docker_images'
  }
  
  environment {
    PROJECT_VERSION = readMavenPom().getVersion()
  }
//  tools {
//    jdk 'jdk8'
//    maven 'maven3'
//  }
  
  stages {
    //stage('Preinstall required tools') { 
    //  steps {
    //      sh 'mvn -B -f /var/jenkins_home/jobs/game-of-life/workspace/pom.xml test'
    //    }
    //  tools {
    //    jdk 'jdk8'
    //    maven 'maven3'
    //  }
    //}
    
    //Uses Poll SCM schedule without a regard for changes. Starts build even if there are no changes        
    stage('Cloning Git') {
        steps {
          git([url: 'https://github.com/Dinovoh/game-of-life.git', branch: 'deploy'])
          
        }
    }
    
    stage('Compile') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh '''
        echo "${PROJECT_VERSION}"
        mvn -B -f $WORKSPACE/pom.xml compile
        '''
      }
    }  
    
    stage('Unit test') {
      steps {
        sh 'mvn -B -f $WORKSPACE/pom.xml test'
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
        sh '''
        mvn -B -f $WORKSPACE/pom.xml sonar:sonar -Dsonar.host.url=http://172.18.0.3:9000
        '''
      }
    }  
   
    stage('Build WAR') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh '''
        mvn -B -f $WORKSPACE/pom.xml install -Dmaven.test.skip=true
        cp /home/jenkins/.m2/repository/com/wakaleo/gameoflife/gameoflife-web/${PROJECT_VERSION}/gameoflife-web-${PROJECT_VERSION}.war .
        '''
      }
    }  
  
    stage('Pack in docker') {
      steps {
        sh '''
        docker build --build-arg APP_VERSION=${PROJECT_VERSION} -t gameoflife:`git rev-parse --short HEAD` .
        '''
      }
    }
    
    stage('Push to docker-hub registry') {
      steps {
        sh '''
        echo "Test"
        '''
      }
    }    
      
  }
  
  post {
    always {
      junit '**/target/*-reports/TEST-*.xml'
//    step([$class: 'CoberturaPublisher', coberturaReportFile: '**/coverage.xml'])
//    step([ $class: 'JacocoPublisher' ] )
    }
  }
}
