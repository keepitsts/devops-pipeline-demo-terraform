###Jenkinsfile###

import groovy.json.JsonOutput

//git env vars

env.git_url = 'https://user@bitbucket.org/user/terraform-ci.git'

env.git_branch = 'master'

//jenkins env vars

env.jenkins_server_url = 'http://ec2-23-20-93-199.compute-1.amazonaws.com:8080'

env.jenkins_node_custom_workspace_path = "/opt/bitnami/apps/jenkins/jenkins_home/${JOB_NAME}/workspace"

env.jenkins_node_label = 'master'

env.terraform_version = '0.12.1'

pipeline {

agent {

node {

customWorkspace "$jenkins_node_custom_workspace_path"

label "$jenkins_node_label"

} 

}

stages {

stage('fetch_latest_code') {

steps {

git branch: "$git_branch" ,

url: "$git_url"

}

}

stage('install_deps') {

steps {

sh "sudo apt install wget zip python-pip -y"

sh "cd /tmp"

sh "curl -o terraform.zip https://releases.hashicorp.com/terraform/'$terraform_version'/terraform_'$terraform_version'_linux_amd64.zip"

sh "unzip terraform.zip"

sh "sudo mv terraform /usr/bin"

sh "rm -rf terraform.zip"

}

}

stage('init_and_plan') {

steps {

sh "sudo terraform init $jenkins_node_custom_workspace_path/workspace"

sh "sudo terraform plan $jenkins_node_custom_workspace_path/workspace"

}

}

stage('approve') {

steps {

input 'Do you approve deployment?'

}

}

stage('apply_changes') {

steps {

sh "echo 'yes' | sudo terraform apply $jenkins_node_custom_workspace_path/workspace"

}

}

}

post { 

  always { 

    cleanWs()

   }

  }
