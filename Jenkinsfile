pipeline {
    agent any
    stages {
        stage('Cloning SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/priyank-139/aws_vault_infra_vault.git'
            }
        }
        stage('Terraform initialising code') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform formating code') {
            steps {
                sh 'terraform fmt'
            }
        }
        stage('Terraform Validating the code') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Plan') {
            when { 
                expression { env.CHOICE == 'plan' }
            }
            steps {
                sh 'terraform plan'
            }
        }
        stage ("Terraform Apply"){
            when { 
                expression { env.CHOICE == 'apply' }
            }
            steps{
                sh 'terraform apply -auto-approve'
            }
        }
        stage ("Terraform Destroy"){
            when { 
                expression { env.CHOICE == 'destroy' }
            }
            steps{
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
