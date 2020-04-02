Simple buildpack (currently a no-op).

```
$ pack build test -p demo --buildpack org.cloudfoundry.openjdk,org.cloudfoundry.buildsystem,org.cloudfoundry.jvmapplication,org.cloudfoundry.springboot,buildpacks/io.test.java/latest
```

or make a builder and use that:

```
$ pack create-builder -b builder.toml test/java
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