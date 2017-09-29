node ('master') {
    def rtServer = Artifactory.newServer url: SERVER_URL, credentialsId: CREDENTIALS
    def buildInfo = Artifactory.newBuildInfo()
    def tagName
    buildInfo.env.capture = true

    stage ('Dependencies') {
       println "Getting ready to build"
       println env.JOB_NAME
       println env.BUILD_NUMBER

    }

    stage ('Build & Deploy') {
      println "Getting ready to build & Deploy"
    }

    stage ('Publish & Scan') {
      println "Getting ready to Publish & Scan"
      rtServer.publishBuildInfo buildInfo
      if (XRAY_SCAN == "YES") {
             def scanConfig = [
                'buildName'      : buildInfo.name,
                'buildNumber'    : buildInfo.number,
                'failBuild'      : false
            ]
            def scanResult = server.xrayScan scanConfig
            echo scanResult as String
        }
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
