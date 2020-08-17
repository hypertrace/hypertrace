rootProject.name = "hypertrace-helm"

pluginManagement {
  repositories {
    mavenLocal()
    maven((extra.properties["artifactory_contextUrl"] as String) + "/gradle") {
      credentials {
        username = extra.properties["artifactory_user"] as String
        password = extra.properties["artifactory_password"] as String
      }
    }
  }
}

plugins {
  id("org.hypertrace.version-settings") version "0.1.2"
}
