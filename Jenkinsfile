pipeline {
    tools {
      nodejs "npm"
    }
    agent none
    stages {
        stage('Pipeline') {
            parallel {
                stage('Main') {
//                     when {
//                         branch 'origin/main'
//                     }
                    agent any
                    steps {
                        sh "npm ci"
                        sh "npx nx workspace-lint"
//                         sh "npx nx format:check --base=HEAD~1" //This does not work because of origin/main vs main
                        sh "npx nx affected --base=HEAD~1 --target=lint --parallel=3"
                        sh "npx nx affected --base=HEAD~1 --target=test --parallel=3"
                        sh "npx nx affected --base=HEAD~1 --target=build --parallel=3"
                    }
                }
//                 stage('PR') {
//                     when {
//                         not { branch 'origin/main' }
//                     }
//                     agent any
//                     steps {
//                         echo GIT_BRANCH
//                         sh "npm ci"
//                         sh "npx nx workspace-lint"
//                         sh "npx nx format:check"
//                         sh "npx nx affected --base origin/${env.CHANGE_TARGET} --target=lint --parallel=3"
//                         sh "npx nx affected --base origin/${env.CHANGE_TARGET} --target=test --parallel=3 --ci  --code-coverage"
//                         sh "npx nx affected --base origin/${env.CHANGE_TARGET} --target=build --parallel=3"
//                     }
//                 }
            }
        }
    }
}
