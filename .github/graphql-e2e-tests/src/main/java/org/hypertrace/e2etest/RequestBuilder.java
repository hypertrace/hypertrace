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
//  private static final String betweenFilterRegex = "between:\\s*\\{\\s*startTime:\\s*\"(\\S+)\"[,\\s]+endTime:\\s*\"(\\S+)\"\\s*}";
//  private static final Pattern betweenFilterRegexPattern = Pattern.compile(betweenFilterRegex);

  RequestBuilder(String graphQLEndpoint, String graphQlJwtToken, String filePath) throws IOException {
    URL graphQLUrl = new URL(graphQLEndpoint);
    builder = new Request.Builder()
        .url(graphQLUrl)
        .header("Accept", "application/json")
        .header("Content-Type", "application/json");
        //.header("Authorization", "Bearer " + graphQlJwtToken);

    InputStream in = getClass().getClassLoader().getResourceAsStream(filePath);
    BufferedReader reader = new BufferedReader(new InputStreamReader(in));
    this.graphQLQueryBody = reader.lines().collect(Collectors.joining(lineSeparator()));
  }

//   RequestBuilder withTimeBounds(Instant startTime, Instant endTime) {
//    // between: {startTime: "2019-10-29T21:30:12.871Z", endTime: "2019-10-29T21:45:12.871Z"}
//    int lengthDiff = 0;
//    Matcher matcher = betweenFilterRegexPattern.matcher(this.graphQLQueryBody);
//    while (matcher.find()) {
//      // Replace "startTime" first
//      StringBuilder sb1 = new StringBuilder(this.graphQLQueryBody);
//      sb1 = sb1
//          .replace(matcher.start(1) + lengthDiff, matcher.end(1) + lengthDiff, startTime.toString());
//      String queryBodyWithStartTimeReplaced = sb1.toString();
//
//      // Need to shift the index of the endTime group matcher with the diff of the new string with startTime replaced
//      lengthDiff = lengthDiff + queryBodyWithStartTimeReplaced.length() - this.graphQLQueryBody.length();
//
//      // Then replace "endTime"
//      StringBuilder sb2 = new StringBuilder(queryBodyWithStartTimeReplaced);
//      sb2.replace(matcher.start(2) + lengthDiff, matcher.end(2) + lengthDiff, endTime.toString());
//      this.graphQLQueryBody = sb2.toString();
//      lengthDiff = lengthDiff + graphQLQueryBody.length() - queryBodyWithStartTimeReplaced.length();
//    }
//    LOG.info(() -> "Request built: " + this.graphQLQueryBody);
//    return this;
//  }

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
