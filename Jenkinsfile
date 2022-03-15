def project = "TA_DEMO_APP"
def gitUrl = "https://github.com/tuananh2508/ta-demo-python.git"
def branch = "master"
def credentialID = "github"

def dockerImage = "ta2199/python-demo"

def tag
pipeline {
    agent any

    stages {
        stage('Pull Source Code') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "${branch}"]],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [], gitTool: 'jgitapache',  // extensions: [[$class: 'CleanBeforeCheckout']]: Clean Before Checkout
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: "${credentialID}",
                        url: "${gitUrl}"]]
                ])
            }
        }
        
        stage('Build Image') {
            steps {
                script {
                    docker.build(dockerImage)
                }
            }
        }
        
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('', '8266d0f0-bf5a-495c-bdbf-896e4f36e65c') {
                        docker.image(dockerImage).push(commitID())
                    }
                }
            }
        }
        
        stage('Deployment') {
            steps{
                script {
                    tag=commitID()
                    sh "./run.sh $tag"
                }
            }
        }
    }
}

def commitID(){
    sh 'git rev-parse HEAD > .git/CommitID'
    def commitID = readFile('.git/CommitID').trim()
    sh 'rm .git/CommitID'
    commitID
}
