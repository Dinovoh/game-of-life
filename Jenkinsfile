pipeline {
  agent {
      label 'Build_Docker_images'
  }
  
  environment {
    PROJECT_VERSION = readMavenPom().getVersion()
    //withCredentials([string(credentialsId: 'docker-hub_username', variable: 'TOKEN')])
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
//    stage('Cloning Git') {
//        steps {
//          git([url: 'https://github.com/Dinovoh/game-of-life.git', branch: 'deploy'])
//          
//        }
//    }
    
    stage('Compile') {
      steps {
        //build(quietPeriod: -2, job: '1')
        sh '''
        echo $mysecret
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
  
    stage('Pack in docker and push to docker-hub registry') {
      steps {
        sh '''
        docker build --no-cache --build-arg APP_VERSION=${PROJECT_VERSION} -t dinovoh/gameoflife:`git rev-parse --short HEAD` .
        docker push dinovoh/gameoflife:`git rev-parse --short HEAD`
        '''
      }
    }
    
    stage('Run Application') {
      steps {
        sh '''
        docker stop tomcat_game-of-life
        docker run --rm -d -p 18080:8080 --name tomcat_game-of-life dinovoh/gameoflife:`git rev-parse --short HEAD`
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
