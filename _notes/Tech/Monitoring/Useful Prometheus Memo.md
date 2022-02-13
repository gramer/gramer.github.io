---
tags: metric
categories: Tech
---

# References

- [Monitoring Disk I/O on Linux with the Node Exporter](https://devconnected.com/monitoring-disk-i-o-on-linux-with-the-node-exporter/)


# Related Alert

k8s 에서 cpu 가 제한된 시간
```
100
  * sum by(container_name, pod_name, namespace) (increase(container_cpu_cfs_throttled_periods_total{container_name!=""}[6m]))
  / sum by(container_name, pod_name, namespace) (increase(container_cpu_cfs_periods_total[6m]))
  > 10
```