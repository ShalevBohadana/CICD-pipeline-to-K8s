pipeline {
  agent any

  environment {
    // These credentials must be created in Jenkins credentials store
    AWS_ACCOUNT_ID       = credentials('aws-account-id')
    AWS_ROLE_ARN         = credentials('terraform-exec-role')
    AWS_REGION           = 'us-west-2'
    ECR_REPO             = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/sample-app"
    TF_VAR_bootstrap_arn = "${AWS_ROLE_ARN}"       // passed automatically to Terraform
    KUBE_NAMESPACE       = 'production'
  }

  options { 
    ansiColor('xterm'); timestamps()
  }

  stages {
    stage('Checkout & Test') {
      steps {
        // 1. Get code and run unit tests
        checkout scm
        dir('app') {
          sh 'npm ci'
          sh 'npm test' 
        }
      }
    }

    stage('Build & Push Docker') {
      steps {
        dir('app') {
          script {
            docker.withRegistry("https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com", 'ecr:aws-credentials') {
              docker.build("${ECR_REPO}:latest").push()
            }
          }
        }
      }
    }

    stage('Terraform Init & Plan') {
      steps {
        dir('infra') {
          // 2. Assume the bootstrap role and init Terraform
          withAWS(role: AWS_ROLE_ARN, region: AWS_REGION) {
            sh 'terraform init -backend-config=backend.hcl'
            sh 'terraform plan -out=tfplan'
          }
        }
      }
    }

    stage('Terraform Apply (Infra + ALB)') {
      steps {
        dir('infra') {
          withAWS(role: AWS_ROLE_ARN, region: AWS_REGION) {
            // Applies VPC, EKS, ECR, Jenkins EC2, and the ALB + IAM auth in front of Jenkins
            sh 'terraform apply -auto-approve tfplan'
          }
        }
      }
    }

    stage('Configure kubectl') {
      steps {
        // 3. Point kubectl at the new EKS cluster
        withAWS(role: AWS_ROLE_ARN, region: AWS_REGION) {
          sh '''
            aws eks update-kubeconfig \
              --region ${AWS_REGION} \
              --name $(terraform -chdir=infra output -raw cluster_name)
          '''
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        dir('k8s') {
          // 4. Apply your Kubernetes manifests
          sh 'kubectl apply -n ${KUBE_NAMESPACE} -f deployment.yaml'
          sh 'kubectl apply -n ${KUBE_NAMESPACE} -f service.yaml'
        }
      }
    }
  }

  post {
    always { cleanWs() }
    success { echo '✅ Pipeline succeeded!' }
    unstable { echo '⚠️ Pipeline unstable (test failures or warnings).' }
    failure { echo '❌ Pipeline failed!' }
  }
}
