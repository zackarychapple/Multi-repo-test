pipeline {
    tools {
      nodejs "npm"
    }
    agent none
    environment {
          def result = sh (
            script: 'git branch --show-current',
            returnStdout: true
          )
          echo ${result}
          NX_BRANCH = ${result}.replace('PR-', '')
    }
    stages {
        stage('Pipeline') {
            parallel {
                stage('Main') {
                    when {
                        branch 'main'
                    }
                    agent any
                    steps {
                        sh "npm ci"
                        sh "npx nx workspace-lint"
                        sh "npx nx format:check"
                        sh "npx nx affected --base=HEAD~1 --target=lint --parallel=3"
                        sh "npx nx affected --base=HEAD~1 --target=test --parallel=3"
                        sh "npx nx affected --base=HEAD~1 --target=build --parallel=3"
                    }
                }
                stage('PR') {
                    when {
                        not { branch 'main' }
                    }
                    agent any
                    steps {
                        sh "npm ci"
                        sh "npx nx workspace-lint"
                        sh "npx nx format:check"
                        sh "npx nx affected --base origin/${env.CHANGE_TARGET} --target=lint --parallel=3"
                        sh "npx nx affected --base origin/${env.CHANGE_TARGET} --target=test --parallel=3 --ci  --code-coverage"
                        sh "npx nx affected --base origin/${env.CHANGE_TARGET} --target=build --parallel=3"
                    }
                }
            }
        }
    }
}
