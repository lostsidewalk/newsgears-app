<link rel="stylesheet" type="text/css" href="style.css">

# Newsgears

Newsgears is a multi-user, self-hosted all-in-one RSS reader/aggregator platform. The Newsgears front-end is built using Vue3 and Vuetify, and the back-end is built using Spring Boot, ROME, and other free/open-source libraries and frameworks.  

![card_layout_dark](https://github.com/lostsidewalk/newsgears-app/assets/75078721/07ae7e2a-d161-40f3-ad65-7b870acdb442)

## Features

- Topical article queues provide a single view of multiple related feeds  
- Full-text searching using lunrjs  
- Multiple layouts (tabular, list, and card)   
- Light and dark themes 
- OPML support (import and export) 
- Fully responsive/useable on very small screens 
- Accessible and fully keyboard navigable
- Integrated media player (vue-plyr) 
- Available in English, Spanish, and French 
- Native secure image proxy 
- Focus on security, accessibility, and privacy 
- Scalable architecture can support thousands of concurrent users
- Free and self-hostable, get Newsgears up and running in seconds
- Built using free/open-source tools and libraries 

The Newsgears platform is comprised of your main components, thus this repository contains four submodules:

**[newsgears-api](https://github.com/lostsidewalk/newsgears-api)**: provides HTTP-based REST access to the core subscription management capabilities of the entire platform

**[newsgears-engine](https://github.com/lostsidewalk/newsgears-engine)**: performs scheduled/periodic tasks, such as purging old/read posts, etc.

**[newsgears-client](https://github.com/lostsidewalk/newsgears-client)**: a browser application to read and share syndicated web feed content.  

**[newsgears-broker](https://github.com/lostsidewalk/newsgears-broker)**: a platform infrastructure component built to facilitate real-time communication between client and server components.

## To self-host Newsgears:

## 1. Setup docker-compose.yml:

The easiest way to get started is to use one of the provided docker-compose files, by cloning this repository and creating a symlink, as follows: 

```
ln -s *docker-compose.single-user.yml.sample* docker-compose.yml
docker-compose up  
```

This is the simplest configuration, and will boot the minimal number of containers necessary to run the app, and without authentication.  

The `multi-user` configurations will cause the app to require authentication to login, either via OAuth2 (which must also be configured, see below), or via local user account registration.  The `debug` and `headless` configurartions are for development purposes, see below. 

Note that you must have the following ports free on localhost: 
- 5432 postgres
- 6379 redis
- 8080 API
- 8082 engine
- 8083 broker
- 3000 front-end

Once the containers are fully booted, navigating to [http://localhost:3000](http://localhost:3000) will take you directly into the app.   

#### (Optional) If you want to enable OAUTH2 via Google:

If you use a multi-user docker-compose file, you will need to provide additional values in order to get OAUTH2 working: 

- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_CLIENTID=@null```
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_CLIENTSECRET=@null```
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_REDIRECTURI=http://localhost:8080/oauth2/callback/{registrationId}```
- ```SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_GOOGLE_SCOPE=email,profile```

Get your own values for client Id/client secret from Google and plug them in to these variables in ```docker-compose.yml```. 

The value of the OAuth2 redirect URI should be:

```
http://localhost:8080/oauth2/callback/{registrationId}
```

The value of the ```scope``` property must be ```email,profile```, regardless of the OAuth2 provider.

<hr>

## 2. For local development: 

I recommend using IntelliJ IDEA w/Lombok and Gradle support for developing the back-end components, and vscode for developing the front-end. See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.  

### build_module.sh: 

A script called `build_module.sh` is provided to expedite image assembly for newsgears-api, newsgears-engine, and newsgears-broker:  

```
build_module.sh newsgears-api --debug 45005 
build_module.sh newsgears-engine --debug 55005 
build_module.sh newsgears-broker --debug 65015
```

The `--debug <port>` parameter instructs the build script to configure the image runtime environment to pause the JVM until a debugger is connected on the specified port, and to tag the image with `latest-debug` instead of `latest-local`.  

The provided `docker-compose.single-user.debug.yml.sample` file uses the `latest-debug` images, and also exposes the necessary ports to reach your local debugger.  

Thie script should be run from the top-level project directory (`newsgears-app`).  

### build_client.sh: 

The client module image is assembled with `build_client.sh`: 

```
buid_client.sh
```

The provided `headless` docker-compose files exclude the client module, so that you can run it in an IDE using `npm run devserve`. 

Thie script should be run from the top-level project directory (`newsgears-app`).  
