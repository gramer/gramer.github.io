---
tags: chaos-gameday, chaos-engineering, gremlin
title: Gremlin 관련 메모
categories: [Tech]
---

# Gremlin

## Useful Attack

MSA 환경에서 대상 서비스가 문제가 발생하는 경우, 오류를 응답하거나 지연된다.

### Latency

Connection Timeout, Read Timeout, 또는 이전 장애 상황에 따라서 지연 값을 참고한다.

## Future Plan

- 전사 사용자들이 사용할 수 있도록 체계를 만든다.

## Application Layer

- Latency 이 외에  Application Attack 을 통한 5xx 실험 Poc

## Operations

- kakaowork webhook 을 이용해서 사용현황을 실시간으로 파악

# References

- [Gremlin Application Layer Ovewview](https://www.gremlin.com/docs/application-layer/overview/)
