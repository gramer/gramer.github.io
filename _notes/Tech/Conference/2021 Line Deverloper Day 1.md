---
tags: conference 
title: 2021 Line Developer Day
categories: ["Conference"]
---

[Line Deverloper Day 2021 바로가기](https://linedevday.linecorp.com/2021/ko/live/track1)

**Table of Contents**

- [[#Idea|Idea]]
- [[#Opening Keynote|Opening Keynote]]
- [[#사용자 속성 추정 시스템을 개편하면서 발생한 다양한 이슈와 해결 사례 소개|사용자 속성 추정 시스템을 개편하면서 발생한 다양한 이슈와 해결 사례 소개]]
- [[#Lupus – MLOps 가속화를 위한 모니터링 시스템|Lupus – MLOps 가속화를 위한 모니터링 시스템]]
- [[#LINT: HTTP/2와 TLS를 통한 네트워크 현대화|LINT: HTTP/2와 TLS를 통한 네트워크 현대화]]
- [[#KSETL로 Kafka 스트림 ETL 시스템을 빠르게 구성하기|KSETL로 Kafka 스트림 ETL 시스템을 빠르게 구성하기]]
- [[#LINE 플랫폼 서버의 장애 대응 프로세스와 문화|LINE 플랫폼 서버의 장애 대응 프로세스와 문화]]
- [[#TCP로 인한 대규모 Kafka 클러스터 요청 지연 문제 해결 사례|TCP로 인한 대규모 Kafka 클러스터 요청 지연 문제 해결 사례]]
- [[#PIPE: 더 나은 개발자 경험을 위한 CI/CD + Runtime|PIPE: 더 나은 개발자 경험을 위한 CI/CD + Runtime]]
- [[#Zero-Downtime Kubernetes Cluster Upgrade Solution|Zero-Downtime Kubernetes Cluster Upgrade Solution]]
- [[#LINE Pay 모니터링 시스템 구축과 ML을 이용한 비정상 로그 탐지|LINE Pay 모니터링 시스템 구축과 ML을 이용한 비정상 로그 탐지]]
- [[#멀티 테넌트 k8s 클러스터로 구축하는 신뢰할 수 있는 로그 수집 인프라|멀티 테넌트 k8s 클러스터로 구축하는 신뢰할 수 있는 로그 수집 인프라]]


# Idea

- Grafana alert 을 사용하는 것에 있어 alert manager 를 통해 alert system 의 fail 를 처리할까?
- node-problem-detecter
- nodex exporter 를 통해서 syn flooding 을 확인 가능
- 장애 프로세스에서 메일을 통한 공유
- 간단한 ML 을 적용해보자.

# Opening Keynote

- 400k Req/Sec
- Link 72 Billion
- Channel 2.48 Million

tata
성우를 쓴다.

- 하이퍼 클로바
  - 700 petaflops
  - 일본어 한국어 모델 구축중
  - 34B -> 89B -> 204B 모델 구축 진행중
  - 요약, 문서생성, 대화
  - STT -> 하이파클로바 --> TTS
  - 이미지, 음성신호 멀티 모델

- 블록체인
  - NFT market 기반 월렛
  - 대규모 에너지 소비 (GPU) - 합의에 따른
  - 트랜잭션 비용
  - 비잔틴 장군? 합의 알고리즘
  - 스마트 계약, 이더리움 브릿지

# 사용자 속성 추정 시스템을 개편하면서 발생한 다양한 이슈와 해결 사례 소개

[바로가기](https://linedevday.linecorp.com/2021/ko/live/track4)

용어 괜찮네 - System revamping

# Lupus – MLOps 가속화를 위한 모니터링 시스템

MLOps 란?
![[What_mlops.png]]

# LINT: HTTP/2와 TLS를 통한 네트워크 현대화

- [발표자료 바로가기](https://speakerdeck.com/line_devday2021/2-and-tls)
- Legy Protocol, Legy Encryption Applied
  - SPDY Outdated
  - 단점 : 자체 프로토콜, 디버깅이 어려웠다.
- Line Improvement for Next Ten years
  - Migration http/2
    - header compaction
    - Client 기반 네트워크를 추상화 : SPDY, HTTP/2 모두 지원, 필요에 따라 fallback
    - http/2 를 설정을 통해 비활성화 할 수 있어야 한다.
    - feature on/off

![[Network_abstraction_client_config.png]]
![[TLS_1.2.png]]
![[TLS_1.3.png]]

- TLS1.3, RTT 를 줄이기 위해 노력
- session id, session ticket
- TLS 1.3, TLS 1.2 Resumption
- [관련 아티클](https://blog.cloudflare.com/tls-session-resumption-full-speed-and-secure/)

# KSETL로 Kafka 스트림 ETL 시스템을 빠르게 구성하기

kafka stream 을 이용하여 복잡한 프로그래밍을 통한 join 등의 작업을 sql 를 이용하여 손쉽게 이용할 수 있도록 직접 개발
FlinkSQL

# LINE 플랫폼 서버의 장애 대응 프로세스와 문화

- [발표자료 바로가기](https://speakerdeck.com/line_devday2021/outage-handling-process-and-culture-of-the-line-platform-server)
- outage, 장애, 장애를 통한 개선의 기회
- ![[Outage_Handling_Process.png]]
- ![[Outage_Handling_Process_Level.png]]
- 개발리더가 장애대응의 총책임, 대응을 컨트롤 한다, 리더가 전파를 담당한다.
- 장애 시에 당일 장애 내용 공유, ==메일링==
- ![[Outage_Handling_Process_Report.png]]
- ![[Outage_prevention.png]]
- Oncall Duty
- Managing Outage related action items
- OKR 를 통해 관리한다.

![[Outage_summary_example.png]]
![[Outage_timetable.png]]
![[Outage_action_items.png]]

# TCP로 인한 대규모 Kafka 클러스터 요청 지연 문제 해결 사례

- [발표자료 바로가기](https://speakerdeck.com/line_devday2021/investigating-request-delay-in-a-large-scale-kafka-cluster-caused-by-tcp)
- 2019 라인데브데이 사례가 있다.
- 롤링 업데이트 시에 프로듀서에서 문제가 발생했다. timeout
  - 서버와 producer 의 latency 가 달랐다.
  - 왜 latency 의 gab이 발생했나?
  - ![[Kafka_latency.png]]
  - Producer IO Thread Stuck
  - node_exporter 에 TCP_SYN_Cookies
  - ![[TCP_syn_cookies.png]]
  - ![[TCP_syn_cookies_flodding.png]]
  - ![[TCP_syn_cookies_.png]]
  - 18000 건의 트래픽이 몰려 flooding 과 같은 상황
  - ![[TCP_window.png]]
  - ![[TCP_sync_cookies_wsize_limit.png]]
  - window scaling
  - ![[TCP_sync_cookies_wcaling__.png]]
  - ![[TCP_sync_cookies_wscaling_.png]]
  - ![[TCP_sync_cookies_wscaling.png]]
  - ![[TCP_sync_cookies_drawback.png]]
  - ![[TCP_syn_cookies_timestamp.png]]
  - syn cookie 에서 window scaling 이, tcp_syncookies = 2
  - ![[TCP_syn_tcpdump_.png]]
  - ![[TCP_syn_tcpdump.png]]
  - 왜 window size 가 즐어 들었나?
  - ss -i 를 통해 확인, tcp_select_window, 어떻게 하면 kernel 호출을 hook 할 수 있ㅇ르까?
  - ![[TCP_kernel_hook.png]]
  - ![[TCP_scaling_factor.png]]
  - ![[TCP_sync_kernel_bug.png]]
  - linux kernel's bug (5.10)
  - ![[TCP_syn_cookies_okay.png]]
  - ![[TCP_syn_cookies_overall_flow_.png]]
  - ![[TCP_syn_cookies_overall_flow.png]]
  - ![[TCP_syn_cookies_solution.png]]
  - ![[TCP_syn_cookies_conclusion.png]]

# PIPE: 더 나은 개발자 경험을 위한 CI/CD + Runtime

- 발표자 이승
- Tekton Pipeline
- namespace as a service (tenancy model), [k8s policy engine](https://kyverno.io/docs/introduction/)
- tekton, k8s native CI/CD framework
- tekton hub, pipeline 을 관리한다.
- ![[Line_pipeline.png]]
- Core Cluster
  - OIDC  인증?
- Runtime Cluster * N
- kubeadm,  1.21 버전 이후에는 이전 버전은 에러가 난다.
- Runs on Physical Machines
  - Deployment tool: kubeadm Kubernetes version: v1.21.1
  - CNI: Calico with Typha IPAM plugin (대규모 네트워크에 적용)
  - CRI: containerd
  - CSI: OpenEBS, VSFS (Verda Shared File System)
  - Node roles: control-plane, build, gateway (private / public), none(user workloads)
- ![[Line_k8s_component.png]]
- ![[Line_k8s_auth_.png]]
- ![[Line_k8s_auth.png]]
- Monitoring
  - [node-problem-detector](https://github.com/kubernetes/node-problem-detector)
- Node role
- Roadmap
  - verda, multiple az
  - functions
  - ![[Line_k8s_virtual_k8s_platform.png]]

# Zero-Downtime Kubernetes Cluster Upgrade Solution

![[Line_k8s_architecture.png]]

- Scale: 570 Clusters 8700 Nodes
- 10 Operators
- Upgrade Solution
  - Zero downtime, Safely, Flexibility
- Safety
  - Rollback, 호환성(1.21.x 에서 하위 호환을 어떻게?)
- Rancher
  - Safety
    - health checking
    - no node ready state checking / version skew checking / api compatibility checking
    - manual rollback
  - Flexibility
    - Control Plane, Worker 갯수를 지정하여 업그레이드 가능
  - Zero Downtime
- kubeadm
  - 배치 업그레이드를 지원하지 않는다.

![[Line_k8s_rancher_kubeadm_compare.png]]

- Tech Direction : Rancher 의 plugin 기능을 추가 개발
  - kubeadm 기능을 참조
  - rollback etcd 복원
  - worker node 는 label 을 선택해서 업그레이드를 진행

![[Line_k8s_update_phase.png]]

# LINE Pay 모니터링 시스템 구축과 ML을 이용한 비정상 로그 탐지

- [발표자료 바로가기](https://speakerdeck.com/line_devday2021/building-line-pay-monitoring-system-and-anomaly-log-detection-system-using-ml)
- [영상자료 바로가기](https://www.youtube.com/watch?v=ynB3i3bonFo)
- 기존 문제
  - 다양한 시스템, 각자 시스템에서 알람을 발생
  - 한 서버가 다른 서버의 메트릭보다 높을 때, 현재 임계치로만 알람
  - 라인페이 외부의 문제일 때 메트릭이 급격한 감소
- 자체 모니터링 시스템 구축

![[Line_new_monitoring_system.png]]

- Collecting Metrics
  - 시스템, 어플리케이션 Exporter
  - Log appender -> Log Collector
- Processing
  - Flink 에서 스트림 처리
  - 이상탐지
- Visualization
  - Grafana, Alert manager
- 알람
  - 이상탐지 관련  평균과 표준편차를 통해 한 대의 서버 문제 찾음
- 서비스 별 메트릭 패턴 분석
  - 관리자, 사용자 트래픽에 따라, 배치 용도
- API 의 모수가 경우,  평균과 표준편차에 이상탐지 어렵
- ML
  - 로그를 통한 예측
    - 특정 API 의 증가는 장애의 시작
    - 특정 로그의 증가는 장애의 시작
    - 비지도학습, 재학습에, 성능, Root Cause 를 빠르게, 단순한 방법
    - 가우시안 분포등,
      - 로그의 비율 (5, 10)
      - API 별로 가우시안 분포가 나타남,
      - API Count 증가율에 따라
      - Minorities
        - 패널티를 준다.
    - LSTM (Long Short-Term Memory)
      - ![[Line_log_m.png]]
    - Deep log 논문 참고

![[Line_new_monitoring_ml_architecture.png]]

# 멀티 테넌트 k8s 클러스터로 구축하는 신뢰할 수 있는 로그 수집 인프라

- [발표 영상 바로가기](https://www.youtube.com/watch?v=jXN0AhOt_8A)
- [발표 자료 바로가기](https://speakerdeck.com/line_devday2021/reliable-log-aggregation-system-in-multi-tenant-kubernetes-cluster)
- SRE 팀의 두 가지 유닛 : Platform wide SRE, Infra Management
- Log aggregation in Verda
  - 어플리케이션 로그, 감사로그
  - Problem: Pod 안에서 log-rotated, fluentd -> es 로 송신
    - Too many sidecar, hard to schedule
    - quality depends on each team
  - Solution:
    - managed fluentd cluster
    - pod 은 stdout, forwarder (deamonset, fluentd)
  - Fluentd Config Operator
  - VictoriaMetrics 를 통해 저장
  - kafka 를 통해서 통한 확장을 고민 중 forwarder -> kafka -> aggregator -> elasticsearch
