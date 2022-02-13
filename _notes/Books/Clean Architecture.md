---
tags: book,architecture
categories: Book
---

훌륭한 아키텍처는 유지보수를 위한 인력투입이 적어진다. 이는 곧 경영학적인 관점에서도 이득이라 볼 수 있다.

아키텍처가 후순위가 되면 시스템을 개발하는 비용이 더 많이 들고, 일부 또는 전체 시스템에 변경을 가하는 일이 현실적으로 불가능해진다. 이러한 상황이 발생하도록 용납했다면, 이는 결국 소프트웨어 개발팀이 스스로 옮다고 믿는 가치를 위해 충분히 투쟁하지 않았다는 뜻이다.

OO 에 대한 핵심은 캡슐화, 상속, 다형성이다. 이 중 캡슐화와 상속은 절차지향 언어에서도 충분히 가능한 기능이다. 그러나 다형성은 함수포인터를 바꾸는 방식의 기존 언어의 불편함을 해소하였고, 제어흐름의 역전과 고수준, 저수준 모듈의 변경에 따른 배포독립성을 보장하였다.

[![](https://lh3.googleusercontent.com/pw/ACtC-3fl4P4d6QUxqk4iNMeEg9ZTgx6R7Md2ZgOP22jmyqM8l2c_OrHswqCbzSHKsycpuC2Dh-o14HJKlmvJMjJmtA7jIyF1_jEv7lcuvo_UIm0Vycem4KYcOx0aK6rIOzkZwHuFTHSf5Aar78Qh0yc4Z-9N=w700-h514-no?authuser=0)]

**Table of Contents**

- [[#SOLID|SOLID]]
	- [[#SRP (Single Responsible Principle)|SRP (Single Responsible Principle)]]
	- [[#OCP (Open-Close Principle)|OCP (Open-Close Principle)]]
	- [[#LSP (Liskov substitution Principle)|LSP (Liskov substitution Principle)]]
	- [[#ISP (Interface Separation Principle)|ISP (Interface Separation Principle)]]
	- [[#DIP (Dependency Inversion Principle)|DIP (Dependency Inversion Principle)]]
- [[#컴포넌트|컴포넌트]]
- [[#References|References]]
## 의존 규칙

위 그림은 소프트웨어의 각각 다른 영역을 나타내고 있는데, 바깥쪽의 레이어를 메커니즘(Mechanism)이라 하고, 안쪽의 레이어는 정책(Policy)이다.

클린 아키텍처를 기능하게 하는 가장 중요한 규칙이 의존 규칙인데, 이 규칙에 의해 **소스 코드는 안쪽 레이어를 향해서만 의존**할 수 있다. 즉, 안쪽의 레이어는 바깥쪽에 레이어에 대해 전혀 모른다. 따라서 바깥쪽의 레이어에서 선언된 어떠한 이름도 참조할 수 없다. 이는 함수, 클래스, 변수 등 이름이 붙은 소프트웨어의 엔티티 모든 것에서 해당된다.

### SOLID

#### SRP (Single Responsible Principle)

- 하나의 모듈은 하나의, 오직 하나의 액터에 대해서만 책임을 져야 한다.

#### OCP (Open-Close Principle)

- transitive dependency

#### LSP (Liskov substitution Principle)

- 하위 클래스로 변경했을 때의 문제, downcasting

#### ISP (Interface Separation Principle)

#### DIP (Dependency Inversion Principle)

- 믿어도 되는 구상클래스는 의존해도 된다.
- 소스코드 흐름과 제어 흐름과는 반대
  - 소스코드는 추상클래스 의존
  - 실제 제어 흐름은 구상클래스에 의해 실행

### 컴포넌트

- REP : 재사용 / 릴리즈 등가 원칙 Reuse / Release Equivalence Principle
- CCP : 공통 폐쇄 원칙 (Common Closure Principle)
- CRP : 공통 재사용 원칙 (Common Reuse Principle)
- 컴포넌트는 의존성은 비순환방향그래프여야 한다.
- I = fan out / (fan in + fan out)
- I 는 낮은 방향으로 의존성을 가져야 한다.
- 안정적인 상태의 컴포넌트는 I 가 0에 가까운 상태

# References

- [주니어 개발자의 클린 아키텍처 맛보기](https://techblog.woowahan.com/2647/)
- [The Clean Code Blog](http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Hexagonal Architecture with Java and Spring](https://reflectoring.io/spring-hexagonal/)
	- https://github.com/thombergs/buckpal
- [클린 아키텍처에 대해 아라보자](https://velog.io/@ssionii/%ED%81%B4%EB%A6%B0-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98%EC%97%90-%EB%8C%80%ED%95%B4-%EC%95%84%EB%9D%BC%EB%B3%B4%EC%9E%90)
