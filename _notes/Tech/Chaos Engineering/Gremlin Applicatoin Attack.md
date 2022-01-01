---
tags: chaos-gameday, chaos-engineering, gremlin
title: Gremlin Application Layer Fault Injection
categories: [Tech]
---

# TL;DR

Gremlin 의 아래 항목을 검증 완료하였으며, github 의 다양한 예제가 나와 있다.
- [alfi-hello-world](https://github.com/gremlin/alfi-hello-world)
- [alfi-spring-boot](https://github.com/gremlin/alfi-spring-boot)
- [alfi-apache-http-client](https://github.com/gremlin/alfi-apache-http-client)


**장점**

- WebUI 를 통해서 `Latency 지연` 또는 `RuntimeException` 을 쉽게 발생시킬 수 있다.
- Gremlin SDK 를 통해서 type 에 따라서 선별적으로 적용 가능하다.

**아쉬운 점**
- HTTP Header 에 따른 선별적 적용을 직접 구현해야 한다. 
- ChaosMonkey 에 비해 해야할 작업들이 많다. 
- Outbound 가 apache-http-client 만 지원한다. RestTemplate, WebClient 를 사용한다면 직접 구현해야 한다.


| 대상      | 검증항목                                | /ping | /ping?a=b | /ping/wow |
| ------- | ----------------------------------- | ----- | --------- | --------- |
| Inbound | GET /ping 을 지연시킨다.                  | ✅     | ✅         | ❌         |
| Inbound | GET /ping 지연 후, 예외를 발생시킨다.          | ✅     | ✅         | ✅         |
| Inbound | GET /ping 을 특정 header 값 기준으로 지연시킨다. | ✅     | ✅         | ❌         |
| Inbound | GET 모든 요청을 지연시킨다.                   | ✅     | ✅         | ✅         |

# References

- [Gremlin Application Layer Ovewview](https://www.gremlin.com/docs/application-layer/overview/)

