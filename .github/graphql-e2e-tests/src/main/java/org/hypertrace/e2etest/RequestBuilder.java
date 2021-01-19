package org.hypertrace.e2etest;

import static java.lang.System.lineSeparator;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.Request;
import okhttp3.RequestBody;

import java.io.*;
import java.net.URL;
import java.time.Instant;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
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
    this.graphQLQueryBody = reader.lines().collect(Collectors.joining(lineSeparator()));
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
}
