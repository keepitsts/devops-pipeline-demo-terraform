pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.11.10"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('terraform-0.11.10')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('jenkins-aws-secret-key-id')
        SECRET_KEY = credentials('jenkins-aws-secret-access-key')
    }
    stages {
            stage('TerraformInit'){
            steps {
                dir('./dev'){
                    sh "terraform init -input=false"
                    sh "echo \$PWD"
                    sh "whoami"
                }
            }
        }

        stage('TerraformFormat'){
            steps {
                dir('./dev'){
                    sh "terraform fmt -list=true -write=false -diff=true -check=true"
                }
            }
        }

        stage('TerraformValidate'){
            steps {
                dir('./dev'){
                    sh "terraform validate"
                }
            }
        }

        stage('TerraformPlan'){
            steps {
                dir('./dev'){
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                        sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' \
                        -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
                }
            }
        }
        // stage('TerraformApply'){
        //     steps {
        //         script{
        //             def apply = false
        //             try {
        //                 input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
        //                 apply = true
        //             } catch (err) {
        //                 apply = false
        //                  currentBuild.result = 'UNSTABLE'
        //             }
        //             if(apply){
        //                 dir('/dev'){
        //                     unstash "terraform-plan"
        //                     // sh 'terraform apply terraform.tfplan'
        //                 }
        //             }
        //         }
        //     }
        // }
    }
}
// #!groovy

// // Build Parameters
// // properties([ parameters([
// //   string( name: 'AWS_ACCESS_KEY_ID', defaultValue: ''),
// //   string( name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '')
// // ]), pipelineTriggers([]) ])

// // Environment Variables
// env.AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
// env.AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')

// node {

//   // stage('Set Terraform path') {
//   //   steps {
//   //       script {
//   //           def tfHome = tool name: 'Terraform'
//   //           env.PATH = “${tfHome}:${env.PATH}”
//   //       }
//   //       sh 'terraform — version'


//   //       }   
//   // }
//   stage ('Checkout') {
//     checkout scm
//   }

//   stage ('Terraform Plan') {
//     dir("dev") {
//         sh '/usr/local/bin/terraform init -input=false'
//         sh '/usr/local/bin/terraform plan -no-color -out=create.tfplan'
//     }
    
//   }

// //   // Optional wait for approval
// //   input 'Deploy stack?'

// //   stage ('Terraform Apply') {
// //     sh 'terraform apply -no-color create.tfplan'
// //   }

// //   stage ('Post Run Tests') {
// //     echo "Insert your infrastructure test of choice and/or application validation here."
// //     sleep 2
// //     sh 'terraform show'
// //   }

// //   stage ('Notification') {
// //     mail from: "jenkins@mycompany.com",
// //          to: "devopsteam@mycompany.com",
// //          subject: "Terraform build complete",
// //          body: "Jenkins job ${env.JOB_NAME} - build ${env.BUILD_NUMBER} complete"
// //   }
// }