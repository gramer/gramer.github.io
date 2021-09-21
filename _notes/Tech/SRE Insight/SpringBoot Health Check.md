---
tags: springboot,actuator,healthcheck,incident 
title: About SpringBoot Health Check
categories: SRE Insight
---

# 현상

- 특정 pod 의 외부 트래픽을 지연 시켰을 때 pod 이 재시작 되었다.
- Gremlin 통해 공격 가능

# 원인

- 외부 트래픽 지연 시에 SpringBoot actuator/health 가 503 을 리턴
- redis, db 등 spring 에서 관리하고 있는 컴포넌트가 connection timeout 으로 인해서 health check에 실패
- health check 대상 컴포넌트 중에 하나라도 실패할 경우 `actuator/health` 는 503 리턴

# Recommendation

## Actuator Health 사용시

- health check 용도는 /actuator/health/ping을 우선 검토
- ==/actuator/health==를 사용할 때 어떤 health indicator가 사용되고 있는지 확인
- SpringBoot 2.3 이후 버전이라면 health group 과 probe 기능을 검토

## SpringBoot 2.3 이전

/actuator/health 를 사용한다면, show-details 옵션을 활성화 하여 어떤 health check 가 실행 중인지 확인하고 선별해서 사용할 수 있습니다. 아래와 같이 healthcheck 에 제외하는 것도 방법입니다.

```yaml
    management:
      endpoint:
        health:
          show-details: always
      health:
        redis:
          enabled: false
```

## SpringBoot 2.3 이후 Health Groups 이용

[Health Groups 관련 메뉴얼 바로 가기](https://docs.spring.io/spring-boot/docs/2.3.0.RELEASE/reference/html/production-ready-features.html#production-ready-health-groups)

health group 을 이용하여 원하는 k8s 용으로 liveness 와 readiness 를 제어할 수 있습니다. 단 아래와 같이 할 경우에는 /actuator/health/livness, /actuator/health/readiness url 을 k8s 의 Probe 설정에서 사용하셔야 합니다.

```yaml
    management:
      endpoint:
        health:
          show-details: always
          group:
            liveness:
              include: ping
            readiness:
              include: ping
```

```json
    GET http://127.0.0.1:8080/actuator/health/liveness

    HTTP/1.1 200 
    Content-Type: application/vnd.spring-boot.actuator.v3+json
    Transfer-Encoding: chunked
    Date: Thu, 02 Sep 2021 05:17:00 GMT
    Keep-Alive: timeout=60
    Connection: keep-alive

    {
      "status": "UP",
      "components": {
        "ping": {
          "status": "UP"
        }
      }
    }
```

## SpringBoot 2.3 이후 Probe 이용

SpringBootApp 내에서 livenessState, readinessState 를 이벤트를 통해 직접관리할 수 도 있습니다. 단순한 예제이지만, 서비스 내에서 상태에 따라서, 아래와 같이 liveness, readiness 를 결정할 수도 있습니다.

[SpringBoot Kubernetes Probes 관련 메뉴얼 바로가기](https://docs.spring.io/spring-boot/docs/2.3.0.RELEASE/reference/html/production-ready-features.html#production-ready-kubernetes-probes)

```yaml
    management:
      endpoint:
        health:
          show-details: always
          group:
            liveness:
              include: ping,livenessState,
            readiness:
              include: ping,readinessState
          probes:
            enabled: true

```

```java
    @RestController
    class AppicationAvailabilityController(
        private val eventPublisher: ApplicationEventPublisher
    ) {

        @GetMapping("broken")
        fun broken(): Nothing = throw Exception("broken request").also {
            AvailabilityChangeEvent.publish(
                this.eventPublisher, it,
                LivenessState.BROKEN
            )
        }

        @GetMapping("correct")
        fun correct() = AvailabilityChangeEvent.publish(
            this.eventPublisher, "ok",
            LivenessState.CORRECT
        )
    }

```

# References

- [Auto-configured HealthIndicators 관련 메뉴얼 바로 가기](https://docs.spring.io/spring-boot/docs/2.3.0.RELEASE/reference/html/production-ready-features.html#production-ready-health-indicators)
