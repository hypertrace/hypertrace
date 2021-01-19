package org.hypertrace.e2etest;

public class ApiRequestBody {
  private String query;

  public ApiRequestBody(String query) {
    this.query = query;
  }

  public void setQuery(String query) {
    this.query = query;
  }

  public String getQuery() {
    return query;
  }
}
