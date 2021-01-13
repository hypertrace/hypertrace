FROM openjdk:11-jre-slim
RUN mkdir -p /traceable
WORKDIR /traceable
COPY build/dependencies/ .
CMD java -cp './*' org.junit.platform.console.ConsoleLauncher --select-package=ai.traceable