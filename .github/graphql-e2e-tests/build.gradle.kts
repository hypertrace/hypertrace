plugins {
  java
  application
  id("org.hypertrace.repository-plugin") version "0.4.0"
}

repositories {
  mavenCentral()
}

dependencies {
  implementation("com.squareup.okhttp3:okhttp:4.8.0")
  implementation("com.fasterxml.jackson.core:jackson-databind:2.11.1")
  implementation("org.junit.jupiter:junit-jupiter:5.6.2")
  runtimeOnly("org.junit.platform:junit-platform-console-standalone:1.6.2")
}

application {
  mainClass.set("org.junit.platform.console.ConsoleLauncher")
}

tasks.withType<Test>().configureEach {
  useJUnitPlatform()
}

tasks.run<JavaExec> {
  args = listOf("--select-package=org.hypertrace")
}

// Point test source set at main so IDE recognizes
sourceSets.test {
  allSource.source(sourceSets.main.get().allSource)
}