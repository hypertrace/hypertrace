package org.hypertrace.e2etest;

import static java.lang.System.lineSeparator;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.time.Instant;
import java.util.stream.Collectors;
import okhttp3.Request;
import okhttp3.RequestBody;
import org.junit.platform.commons.logging.Logger;
import org.junit.platform.commons.logging.LoggerFactory;

class RequestBuilder {
  private static final Logger LOG = LoggerFactory.getLogger(RequestBuilder.class);
  private Request.Builder builder;
  private String graphQLQueryBody;

  RequestBuilder(String graphQLEndpoint, String graphQlJwtToken, String filePath) throws IOException {
    URL graphQLUrl = new URL(graphQLEndpoint);
    builder = new Request.Builder()
        .url(graphQLUrl)
        .header("Accept", "application/json")
        .header("Content-Type", "application/json");

    InputStream in = getClass().getClassLoader().getResourceAsStream(filePath);
    BufferedReader reader = new BufferedReader(new InputStreamReader(in));
    String queryBody = reader.lines().collect(Collectors.joining(lineSeparator()));
    this.graphQLQueryBody = updateTimeStamp(queryBody);
  }

  Request build() throws JsonProcessingException {
    ApiRequestBody apiRequestBody = new ApiRequestBody(this.graphQLQueryBody);
    return builder
        .method("POST", RequestBody.create(apiRequestBodyToJson(apiRequestBody).getBytes()))
        .build();
  }

  private static String apiRequestBodyToJson(ApiRequestBody apiRequestBody) throws JsonProcessingException {
    ObjectMapper objectMapper = new ObjectMapper();
    return objectMapper.writeValueAsString(apiRequestBody);
  }

  private String updateTimeStamp(String str){
    Instant curTime = Instant.now();
    Instant prevTime = curTime.minusSeconds(3600);

    String updatedStartTime = "      startTime: \"" + prevTime + "\"";
    String updatedEndTime = "      endTime: \"" + curTime + "\"";

    str = str.replaceAll("(.*)startTime(.*)", updatedStartTime);
    str = str.replaceAll("(.*)endTime(.*)", updatedEndTime);

    return str;
  }
}
