
#!/usr/bin/env groovy

node ('master') {
    git url: 'https://github.com/williammanning/jfrog_demo_iot'
    def rtServer = Artifactory.newServer url: SERVER_URL, credentialsId: CREDENTIALS
    def buildInfo = Artifactory.newBuildInfo()

    stage ('Dependencies') {
       println "Connecting to github"
    }


  }
