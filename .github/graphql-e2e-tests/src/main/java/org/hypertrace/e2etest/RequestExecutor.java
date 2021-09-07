package org.hypertrace.e2etest;

import java.io.IOException;
import java.util.concurrent.TimeUnit;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

class RequestExecutor {
  private OkHttpClient httpClient;

  RequestExecutor() {
    this.httpClient = new OkHttpClient().newBuilder()
        .readTimeout(15,
            TimeUnit.SECONDS)
        .build();
  }

  Response executeRequest(Request request) throws IOException {
    return httpClient.newCall(request).execute();
  }
}
