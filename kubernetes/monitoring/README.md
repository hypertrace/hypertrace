## Monitoring Hypertrace
To help in monitoring hypertrace, It exposes certain application and resource level metrics by using 
[micrometer](https://github.com/micrometer-metrics/micrometer) library.

It is currently configured to report all of the metrics to Prometheus. Each pod of the `hypertrace-service` 
and  `hypertrace-ingester` are annotated with `prometheus.io/scrape: true`. You can access all the metrics 
for these services by deploying [Prometheus-operator](https://github.com/prometheus-operator/prometheus-operator) 
in your kube environment. All of the metrics are exposed via `/metrics` endpoint of each pod deployment's 
admin port. These metrics can be grouped into three categories as described below.

### Resource Metrics
#### JVM class loading metrics
| Name                                   | Description                                                                               |
| -------------------------------------- | ----------------------------------------------------------------------------------------- |
| jvm\_classes\_loaded\_classes          | The number of classes that are currently loaded in the Java virtual machine               |
| jvm\_classes\_unloaded\_classes\_total | The total number of classes unloaded since the Java virtual machine has started execution |

#### JVM GC Metrics
| Name                                                                                       | Description                                                                                                 |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| jvm\_gc\_max\_data\_size\_bytes                                                            | Max size of old generation memory pool                                                                      |
| jvm\_gc\_live\_data\_size                                                                  | Size of old generation memory pool after a full GC                                                          |
| jvm\_gc\_memory\_promoted\_bytes\_total                                                    | Count of positive increases in the size of the old generation memory pool before GC to after GC             |
| jvm\_gc\_memory\_allocated\_bytes\_total                                                   | Incremented for an increase in the size of the young generation memory pool after one GC to before the next |
| jvm\_gc\_pause\_seconds\_count, jvm\_gc\_pause\_seconds\_max, jvm\_gc\_pause\_seconds\_sum | Time spent in GC pause (if not concurrent phase)                                                            |
| jvm\_gc\_concurrent\_phase time                                                            | Time spent in concurrent phase                                                                              |

#### JVM Thread Metrics
| Name                          | Description                                                                         |
| ----------------------------- | ----------------------------------------------------------------------------------- |
| jvm\_threads\_peak\_threads   | The peak live thread count since the Java virtual machine started or peak was reset |
| jvm\_threads\_daemon\_threads | The current number of live daemon threads                                           |
| jvm\_threads\_live\_threads   | The current number of live threads including both daemon and non-daemon threads     |
| jvm\_threads\_states\_threads | The current number of threads having <STATE> state.                                 |

#### JVM Memory Metrics
| Name                                | Description                                                                           |
| ----------------------------------- | ------------------------------------------------------------------------------------- |
| jvm\_buffer\_count\_buffers         | An estimate of the number of buffers in the pool                                      |
| jvm\_buffer\_memory\_used\_bytes    | An estimate of the memory that the Java virtual machine is using for this buffer pool |
| jvm\_buffer\_total\_capacity\_bytes | An estimate of the total capacity of the buffers in this pool                         |
| jvm\_memory\_used\_bytes            | The amount of used memory                                                             |
| jvm\_memory\_committed\_bytes       | The amount of memory in bytes that is committed for the Java virtual machine to use   |
| jvm\_memory\_max\_bytes             | The maximum amount of memory in bytes that can be used for memory management          |

#### System Metrics
| Name                      | Description                                                                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| system\_cpu\_count        | The number of processors available to the Java virtual machine                                                                                                                   |
| system\_load\_average\_1m | The sum of the number of runnable entities queued to available processors and the number of runnable entities running on the available processors averaged over a period of time |
| system\_cpu\_usage        | The "recent cpu usage" for the whole system    

#### Process Metrics
| Name                                                 | Description                                                 |
| ---------------------------------------------------- | ----------------------------------------------------------- |
| process\_uptime\_seconds                             | The uptime of the Java virtual machine                      |
| process\_start\_time\_seconds                        | Start time of the process since unix epoch.                 |
| process\_uptime\_seconds                             | The uptime of the Java virtual machine                      |
| process\_start\_time\_seconds                        | Start time of the process since unix epoch.                 |
| process\_memory\_<rss | swap | threads | vss>\_bytes | Memory for different sections                               |
| process\_threads                                     | The number of process threads                               |
| process\_cpu\_usage                                  | The "recent cpu usage" for the Java Virtual Machine process |

### Hypetrace Ingestion Layer
Hypertrace Ingestion pipeline is kstream application which provides [built-in metrics](https://docs.confluent.io/platform/current/streams/monitoring.html#built-in-metrics), 
that are exposed via `/metrics` endpoint. So, refer above documentation for kstream related metrics. The below table
contains additional application metrics,

| Name                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| arrival\_lag\_seconds | Time taken to reach to specific ingestion component |


### Hypertrace Query Layer
#### Gateway Service APIs
Measure the taken for each request at the Gateway Service layer which is an entry point for the GraphQL layer.

| Name                                                                       | Description                                                      |
| -------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| org\_hypertrace\_core\_serviceframework\_span\_query\_execution            | Time taken in executing spans request                            |
| org\_hypertrace\_core\_serviceframework\_entities\_query\_execution        | Time taken in executing entities request                         |
| org\_hypertrace\_core\_serviceframework\_traces\_query\_execution          | Time taken in executing traces request                           |
| org\_hypertrace\_core\_serviceframework\_explore\_query\_execution         | Time taken in executing explore request                          |
| org\_hypertrace\_core\_serviceframework\_entities\_query\_build            | Time spent in transformation on entities request                 |
| org\_hypertrace\_core\_serviceframework\_span\_query\_execution\_count     | Total number of spans request, helps in calculating QPS          |
| org\_hypertrace\_core\_serviceframework\_entities\_query\_execution\_count | Total number of entities request, helps in calculating QPS       |
| org\_hypertrace\_core\_serviceframework\_traces\_query\_execution\_count   | Total number of tracess request, helps in calculating QPS        |
| org\_hypertrace\_core\_serviceframework\_explore\_query\_execution\_count  | Total number of explorer request, helps in calculating QPS       |
| org\_hypertrace\_core\_serviceframework\_entities\_query\_build\_count     | Total number of entities build request, helps in calculating QPS |

#### Pinot Request Handle
Measure the time taken by executing the query to pinot via different request handle based on different views.

| Name                                  | Description                                             |
| ------------------------------------- | ------------------------------------------------------- |
| pinot\_query\_latency\_seconds        | Time taken by executing pinot query                     |
| pinot\_query\_latency\_seconds\_count | Total number of pinot request, helps in calculating QPS |

### Pre-built dashboards
Based on the above metrics, we have prepared below dashboard for each of the categories, and it can be 
imported into any metric visualisation platform like grafana etc
```
dashboards/000-jvm-metrics.json - JVM/Process/System related metrics
dashboards/001-ingestion-pipeline-metrics.json - Application metrics for ingestion pipeline
dashboards/002-query-layer-pipeline-metrics.json - Application metrics for query layer metrics 
```

### Misc
Prometheus operator provides a collection of helm charts, grafana dashboards and prometheus rules 
which help in monitoring different components of deployment. Find more information [here](https://github.com/prometheus-community/helm-charts/).
As an example,
- kubernetes resources metrics can be derived by using kubelet metrics endpoints and [kube-state-metrics](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/Chart.yaml).
- kafka related metrics can be derived using [kafka-exporter-operator](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-kafka-exporter).



