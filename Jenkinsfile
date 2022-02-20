pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    jenkins: worker
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command: ["/busybox/cat"]
    tty: true
    volumeMounts:
      - name: kaniko-secret
        mountPath: /kaniko/.docker/
  volumes:
    - name: kaniko-secret
      secret:
        secretName: regcred-dockerhub
        items:
          - key: .dockerconfigjson
            path: config.json
"""
    }
  }
  stages {
    stage('Stage 1: Build with Kaniko') {
      steps {
        container('kaniko') {
          sh '/kaniko/executor --context=https://github.com/marcxm/docker_rainloop.git \
                  --context `pwd`/ \
                  --destination=marcxms/rainloop:1.16.0 \
                  --cleanup \
                  --insecure \
                  --skip-tls-verify \
                  --force \
                  -v=debug && \
              echo `pwd`/ '
        }
      }
    }

  }
}
