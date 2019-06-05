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

        // stage('TerraformFormat'){
        //     steps {
        //         dir('./dev'){
        //             sh "terraform fmt -list=true -write=false -diff=true -check=true"
        //         }
        //     }
        // }

        stage('TerraformValidate'){
            steps {
                dir('./dev'){
                    sh "terraform validate"
                }
            }
        }

        // stage('TerraformPlan'){
        //     steps {
        //         dir('./dev'){
        //             script {
        //                 try {
        //                     sh "terraform workspace new ${params.WORKSPACE}"
        //                 } catch (err) {
        //                     sh "terraform workspace select ${params.WORKSPACE}"
        //                 }
        //                 sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' \
        //                 -out terraform.tfplan;echo \$? > status"
        //                 stash name: "terraform-plan", includes: "terraform.tfplan"
        //             }
        //         }
        //     }
        // }
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('./dev'){
                            // unstash "terraform-plan"
                            sh 'terraform apply --auto-approve'//terraform.tfplan'
                        }
                    }
                }
            }
        }
    }
}
