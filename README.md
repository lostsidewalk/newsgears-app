
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
alias ng-api='./build_module.sh api'
alias ng-engine='./build_module.sh engine'
alias ng-broker='./build_module.sh broker'
alias ng-client='./buid_client.sh'
```

#### Alternately, setup aliases build debuggable containers: 

```
alias ng-api='./build_module.sh api --debug 45005'
alias ng-engine='./build_module.sh engine --debug 55005'
alias ng-broker='./build_module.sh broker --debug 65015'
alias ng-client='./buid_client.sh'
```

*Debuggable containers pause on startup until a remote debugger is attached on the specified port.*

### Build an run: 

#### Run the following command in the directory that contains ```newsgears-app```:  

```
alias ng="cd `pwd`/newsgears-app && ng-api && ng-engine && ng-broker && ng-client && docker-compose up"
```

Now, you can use the `ng` alias to rebuild and start the entire platform.    

```
 $ ng 
 Current dir: newsgears-app
 Building module: api, isDevelopment: false

 > Task :compileJava
 Note: /home/me/src/coldchillinsw/newsgears-app/newsgears-api/src/main/java/com/lostsidewalk/buffy/app/utils/CookieUtils.java uses or overrides a deprecated API.
 Note: Recompile with -Xlint:deprecation for details.

 > Task :test
 OpenJDK 64-Bit Server VM warning: Sharing is only supported for boot loader classes because bootstrap classpath has been appended

 BUILD SUCCESSFUL in 9s
 6 actionable tasks: 6 executed

 Current dir: newsgears-app
 Building module: engine, isDevelopment: false

 BUILD SUCCESSFUL in 1s
 4 actionable tasks: 4 executed

 Current dir: newsgears-app
 Building module: broker, isDevelopment: false

 > Task :compileJava
 Execution optimizations have been disabled for task ':compileJava' to ensure correctness due to the following reasons:
  - Additional action of task ':compileJava' was implemented by the Java lambda 'org.springframework.boot.gradle.plugin.JavaPluginAction$$Lambda$724/0x00007f418b5cdd58'. Reason: Using Java lambdas is not supported as task inputs. Please refer to https://docs.gradle.org/7.4/userguide/validation_problems.html#implementation_unknown for more details about this problem.
 Note: /home/me/src/coldchillinsw/newsgears-app/newsgears-broker/src/main/java/com/lostsidewalk/buffy/broker/security/SocketSecurityConfig.java uses or overrides a deprecated API.
 Note: Recompile with -Xlint:deprecation for details.

 Deprecated Gradle features were used in this build, making it incompatible with Gradle 8.0.

 You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.

 See https://docs.gradle.org/7.4/userguide/command_line_interface.html#sec:command_line_warnings

 Execution optimizations have been disabled for 1 invalid unit(s) of work during this build to ensure correctness.
 Please consult deprecation warnings for more details.

 BUILD SUCCESSFUL in 2s
 4 actionable tasks: 4 executed
                                         0.0s
 Starting newsgears-app_feedgears-cache01_1 ... done
 Starting newsgears-app_feedgears-db01_1    ... done
 Recreating newsgears-app_feedgears-broker01_1 ... done
 Recreating newsgears-app_feedgears-engine01_1 ... done
 Recreating newsgears-app_feedgears-app01_1    ... done
 Attaching to newsgears-app_feedgears-cache01_1, newsgears-app_feedgears-db01_1, newsgears-app_feedgears-broker01_1, newsgears-app_feedgears-engine01_1, newsgears-app_feedgears-app01_1
 feedgears-broker01_1  | Listening for transport dt_socket at address: 65015
 feedgears-db01_1      | 
 feedgears-db01_1      | PostgreSQL Database directory appears to contain a database; Skipping initialization
 feedgears-db01_1      | 
 feedgears-cache01_1   | 1:C 29 Sep 2023 18:56:51.428 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
 feedgears-cache01_1   | 1:C 29 Sep 2023 18:56:51.428 # Redis version=6.2.13, bits=64, commit=00000000, modified=0, pid=1, just started
 feedgears-cache01_1   | 1:C 29 Sep 2023 18:56:51.428 # Configuration loaded
 feedgears-cache01_1   | 1:M 29 Sep 2023 18:56:51.429 # Server initialized
 feedgears-cache01_1   | 1:M 29 Sep 2023 18:56:51.429 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
 feedgears-db01_1      | 2023-09-29 18:56:51.568 UTC [1] LOG:  starting PostgreSQL 15.4 (Debian 15.4-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
 feedgears-cache01_1   | 1:M 29 Sep 2023 18:56:52.422 # Done loading RDB, keys loaded: 4, keys expired: 0.
 feedgears-engine01_1  | Listening for transport dt_socket at address: 55005
 feedgears-db01_1      | 2023-09-29 18:56:51.568 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
 feedgears-db01_1      | 2023-09-29 18:56:51.568 UTC [1] LOG:  listening on IPv6 address "::", port 5432
 feedgears-db01_1      | 2023-09-29 18:56:51.579 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
 feedgears-db01_1      | 2023-09-29 18:56:51.585 UTC [29] LOG:  database system was shut down at 2023-09-29 17:45:04 UTC
 feedgears-db01_1      | 2023-09-29 18:56:51.592 UTC [1] LOG:  database system is ready to accept connections
 feedgears-app01_1     | Listening for transport dt_socket at address: 45005
 ...
```

Boot down in the regular way, by using ```docker-compose down``` in the ```newsgears-app``` directory.

```
Stopping newsgears-app_feedgears-app01_1    ... done
Stopping newsgears-app_feedgears-engine01_1 ... done
Stopping newsgears-app_feedgears-broker01_1 ... done
Stopping newsgears-app_feedgears-db01_1     ... done
Stopping newsgears-app_feedgears-cache01_1  ... done
Removing newsgears-app_feedgears-app01_1    ... done
Removing newsgears-app_feedgears-engine01_1 ... done
Removing newsgears-app_feedgears-broker01_1 ... done
Removing newsgears-app_feedgears-db01_1     ... done
Removing newsgears-app_feedgears-cache01_1  ... done
Removing network newsgears-app_default
```

<hr> 

You can also use the `ng-api`, `ng-engine`, and `ng-broker` aliases to rebuild the containers (i.e., to deploy code changes).

```
$ ng-api # rebuild the API container 
$ ng-engine # rebuild the engine container 
$ ng-broker # reubild the broker container 
$ ng-client # rebuild the client container 
```

Restart after each. 