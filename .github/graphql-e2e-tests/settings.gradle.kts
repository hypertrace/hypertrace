rootProject.name = "graphql-e2e-tests"

pluginManagement {
    repositories {
        mavenLocal()
        gradlePluginPortal()
        maven("https://hypertrace.jfrog.io/artifactory/maven")
    }
}

plugins {
    id("org.hypertrace.version-settings") version "0.2.0"
}
