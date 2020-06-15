pipeline {
   agent {
       docker {
           image 'papitoio/robotwd'
           args '--network=skynet'
       }
   }

   stages {
      stage('Build') {
         steps {
            echo 'Baixando as depedências do projeto'
            sh 'pip install -r requirements.txt'
         }
      }
      stage('Test') {
         steps {
            echo 'Executando testes de regressão'
            sh 'robot -d ./logs -v browser:headless tests/'
         }
         post {
            always {
               robot otherFiles: '**/*.png', outputPath: 'logs'
            }
         }
      }
      stage('UAT') {
         steps {
            echo 'Aprovação dos testes de aceitação' 
            input(message: 'Podemos ir para produção?', ok: 'Proseguir')
         } 
      }
      stage('Production') {
         steps {
            echo 'WebApp Ok em produção!'
         } 
      }
   }
}
