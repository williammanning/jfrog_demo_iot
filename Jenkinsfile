node ('master') {
    def rtServer = Artifactory.newServer url: SERVER_URL, credentialsId: CREDENTIALS
    def buildInfo = Artifactory.newBuildInfo()

    stage ('Dependencies') {
       println "Getting ready to build"
    }

    stage ('build & deploy') {

    }

    stage ('test') {

    }

    stage('Xray Scan') {
         if (XRAY_SCAN == "YES") {
             def xrayConfig = [
                'buildName'     : env.JOB_NAME,
                'buildNumber'   : env.BUILD_NUMBER,
                'failBuild'     : false
              ]
              def xrayResults = rtServer.xrayScan xrayConfig
              echo xrayResults as String
         } else {
              println "No Xray scan performed. To enable set XRAY_SCAN = YES"
         }
         sleep 60
    }

    stage ('promotion') {
        dir('automation/bills-iot-python-virt/app-test') {
            def promotionConfig = [
              'buildName'          : env.JOB_NAME,
              'buildNumber'        : env.BUILD_NUMBER,
              'targetRepo'         : PROMOTE_REPO,
              'comment'            : 'Python iOT goodness',
              'sourceRepo'         : SOURCE_REPO,
              'status'             : 'Released',
              'includeDependencies': false,
              'copy'               : true
            ]
            rtServer.promote promotionConfig
            reTagLatest (SOURCE_REPO)
            reTagLatest (PROMOTE_REPO)
        }

        // promote war file from gradle-release to gradle-prod

     }
}


  }
