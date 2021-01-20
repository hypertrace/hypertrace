package org.hypertrace.e2etest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import java.io.IOException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import okhttp3.Request;
import okhttp3.Response;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

public class ApiTest {
  // The endpoint i.e host and port or the URL without the "/graphql" part
  private static final Integer DEFAULT_TIMERANGE_QUERY_TEST = 15;
  private static String htuiIp = System.getenv("HTUI_IP");
  private static String graphQLEndpoint = "http://"+htuiIp+":2020";
  private static String graphQLUrl;
  private static String graphQLResource = "/graphql";
  private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

  private static RequestExecutor requestExecutor;

  @BeforeAll
  public static void setupForAllTests() {
    requestExecutor = new RequestExecutor();
    if (System.getenv("GRAPHQL_ENDPOINT") != null) {
      graphQLEndpoint = System.getenv("GRAPHQL_ENDPOINT");
    }
    graphQLUrl = graphQLEndpoint + graphQLResource;
    System.out.println(graphQLUrl);
  }

  @Test
  public void metadataQuery_shouldSucceed() throws IOException {
    Response response = executeGraphQLQuery("e2e-test/metadata.graphql");
    assertResponseSanity(
        response,
        dataJsonNode -> {
          ArrayNode metadataArray = (ArrayNode) dataJsonNode.get("metadata");
          // Should at least have 20 attributes
          assertTrue(metadataArray.size() > 20);
        });
  }

  @Test
  public void topologyQuery_shouldSucceed() throws IOException {
    Response response = executeGraphQLQuery("e2e-test/topology.graphql");
    assertResponseSanity(response, this::verifyNonZeroEntityResults);
  }

  @Test
  public void servicesQuery_shouldSucceed() throws IOException {
    Response response = executeGraphQLQuery("e2e-test/services.graphql");
    assertResponseSanity(response, this::verifyNonZeroEntityResults);
  }

  @Test
  public void backendsQuery_shouldSucceed() throws IOException {
    Response response = executeGraphQLQuery("e2e-test/backends.graphql");
    assertResponseSanity(response, this::verifyNonZeroEntityResults);
  }

  @Test
  public void traceIDQuery_shouldSucceed() throws IOException {
    Response response = executeGraphQLQuery("e2e-test/find-trace.graphql");
    assertResponseBasedOnTraceData(response, "1", "traces");
  }

  @Test
  public void numberOfSpansQuery_shouldSucceed() throws IOException {
    Response response = executeGraphQLQuery("e2e-test/number-of-spans.graphql");
    assertResponseBasedOnTraceData(response, "50", "spans");
  }


  private Response executeGraphQLQuery(String filePath) throws IOException {
    Request request =
        new RequestBuilder(graphQLUrl, "", filePath)
            .build();

    return requestExecutor.executeRequest(request);
  }

  // Has "data" element and no "errors" element.
  private void assertResponseSanity(Response response, Consumer<JsonNode> specificAssertion)
      throws IOException {
    assertEquals(200, response.code());
    JsonNode responseJson = readResponseJsonIntoTree(response);
    assertNull(responseJson.findValue("errors"));
    assertNotNull(responseJson.findValue("data"));
    specificAssertion.accept(responseJson.findValue("data"));
  }

  private void assertResponseBasedOnTraceData(Response response, String actualValue, String typeOfData)
          throws IOException {
    assertEquals(200, response.code());
    JsonNode responseJson = readResponseJsonIntoTree(response);
    assertNull(responseJson.findValue("errors"));
    assertNotNull(responseJson.findValue("data"));
    if (typeOfData == "traces") {
      String numberOfTraces = responseJson.at("/data/traces/total").asText();
      assertEquals(numberOfTraces, actualValue);
    }
    else if (typeOfData == "spans"){
      String numberOfSpans = responseJson.at("/data/spans/total").asText();
      assertEquals(numberOfSpans, actualValue);
    }
  }

  private JsonNode readResponseJsonIntoTree(Response response) throws IOException {
    return OBJECT_MAPPER.readTree(response.body().charStream());
  }

  private void verifyNonZeroEntityResults(JsonNode dataJsonNode) {
    ArrayNode resultArray = (ArrayNode) dataJsonNode.findValue("entities").get("results");
    if (resultArray.size() == 0) {
      fail(String.format("Results array is empty. It should not be. %n %s", dataJsonNode));
    }
  }
}
