node ('master') {
    def rtServer = Artifactory.newServer url: SERVER_URL, credentialsId: CREDENTIALS
    def buildInfo = Artifactory.newBuildInfo()
    buildInfo.env.capture = true

    stage ('Dependencies') {
       println "Getting ready to build"
       println env.JOB_NAME
       println env.BUILD_NUMBER

    }

    stage ('Build & Deploy') {
      println "Getting ready to build & Deploy"
    }

    stage ('Test') {
      println "Getting ready to build"
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
         sleep 10
    }

    stage ('Promotion') {
        dir('bills-iot-python-dist/dist/') {
            def promotionConfig = [
              'buildName'          : env.JOB_NAME,
              'buildNumber'        : env.BUILD_NUMBER,
              'targetRepo'         : PROMOTE_REPO,
              'comment'            : 'Python iOT goodness',
              'sourceRepo'         : REPO,
              'status'             : 'Released',
              'includeDependencies': false,
              'copy'               : true
            ]
            rtServer.promote promotionConfig
            reTagLatest (REPO)
            reTagLatest (PROMOTE_REPO)
          }

     }

}
