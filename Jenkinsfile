pipeline {
    agent any
    environment {
        module = "sept2022/finance/"
    }

    parameters {
        choice choices: ['apply', 'destroy'], name: 'REQUESTED_ACTION'
    }

    tools {
        terraform 'terraform'
    }

    stages {
        stage('scm'){
            steps {
                git 'https://github.com/rsivaseshu/terraform.git'
            }
        }

        stage('terraform init') {
            steps {
                dir(module) {
                    sh 'terraform init -no-color'
                }
            }
        }
        stage('terraform validate') {
            steps {
                dir(module) {
                    sh 'terraform validate '
                }
            }
        }
        stage('terraform plan') {
            steps {
                dir(module) {
                    sh 'terraform plan -no-color -out=plan.out'
                }
            }
        }
		stage('Waiting for Approvals') {
    	    steps{
      	        input('Plan Validated? Please approve to create VPC Network in AWS?')
			}
        } 
        stage('terraform apply') {
            when {
                expression { params.REQUESTED_ACTION == 'apply' }
            }
            steps {
                dir(module) {
                    sh 'terraform apply -no-color -auto-approve plan.out'
                    sh "terraform output"
                }
            }
        }
        stage('terraform destroy') {
            when {
                expression { params.REQUESTED_ACTION == 'destroy' }
            }
            steps {
                dir(module) {
                    sh 'terraform destroy -no-color -auto-approve '
                    sh "terraform output"
                }
            }
        }
    }

}