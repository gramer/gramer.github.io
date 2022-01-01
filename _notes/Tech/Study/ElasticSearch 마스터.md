---
tags: study
title: ElasticSearch 마스터
categories: ["Study","ElasticSearch"]
---

**Table of Contents**

- [[#강의 관련|강의 관련]]
- [[#환경 설정|환경 설정]]
- [[#Lucene 이란|Lucene 이란]]
- [[#ElasticSearch 입학식|ElasticSearch 입학식]]
  - [[#cluster|cluster]]
  - [[#kibana|kibana]]
  - [[#logstash|logstash]]
- [[#ElasticSearch 기본과정|ElasticSearch 기본과정]]
  - [[#Components|Components]]
- [[#ElasticSearch 심화과정|ElasticSearch 심화과정]]
  - [[#index module|index module]]
  - [[#index module (analyer)|index module (analyer)]]

# 강의 관련

- [강의 자료](https://drive.google.com/drive/folders/1z17SrDtdaWF3PA6qS8r_2gD4q3pX7-5-)

# 환경 설정

[다운로드 사이트](https://www.elastic.co/kr/downloads/)
[homebrew 를 이용한 설치](https://www.elastic.co/guide/en/elasticsearch/reference/7.15/brew.html)

# Lucene 이란

- lucene 의 서브프로젝트 Solr
- Inverted Index Structure
- Index 는 하나의 IndexWriter 로 구성
- IndexSearcher -> IndexWriter -> IndexReader
- Segment 마다 LeafReader 가 있다.

# ElasticSearch 입학식

jdk 가 포함된 버전과 아닌 버전이 있다.
jdk 가 포함되지 않은 버전은 향후 제공되지 않음

```bash
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.1-darwin-x86_64.tar.gz
```

```bash
# binary
bin/elasticsearch
bin/elasticsearch -d -p PID

# docker
docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.15.1
```

## cluster

기본적으로 cluster name 을 통해 클러스터에 join 한다.

```bash
❯ curl http://localhost:9200/_cat/nodes\?format\=json\&pretty
[
  {
    "ip" : "127.0.0.1",
    "heap.percent" : "3",
    "ram.percent" : "100",
    "cpu" : "11",
    "load_1m" : "4.56",
    "load_5m" : null,
    "load_15m" : null,
    "node.role" : "dm",
    "master" : "-",
    "name" : "es1"
  },
  {
    "ip" : "127.0.0.1",
    "heap.percent" : "3",
    "ram.percent" : "100",
    "cpu" : "11",
    "load_1m" : "4.56",
    "load_5m" : null,
    "load_15m" : null,
    "node.role" : "dm",
    "master" : "-",
    "name" : "es1"
  },
  {
    "ip" : "127.0.0.1",
    "heap.percent" : "3",
    "ram.percent" : "100",
    "cpu" : "11",
    "load_1m" : "4.56",
    "load_5m" : null,
    "load_15m" : null,
    "node.role" : "dm",
    "master" : "*",
    "name" : "es2"
  }
]

```

![[ES_cat_nodes.png]]
가급적 설정은 명시적으로

## kibana

## logstash

```bash
# test
./bin/logstash -e 'input { stdin {} } output { stdout {} }'
```

# ElasticSearch 기본과정

elasticsearch.yml

- cluster.name 은 중복되지 않도록
- node.name 은 역할에 따라 가독성 좋게, master-01, master-02  등으로 직관적으로

node 의 역할

- master: cluster 에 대한 상태
  - quarum 구성 추천
- data: 색인 및 저장, 검색, 분석
- data_content:
- data_hot|warm|cold|frozen
- ingest: master, data 와 같이 사용하지 않을 것
- ml: 머신러닝 노드
- remote_cluster_client: 크로스 클러스터 서치
- transform: 트랜스폼 인덱스로 색인 (데이터 마트), daily -> weekly 로 저장
- voting_only: master 중에 마스터 선출로만 사용
- 추가적으로: coordinating_node, node.roles 에 선언을 하지 않는다면
  - search, 또는 bulk indexing, 검색 결과를 aggregation, 정렬

각 티어별 서버 스펙은 동일하게 가져간다.
80% 이상 디스크 사용시 워터마크를 띄운다. --> 알람을 받아야

노드의 절반의 메모리를 사용
http.compression: true 로 설정하기를 추천
http.compression_level 은 기본값 3으로 사용하기를 추천

gateway.expected_data_nodes: 클러스터 재시작 시에 최소 확인 되는 노드 수

## Components

- Cluster
  - cluster.name, cluster.initial_master_node, discovery.type
- Node:
  - node.roles, node.name
  - data, coordinating 은 cpu 와 mem 에 대한 자원을 충분히
- Index:
  - 물리적은 shard, data node 에만 존재
  - ILM 을 통한 용량에 따른 롤링 가능
- Shard:
  - 물리적 단위, shard.allocation awareness 를 통한 위치 조정
  - health 는 shard 의 상태 (Primary 가 할당되지않을 때,  RED)
  - Primary 는 색인 성능에 영향, 코어 크기 등 고려
  - Replica 는 검색 성능에 영향, 동적 크기 조정 가능
  - index.number_of_shards, index.number_of_replicas

# ElasticSearch 심화과정

- Setting 의 우선순위가 있다.
- Index Scope
  - 설정은 static, dynamic 속성을 가지고 있다.
- NodeScope  (_cluster/_settings)
  - 일회성, 영구 설정을 할 수 있다.
  -
- heap size 는 보통 50%, 최대 31GB X
  - ES_JAVA_OPTS 를 사용해도 된다.
- SLM(Snapshot Lifecycle Management)
- CircuitBreakerSettings (과도한 요청이나, 메모리 사용 차단)
  - Parent circuit breaker : 전체 heap size 에 대한 total limit
  - Field Data
  - Request : Aggregation 과 같은
- cluser level shard allocation and routing settings
  - exclude 설정 테스트
  - cluster-level
  - disk-based
  - awareness
  - cluster-level filter
- shard rebalance 적용
  - 노드당 샤드 1000개
- disk based shard
  - watermark.low 가 85%가 되면 더이상 샤드가 할당되지 않음, replica 만 적용
  - watermark.high 90%
  - cluster.info.update.interval 30s
- awareness
  - rack_id, attributes, force
- indices.queries.cache.size (기본은 heap의 10%)
  - 세그먼트가 머지 되면 유효하지 않는다.
  - hit율이 낮다면 segment 머지가 빈번히 일어나는지를 체크

주요시스템 설정

- swap disable
- bootstrap check
- system 자원 제한

## index module

- closed index 에는 설정을 변경하지 않는다.
- 같은 노드에 primary, replica 가 기본적으로는 할당이 되지 않는다.
- 이렇게 최대갯수를 제한할 수 있다. (ES_JAVA_OPTS="-Des.index.max_number_of_shards=128)
- Static settings
  - codec : 압축
  - hidden
- Dynamic settings
  - index.number_of_replicas : 트래픽이 적은 시간에
  - index.refresh_interval : bulk 색인 시 -1
    - refresh 에 신규 segment 가 생성
  - index.max_result_window
- (실습) scroll, search after 기능

## index module (analyer)

- 하나의 tokenazer 와 여러 개의 token filter

```shell
$ bin/elasticsearch-plugin install analysis-nori 
$ bin/elasticsearch-plugin remove analysis-nor
```

Nori Analyzer

- index allocation filter settings
- delayed allocation : 기본 1분으로 재시작 시에 rebalancing 으로 인한 부하로 인해
- index.routing.allocation.total_shards
- node.attr 을 통해서 할당, _tier, _tier_preference 를 통해 
- merging
	- SSD 인 경우에는 계산에 의해서, SSD가 아니면 1
- slowlog 는 dynamic settings 으로 설정 가능
- translog 
	- flush 라는 작업을 통해서 루씬 커밋 및 신규 트랜스 로그 생성
- sorting
- pressure
	- coordinating : primary 샤드를 찾는 작업 (hashing 을)