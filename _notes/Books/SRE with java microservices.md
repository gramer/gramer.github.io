---
tags: sre
categories: Book
---

## 머리말

시스템의 신뢰성을 고도화 시키는 동시에 우리의 노력이 수확체감(`diminishing return`) 영역에서 허비되지 않도록 방지

## Chapter1 어플리케이션 플랫폼

### 플랫폼 엔지니어링 문화

- 우리가 제공하는 것은 관문이 아니라 가드레일이다.
  - 통신 규약과 지원프레임워크를 산정하고 표준화 해야 한다.
- 교차 기능팀 (디자인, 백엔드, DB, 네트워크 등)
- 사례 (자유와 책임 문화)
  - 1차 접근:
    - 빌드 시에 문제에 대한 해결에 대한 warning 메시지를 보여주었지만, 도메인팀의 우선업무가 아니기 때문에 무시되었다.
  - 2차 접근:
    - 빌드 자동 수정 도구를 만들다. (사용자 입장에서 수락하기 용이)
    - 모니터링을 통해 수정이 안되는 팀은 직접 접근하여 협업한다.
  - Insignt: `개발자 경험에 대해서 깊은 공감을 가진다.`

### 모니터링

- SLO 는 상한과 하한을 가진다.
- SLA 를 위반할 위험이 생겼을 때 사전 경고 제공, 위반 상황까지 오지 않도록 한다.
- L-USE
  - Latency
  - Utilization
  - Saturation : 메모리, pool 리소스
  - Error

(!) 이 책에서는 cpu와 힙 사용률을 saturation 관점으로 보고 있다.

- 구글의 방식의 도입을 그대로 도입하기에는 과한 면이 있다. (SLO, 예러예산)
- 넷플릭스는 구글보다 덜 정형화 된 방식을 도입했다.
- [유어킷](https://www.yourkit.com/)
- 넷플릭스의 맥락과 가드레일, [Seeking SRE](http://www.yes24.com/Product/Goods/42773958)
  - 구글의 방식을 추구할 것인가, 넷플릭스 스타일 또는 다른 스타일을 따를 것인가?

### 다루지 않는 주제

- 테스트 커버리지 보다는 진화된 모니터링이 우선되어야 한다. (필자 왈)
- 조시롱의 말처럼 프로덕션과 동일한 환경은 존재하지 않는다.
- 테스트는 생각이 실현될 것임을 증명하고, 모니터링은 무엇이 실현되는 지 보여준다.
- 설정 분리
  - [Netflix Archaius](https://github.com/Netflix/archaius/wiki)

### 캡슐화

관문이 아닌 가드레일을 제공해야 한다면, 먼저 적용 후에 일반화를 진행한다.

- 명시적 runtime 종속성
  - spring 일 경우 Autoconfiguration 같은 방식
- 서비스 클라이언트 종속성
- 런타임 종속성 주입
  - 클라우드 파운드리 빌드팩팀이 적용한 방식

### 서비스 메시

- istio 의 한계를 극복하는 반향이 resilience4j 에 반영되었다. (bulkhead 등)

## Chapter2 애플리케이션 메트릭

- 화이트박스 모니터링: ex) micrometer
- 블랙박스 모니터링: ex) pinpoint aget
- 차원형과 계층형
  - 계층형은 계층 구조의 확장성에 있어 취약하다.
- 오픈텔레메트리는 메트릭은 기본 수준, 추적에 초점에 맞춰져 있다.
- ==CompositeMeterRegistry== 를 통해 여러 개의 지원하는 것도 가능
- StackDriverMeterResigtry?
- 특정 메트릭을 비활성화

```java
MetricRegistry registry = registry.config().meterFilter(MeterFilter.denyNameStartsWith("jvm.gc"))
```

- 메트릭 naming 은  마침표로 구분한다.
- NamingConvention 은 람다로 축약할 수 있으나, 예시를 알아보기 위해서?
- 메트릭 태그값 총량 제한
  - 404 인 경우에는 URI 를 NOT_FOUND 를 통해서 단일값으로 통일
  - 403 인 경우에는 URI 를 REDIRECTION
- 공통 태그
  - 어플리케이션 이름
  - 인스턴스 이름
  - 클러스터 서버 그룹명
  - 스택
  - Spring Cloud Config Server 를 통해서 동적으로 전달한다.

### 미터 클래스

게이지:

- SoftReference 를 유지하며 strongReference 를 유지하기 위해서는 별도의 설정이 필요하다.
- gaugeMapSize, gaugeCollectionSize 를 통해서 추적이 가능하다.
- MultiGate: 경계가 뚜렸하지만 영역이 조금씩 변하는 데이터

카운터:

- 처리량 등을 표시하여 시간 단위 별 변화량을 추적한다.

타이머:

- count, sum, maximum 을 기반으로 제공한다. 
- boundary, percentile, histogram 기반을 제공할 수 있다. 
- 평균의 평균은 오차가 있다. 
- _sum / _count 가 평균, 가급적이면 percentile 이 적합
- 최대값을 원형 버퍼에 두고 일정 시간 간격으로 폐기한다. 

==평균은 주로 현실을 무시할 때 사용된다.==

백분위수:

- 사전에 계산된 percentile 은 합쳐서 계산이 어렵다. 
- N 개의 개별 요청 중에 하나라도 1% 를 경험할 확률:
$$
(1-0.99^N) * 100\%
$$
- N 이 100 인 경우 
$$
(1-0.99^N) * 100\% = 63.3\%
$$
- MetricFilter 를 통해 percenttile,  histogram 등을 일괄적으로 설정할 수 있으며, springboot 같은 경우 설정을 통해 처리할 수 있다. 
- 힙 사이즈와 스토리지 비용을 고려해서 기본적으로 히스토그램은 비활성화 되어 있다.

**SLO:**

아래와 같이 Timer 에 SLO 를 추가하여 관리할 수 있다. 
MetricFilter 를 통해서 모든 Timer 에 추가도 가능하다. 
```kotlin 
Timer.builder("test").serviceLevelObjectives(Duration.ofSeconds(1))
```

**Summary:**

- 시간 단위가 아닌 값이며, 예제로 response.size 등을 처리
- 백분위 수, 히스토그램, SLO 설정이 모두 가능하다.


# References
- [Quick Guide to Micrometer](https://www.baeldung.com/micrometer)