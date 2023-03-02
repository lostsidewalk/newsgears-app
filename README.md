(0) Create a populate build-profiles:

```
mkdir build-profiles 
touch build-profiles/{api,engine,rss}-local.sh
```

(1) Setup build-profiles/api-local.sh: 

```
#!/bin/bash

isDevelopment=true
appUrl=http://localhost:8080
feedUrl=http://localhost:8081
originUrl=http://localhost:3000
datasourcePassword=postgres
sqlInitMode=always
redisPassword=redis
googleClientId=<Google client Id>
googleClientSecret=<Google client secret>
mailHost=<SMTP host>
mailUsername=<SMTP username>
mailPassword=<SMTP password>
tokenServiceSecret=<arbitrary value>
newsApiKey=<NewsApiV2 test API key>
newsApiDisabled=true
newsApiDebugSources=true
stripeSecretKey=<Stripe test secret key>
stripeWhSecretKey=<Stripe test WH secret key>
stripePriceId=<Stripe product price Id>
agentArg=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:45005
```

(2) Setup build-profiles/engine-local.sh: 

```
#!/bin/bash

isDevelopment=true
datasourcePassword=postgres
redisPassword=redis
newsApiKey=<NewsApiV2 test API key>
newsApiDisabled=true
newsApiDebugSources=true
agentArg=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:55005
```

(3) Setup build-profiles/rss-local.sh: 

```
#!/bin/bash

isDevelopment=true
datasourcePassword=postgres
redisPassword=redis
agentArg=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:65005
```

(4) Setup command aliases: 

```
alias ng-api='./build_api_module.sh $@'
alias ng-feed='./build_feed_module.sh $@'
alias ng-engine='./build_engine_module.sh $@'
alias ng='cd ${SRC}/newsgears-app && ng-api --local && ng-feed --local && ng-engine --local && docker-compose up'
```

(5) Invoke the build process: 

```
$ ng
```

(6) To re-build individual modules (container restart required after each): 

```
$ ng-api --local # rebuild the API server Docker image 
$ ng-engine --local # rebuild the engine server Docker image 
$ ng-feed --local # rebuild the feed server Docker image 
```
