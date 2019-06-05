#!groovy

// Build Parameters
// properties([ parameters([
//   string( name: 'AWS_ACCESS_KEY_ID', defaultValue: ''),
//   string( name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '')
// ]), pipelineTriggers([]) ])

// Environment Variables
env.AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
env.AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')

node {

  stage('Set Terraform path') {
    steps {
        script {
            def tfHome = tool name: 'Terraform'
            env.PATH = “${tfHome}:${env.PATH}”
        }
        sh 'terraform — version'


        }   
  }
  stage ('Checkout') {
    checkout scm
  }

  stage ('Terraform Plan') {
    dir("dev") {
        sh 'terraform plan -no-color -out=create.tfplan'
    }
    
  }

//   // Optional wait for approval
//   input 'Deploy stack?'

//   stage ('Terraform Apply') {
//     sh 'terraform apply -no-color create.tfplan'
//   }

//   stage ('Post Run Tests') {
//     echo "Insert your infrastructure test of choice and/or application validation here."
//     sleep 2
//     sh 'terraform show'
//   }

//   stage ('Notification') {
//     mail from: "jenkins@mycompany.com",
//          to: "devopsteam@mycompany.com",
//          subject: "Terraform build complete",
//          body: "Jenkins job ${env.JOB_NAME} - build ${env.BUILD_NUMBER} complete"
//   }
}