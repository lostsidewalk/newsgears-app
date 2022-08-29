
(1) Install secret.properties in newsgears-api/src/main/resources, then build: 

```
cd newsgears-api && gradlew build
docker build --build-arg JAR_FILE=build/libs/*.jar -t lostsidewalk/newsgears-api .
```

(2) Install secret.properties in newsgears-rss/src/main/resources, then build: 

```
cd newsgears-rss && gradlew build
docker build --build-arg JAR_FILE=build/libs/*.jar -t lostsidewalk/newsgears-rss .
```

(3) Start the app: 

```
docker-compose up
```


