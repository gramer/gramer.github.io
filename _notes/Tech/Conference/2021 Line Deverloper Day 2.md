---
tags: conference 
title: 2021 Line Developer Day
categories: ["Conference"]
---

# Kubernetes에서 가시성 사례 구현

- [동영상 바로가기](https://www.youtube.com/watch?v=PHYAHR6oBH4)
- [발표 자료 바로가기](https://speakerdeck.com/line_devday2021/implementing-observability-practices-on-kubernetes)
- 70개의 클러스터
- Tranditional Monitoring
	- Monitoring : Dashboard Redundant works, Long-term storage
- Observability Platform Platform
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/022c2eff95594f718f21a284da0e8df5?slide=13" title="Implementing Observability Practices on Kubernetes" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/022c2eff95594f718f21a284da0e8df5?slide=14" title="Implementing Observability Practices on Kubernetes" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/022c2eff95594f718f21a284da0e8df5?slide=15" title="Implementing Observability Practices on Kubernetes" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>
- https://github.com/open-telemetry/opentelemetry-collector
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/022c2eff95594f718f21a284da0e8df5?slide=18" title="Implementing Observability Practices on Kubernetes" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>
- managed ingress controller 를 통해 요청에 대한 추적
- How to manage agent for 70 + clusters
- Git -> Argo CD -> All Clusters
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/022c2eff95594f718f21a284da0e8df5?slide=27" title="Implementing Observability Practices on Kubernetes" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>
- 어떻게 사람들에게 전파할까?
	- Online Workshop 을 통해서
	- 기본 공동 대시보드
- 활용사례
	- Alert -> Metric -> Logs -> Log(LogQL 를 통해 마지막 쿼리의 시간을 확인?)
	- Metrics -> Logs -> Traces(Tempo View가 강력하다.) -> Logs
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/022c2eff95594f718f21a284da0e8df5?slide=44" title="Implementing Observability Practices on Kubernetes" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>

# Redis Pub/Sub을 사용해 대규모 사용자에게 고속으로 설정 정보를 배포한 사례

- [발표 영상](https://www.youtube.com/watch?v=CENLaIz2Yb8)
- [발표 자료](https://speakerdeck.com/line_devday2021/sub-of-redis)
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/204fb751befc42308402bb4cf11c4441?slide=7" title="High-Speed Distribution to Enormous Group Using Pub/Sub of Redis" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>
- <iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/204fb751befc42308402bb4cf11c4441?slide=23" title="High-Speed Distribution to Enormous Group Using Pub/Sub of Redis" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 800px; height: 500px;" data-ratio="1.78343949044586"></iframe>

# 대규모 음악 데이터 검색 기능을 위한 Elasticsearch 구성 및 속도 개선 방법

- [발표 영상](https://www.youtube.com/watch?v=xP1QFpxhYi4)
- [발표 자료](https://speakerdeck.com/line_devday2021/knowledge-derived-from-search-for-huge-track-metadata-with-elasticsearch)
- 85,000,000 건의 음악 데이터에서 제목이 아닌 다른 필드의 속성으로 검색 시작
- wild search 로 인해 검색 성능 저하 (5s)
- term -> match
- 글자 타이핑에 따라서 n-gram 을 동적으로 선택
- Data node >= shard * (replica + 1)