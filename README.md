
## To self-host NewsGears RSS:  

## 1. Setup docker-compose.yml: 

Create a docker-compose.yml file from the same provided in this repository.

```
cp docker-compose.yml.sample docker-compose.yml 
```

#### (Optional) If you want to enable OAUTH2 via Google: 
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_CLIENTID=@null```
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_CLIENTSECRET=@null```
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_REDIRECTURI=http://localhost:8080/oauth2/callback/{registrationId}```
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_SCOPE=email,profile```

Get your own values for client Id/client secret from Google and plug them in to these variables in ```docker-compose.yml```. 

The value of the OAuth2 redirect URI should be:

```
http://localhost:8080/oauth2/callback/{registrationId}
```

This is suitable for cases where your browser can reach NewsGears via localhost, port 8080, which should be the vast majority of cases.  

The value of the ```scope``` property must be ```email,profile```, regardless of the OAuth2 provider. 

If you don't want to use OAuth2, you'll have to go through the account registration process in order to login.  

<hr>

## 2. Quick-start using pre-built containers:

If you don't want to do development, just start NewsGears using pre-built containers:

```
docker-compose up
```

<hr>

## 3. For local development: 

If you don't want to use the pre-built containers (i.e., you want to make custom code changes and build your own containers), then use the following instructions.  

### Setup command aliases: 

A script called `build_module.sh` is provided to expedite image assembly.  Setup command aliases to run it to build the required images after you make code changes: 

```
alias ng-api='./build_module.sh newsgears-api'
alias ng-engine='./build_module.sh newsgears-engine'
alias ng-broker='./build_module.sh newsgears-broker'
alias ng-client='./buid_client.sh'
```

#### Alternately, setup aliases build debuggable containers: 

```
alias ng-api='./build_module.sh newsgears-api --debug 45005'
alias ng-engine='./build_module.sh newsgears-engine --debug 55005'
alias ng-broker='./build_module.sh newsgears-broker --debug 65015'
alias ng-client='./buid_client.sh'
```

*Debuggable containers pause on startup until a remote debugger is attached on the specified port.*

### Build and run: 

#### Run the following command in the directory that contains ```newsgears-app```:  

```
ng-api && ng-engine && ng-broker && ng-client && docker-compose up
```

Boot down in the regular way, by using ```docker-compose down``` in the ```newsgears-app``` directory.

<hr> 

You can also use the `ng-api`, `ng-engine`, `ng-broker`, and `ng-client` aliases to rebuild the containers (i.e., to deploy code changes).

```
$ ng-api # rebuild the API container 
$ ng-engine # rebuild the engine container 
$ ng-broker # reubild the broker container 
$ ng-client # rebuild the client container 
```

Restart after each. 
