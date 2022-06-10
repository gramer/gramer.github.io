---
tags: conference
title: Toss slash
categories: ["Conference"]
---

### 토스

## 1일차

- 보이스톤메이커
- front devops
  - SSR
  - Web Vitals, LCP
  - Props Drilliing 문제
  - useResource 을 통해 data fetcing hook
  - query-client, predefine 등을 통해
    - server compoment
- 코드 관련
  - package import 문으로 코드 스멜
  - 표준 layer
    - presentation
    - biz
    - imple
    - data

![[Toss 표준 모듈 구조.png]]

![[Toss 표준모듈 예시.png]]

## 2일차

## 3일차

## 인프라의 자동화

- VivaSystem -> CMDB
- Toss Infra Automation
  - 서버 배포 자동화:
  - 네트워크 설정 자동화
  - LB 설정 자동화
  - 방화벽 설정 자동화
  - 형상관리 자동화
    - 변경된 형상을 자동으로 수집한다.

![[Toss Infra Automation.png]]

## 물 흐르듯 자연스러은 ML 서비스 만들기 (MLOps)

딥러닝 프레임워크를 어떤 것을 제공할 것인가?

- MLFlow 언제까지 사용할 것인가를 고민,
- ML Flow 를 Wrapping
  - Model Serving,
- 모델 변환 중에 겪는 문제들
- 여러 언에에 대한 client 를 제공
- Google 외에 의존성 제로
- ==그냥 하면 되는 걸 할 수 있게 하는 걸 엔지니어링==

## 토스에서 테이블 정보를 어떻게 관리하나요?

- 테이블 센터를 통해서 관리하고 있다.
- 점진적으로 검색할 수 있는 drill down 검색
- 키워드 검색에서 우선순위가 있다.
  - 테이블 명 완전 매칭 1순위
  - 태그 / 태그 동의어 매칭 순위
  - 테이블 설명 부분 매칭 3순위
  - 컬럼명, 부분매칭
- 4시간 마다 정보 동기화 live db 에 동기화

![[Toss Table Center Architecture.png]]

- 표준 용어
  - 매번 설명을 추가할 필요가 없다.
- 영향도 분석
  - 테이블이 어떻게 사용되고 있는가

![[Toss 영향도 검색 아키텍처.png]]

- 데이터 품질 관리 구분: DQ 기능을 통해 알람을 발송

## iOS앱을 매주 배포한다고?

- 백만 라인
- 개발준비:
  - get_started.sh 로 ios 환경 설정을 자동화 했다.
  - 첫 빌드를 빠르게 한다.
  - micro featuer interface?
- 기능 개발:
  - git branch 를 먼저 push 한다.
  - ==git 행위가 jira 에 업데이트 된다.==
  - back merge commit 을 jenkins 를 통해서 미리
  - PR label 로, 특정 채널 공지, 자동 merge,
- 내부 배포
  - 나이틀리 배포
  - 릴리즈 마스터: 간단한 명령어, 릴리즈에 고민을 없애는 것, 대부분을 자동화 한다.

## 읽어버린 개발자의 시간을 찾아서

- SSR 로 인한 단점
  - 빌드 시간이 길어짐
- 번개 같이 빠른 개발자 경험~
- toss-fronted mono repo 구조
- Yarn Berry 로 npm 의존성 크기 문제를 해결
  - 캐싱, 버전관리 등이 이점
- Zero-install
  - shallow clone 방식, 변경 사항 파악이 힘들다.
  - Git 최신 버전에서 Filter Spec 기능 이용
  - 미리 복제해 둔다?
  - 5~7초로 줄일 수 있었다.
- docker image 에 대한 네트워크 시간을 줄인다.
  - 공통 레이어를 최대한 이용
  - Node File Trace

## Java Native Memory Leak 원인을 찾아서

- Pod OOM Killed alert 우리도 달아야할텐데..
- Native MemoryLeak
- -XX: NativeMemoryTracking=summary
- Native Memory 를 사용하는 경우
  - JNI, JNA
  - Direct Buffer 로 할당하게 되면, 네이티브 메모리를 사용
  - APM
- Process Memory Dump
  - pmap
  - smaps
  - gdb
  - strings 를 통해 문자열을 뽑아냄
  - Memory Allocator
    - malloc, jemalloc 으로 변환하면 모듈별 메모리 확인
  - C2 Compiler 메모리 릭이 발생했다.
    - openjdk issue 에서 확인
    - C2 Compiler
  - GraalVM 으로 처리
  - [JVM의 JIT(Just In Time Compilation) 컴파일이란? C1, C2 컴파일러를 이용한 최적화](https://kotlinworld.com/307)

## 어떻게 안정적인 서비스를 빠르게, 자주 출시할 것인가?

- 프로젝트 셋업 및 개발:
  - Boilerplate Project 를 유지하고 있다.
- 일괄 변경 script
  - log4j 취약점을 빠르게 처리하였다.
- GoCD, Github Action 로 다양한 Workflow 활용
- 빌드 캐시를 공유하는 shared storage 를 공유
- Srping Boot Layered Jar, Docker BuildKit,
- Trace 분산 추적 시스템
  - traceId 기반이 아닌점
  - 로그 확인 어려움.
  - 샘플링 기반
- 로그 기반으로 추적을 할 수 있는 서비스를 구성
  - access log 기반으로 의존성 그래프를 구성
- Alerting

![[Toss Alert Message.png]]

- 문제를 빠르게 처리할 수 있는 링크를 분석해서 제공

## 은행 앱에도 Service Mesh 도입이 가능한가요?

- envoy filter 를 이용해서 보안, ip 접근 제어 등을 처리하고 있다. 
- istio 를 통해 인증을 위임
	- OIDC Service JWT 를 인증
	- bulk head 등, 서킷 브레이커를 활용
- istio 운영
	- host port 를 이용하고 있다. 홉을 줄이기 위해
	- egress gateway 
		- excludeOutboud 를 통해 직접 통하는 것도 제;어 
	- log
		- mixer disable
		- envoy access log 
			- disk io 에 따른 잠재적 이슈가 있다. 
			- grpc 를 통한 로그를 보내는 방식으로 수정
	- injection to cronjob 
	- istiod 튜닝