# alpine-ssh-client
### Imitate from [`kroniak`](https://github.com/kroniak/alpine-ssh-client/tree/master) because need to use in Raspberry pi which required `arm64` architecture.
### Need to imitate because don't know how to contribute.

A little docker image based on alpine with ssh-client and bash<br>

## using from GitLab CI

```yml
deploy_staging:
  stage: deploy
  image: atthana/ssh-client-arm-v8:3.18
  environment:
    name: staging
    url: https://sample-app.net
  script:
    - mkdir -p ~/.ssh
    - chmod 700 ~/.ssh
    - echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
    - echo "$SSH_PRIVATE_KEY_STAGING" > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - scp -r deploy/app_staging/. $DEPLOY_STAGING_SSH_HOST:~/app
    - scp -r src/project/conf/. $DEPLOY_STAGING_SSH_HOST:~/app/conf
    - ssh $DEPLOY_STAGING_SSH_HOST 'chmod 700 ~/app/app.sh'
    - ssh $DEPLOY_STAGING_SSH_HOST 'cd ~/app && ./app.sh --file docker-compose-staging.yml up'
    - ssh $DEPLOY_STAGING_SSH_HOST 'cd ~/app && ./app.sh --file docker-compose-staging.yml update'
  only:
    - dev
```

## using from docker

`docker run -it --rm atthana/ssh-client-arm-v8 bash`

## supported tags and respective Dockerfile links

- 3.18, latest [3.18/Dockerfile](3.18/Dockerfile)
