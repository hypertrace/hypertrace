plugins {
  java
  application
}

dependencies {
  implementation("com.squareup.okhttp3:okhttp:4.8.0")
  implementation("com.fasterxml.jackson.core:jackson-databind:2.11.1")
  implementation("org.junit.jupiter:junit-jupiter:5.6.2")
  runtimeOnly("org.junit.platform:junit-platform-console-standalone:1.6.2")
}

application {
  mainClass.set("org.hypertrace.core.serviceframework.PlatformServiceLauncher")
}

tasks.register<Copy>("copyDependencies") {
  from(configurations.runtimeClasspath)
  from(tasks.jar)
  into("$projectDir/build/dependencies")
}

tasks.withType<Test>().configureEach {
  useJUnitPlatform()
}

tasks.run<JavaExec> {
  jvmArgs = listOf("-Dservice.name=${project.name}")
}

// Point test source set at main so IDE recognizes
sourceSets.test {
  allSource.source(sourceSets.main.get().allSource)
}

hypertraceDocker {
  defaultImage {
    dependsOn("copyDependencies")
    javaApplication {
      port.set(23431)
    }
  }
}