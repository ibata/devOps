//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label 'master' }

    stages {

        stage('Unit Testing Inspec') {
           agent { label 'master' }
           steps {
                 sh '''
                    #chef exec bundle exec ruby -W -Itest test/integration/ktf_suite/controls/reach_host.rb
                    inspec check https://github.com/ibata/inspectests
                 '''

           }
           post {
             success {

               emailext (
                   subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                   body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                     <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
                   recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                 )
             }

             failure {
               emailext (
                   subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                   body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                     <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
                   recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                 )
             }
           }

        }
        stage('Integration Testing') {
            agent { label 'master' }
            steps {
                wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {

                    sh '''
                        #kitchen test
                        kitchen create
                        kitchen converge
                        kitchen verify
                        kitchen destroy
                        cat .kitchen/logs/ktf-suite-terraform.log
                        kitchen diagnose --all
                    '''
                }
            }
            //To collect our test results and artifacts, we will use the post section.
            //https://jenkins.io/doc/pipeline/tour/tests-and-artifacts/
            post {
             // always {
              //  junit 'serverspec*.xml'
            //    junit '*inspec.xml'
             // }
              success {

                emailext (
                    subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                    body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                      <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                  )
              }

              failure {
                emailext (
                    subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                    body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                      <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                  )
              }
            }
        }

    }
}
