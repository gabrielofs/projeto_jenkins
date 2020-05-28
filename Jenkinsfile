pipeline{
  agent none
  stages{
    stage('Compile'){
      agent any
      steps{
        sh 'echo Install Dependencies'
      }       
    }
    stage('Code Quality'){
      agent any
      steps{
        sh 'echo Sonarqube Code Quality Check Done'
      }
    }
    stage('Test'){
      agent any
      steps{
        sh 'echo Test Python'
      }
    } 
    stage('Package'){
      agent any
      steps{
        sh 'echo Package Artifactory'
      }
    }
    stage('Upload File To Artifactory'){
      agent any
      steps{
        sh 'echo Uploaded file to Artifactory'
      }
    }
     stage('Build'){
      agent any
      steps{
        sh label: '', script: '''
        sudo docker build -t webimage:$BUILD_NUMBER .'''
      }
    }
    stage('Deploy'){
      agent any
      steps{
        sh label: '', script: '''
        sudo docker container run -d --name webserver$BUILD_NUMBER -p 5000:5000 webimage:$BUILD_NUMBER'''
      }
    }
    stage( 'Deploy to Heroku' ) {
      agent any
        steps {
          script {
            withCredentials([[$class: 'UsernamePasswordMultiBinding' ,
                credentialsId: 'heroku',
                  usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                    sh "docker login -u $USERNAME -p $PASSWORD registry.heroku.com"
                    sh "echo 'machine api.heroku.com login $USERNAME password $PASSWORD' > ~/.netrc"
                    sh "chmod 600 ~/.netrc"
                  }
                  // Tag docker img (in my case it was an image in dockerhub)
            sh "docker tag webimage:$BUILD_NUMBER registry.heroku.com/jenkins-pipeline-example/web"
            sh "docker push registry.heroku.com/jenkins-pipeline-example/web"
            sh "/usr/bin/heroku container:release web --app=jenkins-pipeline-example"
            sh "docker logout registry.heroku.com"
            }  
          }
      }   
  }
}
