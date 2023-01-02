pipeline {
  agent  any
  environment {
    accountid = "your-account-id"
    iamRole = "ec2-iam-role"
    module = "tf-files-folder-path"
    }
    stages {

      stage ('Checkout SCM'){
        steps {
          git 'https://github.com/rsivaseshu/terraform.git'
        }
      }

     
      stage('Set Terraform path') {
       steps {
         script {
            def tfHome = tool name: 'terraform'
            env.PATH = "${tfHome}:${env.PATH}"
         }
     }
  }
  stage('terraform init') {
 
       steps {
           dir (module) {
                script {
                    withAWS(roleAccount:accountid, role:iamRole, useNode: true) {
                    sh 'terraform init -no-color'
                    }
             }
           }
        }
      }

  stage('terraform Plan') {
 
       steps {
           dir (module) {
            
               script {
                    withAWS(roleAccount:accountid, role:iamRole, useNode: true) {
                    sh 'terraform plan -no-color -out=plan.out'
                    }
               }
            }
        }
      }

  stage('Waiting for Approvals') {
            
      steps{
          input('Plan Validated? Please approve to create VPC Network in AWS?')
			  }
      }    

  stage('terraform Apply') {
 
       steps {
           dir (module) {
            
              script {
                    withAWS(roleAccount:accountid, role:iamRole, useNode: true) {
                    sh 'terraform apply -no-color -auto-approve plan.out'
                    sh "terraform output"
                    }
              }
            
           }
        }
      }
   }
}