Simple buildpack example. If the project is a Spring Boot project with a `pom.xml` (in the jar) then this buildpack adds Prometheus and exposes it on `/actuator/prometheus`.

Set up the default builder:

```
$ pack set-default-builder paketobuildpacks/builder:full
```

and then build with an explicit list of buildpacks:

```
$ pack build test -p demo --buildpack paketo-buildpacks/bellsoft-liberica,paketo-buildpacks/executable-jar@3.1.2,paketo-buildpacks/maven@3.2.0,paketo-buildpacks/spring-boot@3.3.0,paketo-buildpacks/procfile@2.0.3,buildpacks/io.test.java/latest
```

Or you can make a builder and use that:

```
$ pack create-builder -c builder.toml test/java
$ pack build --verbose test --path demo --builder test/java
```

Then run the container:

```
$ docker run -p 8080:8080 test

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.2.6.RELEASE)

2020-04-02 07:15:29.252  INFO 15 --- [           main] com.example.demo.DemoApplication         : Starting DemoApplication on 969fb603a4bf with PID 15 (/workspace/BOOT-INF/classes started by cnb in /workspace)
2020-04-02 07:15:29.255  INFO 15 --- [           main] com.example.demo.DemoApplication         : No active profile set, falling back to default profiles: default
2020-04-02 07:15:30.222  INFO 15 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path '/actuator'
2020-04-02 07:15:30.630  INFO 15 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
2020-04-02 07:15:30.635  INFO 15 --- [           main] com.example.demo.DemoApplication         : Started DemoApplication in 1.712 seconds (JVM running for 2.054)
```

The default process ("web") is the same as the base builder. This buildpack adds an "ext" process with the extra Promethus bits:

```
$ docker run -ti -p 8080:8080 --entrypoint ext test
Container memory limit unset. Configuring JVM for 1G container.
Calculated JVM Memory Configuration: -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=88952K -XX:ReservedCodeCacheSize=240M -Xss1M -Xmx447623K (Head Room: 0%, Loaded Class Count: 13291, Thread Count: 250, Total Memory: 1073741824)

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.2.6.RELEASE)

2020-04-02 12:10:35.728  INFO 1 --- [           main] com.example.demo.DemoApplication         : Starting DemoApplication on c37256f20660 with PID 1 (/workspace/BOOT-INF/classes started by vcap in /workspace)
2020-04-02 12:10:35.731  INFO 1 --- [           main] com.example.demo.DemoApplication         : No active profile set, falling back to default profiles: default
2020-04-02 12:10:36.865  INFO 1 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 14 endpoint(s) beneath base path '/actuator'
2020-04-02 12:10:37.208  INFO 1 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
2020-04-02 12:10:37.212  INFO 1 --- [           main] com.example.demo.DemoApplication         : Started DemoApplication in 1.811 seconds (JVM running for 2.133)
```

Test it:

```
$ curl localhost:8080/actuator/prometheus
# HELP jvm_threads_live_threads The current number of live threads including both daemon and non-daemon threads
# TYPE jvm_threads_live_threads gauge
jvm_threads_live_threads 11.0
...
```