---
tags: kotlin
categories: Book
---

## 1부 좋은 코드

### 1장 안정성

````

#### 가변성을 제한하라.

- var 보다는 val
- mutable 보다는 immutable
- 컬렉션에 상태를 저장한다면 immutable
- 변이 지점을 설계하고 불필요한 변이지점을 만들지 말자.
  - 가변성은 동시성제어부터, 추적의 어려움 등을 통해 side effect 를 유발할 수 있다.

#### 변수의 스코프를 최소화 하라.

- 초기화를 함께 진행하고 여러 값을 설정할 때에는 구조분해를 통해서 할 수 있다.

```kotlin
val (description, color) = when {
	degrees < 5 -> "color" to Color.BLUE
    degrees < 23 -> "mild" to Color.YELLOW
    else -> "hot" to Color.RED
}

````

#### 최대한 플랫폼 타입을 사용하지 말라

- 자바 코드와 코틀린 코드를 함께 사용할 경우, @NotNull @Nullable 을 추가하자.
- 다른 프로그래밍 언어에서 와서 nullable 여부를 판단할 수 없는 타입을 플랫폼 타입
- 이런 경우 타입 추론을 자제하자.

```kotlin
// java

public class JavaClass {
    public String getValue() {
	    return null;
    }
}

// kotlin
fun statedType() {
	val value:String = JavaClass().value // NPE
}

fun platformType() {
	val value:String = JavaClass().value // NPE

	print(value.length) // NPE
}

```

#### inferred 타입으로 리턴하지 말라

- 특히 외부 API 를 제공할 때에는 타입을 명시화 하자. (예측 못한결과가 나올 수 있다.)

#### 예외를 활용해 코드에 제한을 걸어라.

- required 는 IllegalArgumentException 를 던진다.
- check 는 IllegalStatueException 을 던진다.
- assert 는 -ea JVM 옵션을 활성해야 확인할 수 있다.
- smart cast 를 이용할 수 있다.

```kotlin
// before
repo.findById(id!!)

// after
requireNotNull(id)
repo.findById(id)
```

- 함수 중지 케이스

```kotlin
val email = persion.email ?: return

val email:String = person.email ?: run {
   log("Email not sent, no email address")
   return
}

```

#### 결과 부족이 발생할 경우 null 과 Failure 를 활용하라.

- 추가적인 내용을 전달한다면, sealed class 인 Result 를 활용하고, 아닌 경우에는 null 을 활용하라.
- nullable 보다는 명시적으로 `getOrNull` 을 사용하라.  (==type 에서 이미 표시하는 데 이게 더 나은 방식인지는 의문==)

#### null 을 안전하게 처리하기

- !! 보다는 명시적인 check, 또는 require 가 더 많은 정보를 전달한다.
- [detekt | kotlin 정적 검사 도구](https://github.com/detekt/detekt)  (어떤 팀은 !! 자체를 rule 로 관리해서 build 시에 실패를 할 수 있다.)
- 라이프사이클에 따라 초기화가 진행될 시에는 lateinit 을 사용하고 nullable 은 지양하자
- 기본형 Int, Double 에서는 `by Delegates.nonNull()` 를 사용하자.

#### use method 를 통해서 리소스를 안전하게 종료하자.

### 2장 가독성

#### 가독성을 목표로 설계하라.

- 코드를 작성하는 데는 1분 걸리지만, 이를 읽는 데는 10분이 걸린다.

초보자도 이해할 수 있는 A가 더 가독성이 좋은 코드이다.

```kotlin
// A
if (person != null && person.isAduit) {
	view.showPerson(person)
} else {
	view.showError()
}

// B
person?.takeIf { it.isAduit }
	?.let(view::showPerson) 
	?: view.showError()
```

- let 을 연산을 아규먼트 처리한 후에 이동시킬 때
- 데코레이터를 사용해서 객체를 랩할 때

```kotlin

var obj = FileInputStream("/file.gz")
	.let(::BufferedInputStream)
	.let(::ZipInputStream)
	.let(::OBjectInputStream)
	.readObject() as SomeObject

```

#### 연산자 오버로드를 할 때는 의미에 맞게 사용하라.

- 연산자 오버로딩은 맥락에 맞게 사용하자.
- 연산자 오버로딩 이전에 이항 연산자를 먼저 고려하자.

```kotlin
infix fun Int.timeRepeated(operation: () -> Unit) = {
    repeat(this) { operation() }
}

3.timeRepeated { print("hello")}

// 위의 내용은 기존 stdlib 에 있으니 아래와 같은 형태가 더 적절

repeat(3) { println("hello")}

```

#### Unit? 을 리턴하지 말자.

- Boolean 을 리턴하자. nullable 를 통해 분기보다는 명시적인 것을 사용

```kotlin

// getData() 가 null 이 아니고, view.showData(it) 리턴값이 null 이면 view.showError() 도 함께 호출한다.

getData()?.let { veiw.showData(it) } ?: view.showError()

```

#### 변수타입이 명확하지 않을 경우 확실하게 지정하라.

github 에서 관련 소스를 볼 수 도 있으니, 명시적으로 타입을 선언하자.

```kotlin

val a = "test" // ok, 누구든지 추론이 가능하다.
val data = someData() // not ok, 명시적이지 않다.

```

#### 리시버를 명시적으로 참조하라.

- nullable 이면 let 이나 also 를 사용하자  this?.someThing() 보다는 it?.someThing()

```kotlin

class Node(val name:String) {


	fun makeChild(childName: String) = 
		create("$name.$childName").apply {
			print("Created ${this?.name} in ${this@Node.name}")
		}
	}

	fun create(name:String): Node? = Node(name)
}

```

- @DslMarker 를 통해 암묵적으로 외부 리시버를 사용하는 금지시킬 수 있다. (이것은 관련 작업이 있다면 공부해보자)

  ```
    									#### 프로퍼티는 동작이 아니라 상태를 나타내야 한다.
  ```

- 프로퍼티 get() 에는 알고리즘을 넣지 말자. 기대하는 동작이 다르다.
  - 복잡도가 0(1) 보다 높으면 X, 예측이 가능하고 이를 기반으로 캐싱을 검토할 수 있게 한다.
  - 멱등성이 깨지는 경우
  - 단순 동작 이상을 기대하지 않는다.
  - get() 에서는 상태 변경이 일어나는 걸 기대하지 않는다.

#### 이름 있는 아규먼트를 사용하라.

- 가급적이면 모든 파라미터에 이름있는 아규먼트를 사용하자.

```kotlin

val text = (1..100).joinToString(separator = "|")

// 또는
val separaotr = "|"
val text = (1..100).joinToString(separator)
```

- 함수 타입 파라미터는 가장 마지막에 붙인다.

#### 코딩 컨벤션을 지켜라

- [pinterrest/ktlint](https://github.com/pinterest/ktlint)

### 3장 재사용성

#### knowledge 를 반복하여 사용하지 말라.

- 함께 변경될 가능성이 있는가? 따로 변경될 가능성이 높은가?
- 단일책임원칙
- private 함수는 두 가지 이상의 역할을 하지 않는다.

#### 일반적인 알고리즘을 반복해서 구현하지 말라.

```kotlin

fun saveCallResult(item: SourceResponse) {
	val sourceEntries = item.sources.map(::sourceToEntity)
	db.insertSources(sourceEntries)
}

private fun sourceToEntity(source: Source) = SourceEntity().apply {
	id = source.id
	category = source.category
	country = source.country
	description = source.description
}

```

#### 일반적인 프로퍼티 패턴은 프로퍼티 위임으로 만들어라.

- 범용적으로 사용하는 델리게이터
  - lazy
  - Delegates.obserable
  - Delegates.vetoable
  - Delegates.notNull
  - map

#### 제네릭 타입과 variance 한정자를 활용하라.

- TBD

#### 공통 모듈을 추출해서 여러 플랫폼에서 재사용하라.

- 코틀린 백엔드 프레임워크 ktor 도 점점 많이 사용할 수 있다.
- 프론트 엔드를 코틀린으로 만들 수 있다. 코틀린/js
- 코틀린 네이티브를 통해서  LLVM 사용하여 네이티브 코드로 컴파일 가능하다.

### 4장 추상화

#### 함수 내부의 추상화 레벨을 통일하라

- SLA: Single Level Abstraction : 함수의 추상화 레벨이 동일해야 한다.
- 함수는 최소한의 책임만 가져야 한다.
- 문제 중심으로 프로그래밍을 한다.

#### 변화로부터 코드를 보호하려면 추상화를 사용하라.

- listOf는 코틀린/jvm, 코틀린/js, 코틀린/네이티브에 따라 다른 구현을 리턴한다.
- 상수로 추출한다.
- 동작을 함수로 래핑한다.
- 함수를 클래스로 래핑한다.
- 인터페이스 뒤에 클래스를 숨긴다. ex) MessageDisplay, ToastMessageDisplay
- 보편적인 객체를 특수한 객체로 래핑한다.

**추상화의 단점:**

- 추상화는 예제 없이는 이해가 어렵기 때문에 단위테스트 또는 문서를 꼭 만들자.
- FizzBuzz Enterprise Edition, 간단한 프로그램을 과도한 추상화로 인해 복잡도가 증가하는 예제

#### API 안정성을 확인하라.

- major 버전이 0 일때는 언제든지 변경할 여지가 있다.
- 해당 버전이 안정적이지 않다면 Experimental 메타 어노테이션을 붙이자.

```kotlin

@Experimental(level = Experimental.Level.WARNING)
annotation class ExperimentalNewAPI

@ExperimentalNewAPI
suspend fun getUsers(): List<User> {

}
```

- 안정적인 API 를 Deprecated 한다면 ReplaceWith 를 함께 사용하자. (IDE 에서 인식한다.)

```kotlin

@Deprecated("Use suspending getUsers instead", ReplaceWith("getUsers()"))
fun getUsers(callback: (List<User>) -> Unit)

```

#### 외부 API 를 랩(Wrap) 해서 사용하라.

- 문제의 소지가 있다면 wrap 해서 사용하자.
- 라이브러리가 안정적인지는 버전과 얼마나 사용하는 지이다.

#### 요소의 가시성을 최소화 하라.

- 가시성이 제한될 수록 문제를 쉽게 추적할 수 있다.
- 동시성을 처리할 때도 상태변경은 문제가 될 수 있다.  많은 것들을 제한할 수록 병렬 프로그래밍에 대해 안전해 진다.
- 패키지와 모듈은 의미가 다르다. internal 은 같은 모듈내에 가시성을 제공

#### 문서의 규약을 정의하라

- 클린코드 관점으로 작성한다.

```kotlin
// bad case

fun update() {

	// 사용자를 업데이트 합니다. 
	for (user in users) {
		user.update()
	}

	// 책을 업데이트 합니다. 
	for (book in books) {
		updateBook(book)
	}
}

// 좋은 예제, 추상화 레벨도 통일됨

fun update() {
	updateUsers()
	updateBooks()
}
```

- kdoc
  - 첫번째 줄은 summary
  - 두번째 줄은 상세 설명
  - 이어지는 줄은 모두 태그
- 코틀린 공식 문서 생성 도구는 Dokka
- 짧으면서 명확하지 않는 부분을 자세하게 설명하는 문서가 좋은 문서

#### 추상화 규약을 지켜라

### 5장 객체 생성

#### 생성자 대신 팩토리 함수를 사용하라.

- 팩토리 메소드가 직관적이며, 구현을 숨길 수 있다.
- 캐싱, 내부적으로 싱글턴을 유지할 수 있다.
- 가시성을 제어할 수 있다.
- 복잡한 객체를 생성할 수 있다.
- 코틀린에서는 기본 생성자와는 대체제(자바인 경우)가 아니라 경쟁적인 관계이다.

**코틀린에서 팩토리: Companion 객체 팩토리 함수**

- A.from : 하나의 파라미터인 경우, 같은 타입을 리턴 ex) Date.from
- A.of : 여러 파라미터를 조합해서 만드는 경우 ex) EnumSet.of(JACK, QUEEN)
- A.valueOf: value 를 통해, 의미를 좀더 부여 ex) BigInteger.valueOf
- A.getInstance: 싱글턴
- A.createInstance or A.newInstance : 새로운 인스턴스
- A.getType: 다른 타입을 생성, 싱글턴 ex) Files.getFileStore(path)
- A.newType: 다른 타입을 새롭게 생성 ex) Files.newBufferedReader(path)
- companion의 특징
  - 상속, 인터페이스 구현이 가능하다.

**코틀린에서 팩토리: 확장 팩토리 함수**

- Companion 객체가 존재할 때 확장함수를 사용가능하다.

```kotlin
interface Tool {
	companion object {
	}
}

fun Tool.Companion.createBigTool(): BigTool {

}

Tool.createBigTool
```

**코틀린에서 팩토리: 톱레벨 팩토리 함수**

- ex) listOf

**코틀린에서 팩토리:  가짜 생성자 (fake constructor)**

```kotlin
List(4) { "User$it"}

public inline fun <T> List(
	size:Int,
	init: (index: Int) -> T
): List<T> = MutableList(size, init)
```

- 인터페이스를 위한 생성자를 만들고 싶을 때
- reified 타입 아규먼트를 갖게 하고 싶을 때,

#### 기본 생성자에 이름 있는 옵션 아규먼트를 사용하라.

- 점증적 생성자 패턴은 자바에서는 유용하지만, kotlin 에서는 default argument 를 통해서 해결한다.
- 코드를 github 에 올렸을 때에도 가독성 있을 수 있도록 작성하자.
- 빌더패턴을 이용하기 보다는 코틀린 DSL빌더를 사용하자.
- 코틀린은 빌더를 거의 사용하지 않는다.
  - 다른 언어로 작성된 라이브러리를 그대로 옮길 때

#### 복잡한 객체를 생성하기 위한 DSL 을 정의하라.

- 복잡한 자료구조를 생성할 때
- 계층적인 구조를 생성할 때
- 거대한 양의 데이터를 생성할 때
- 간단한 자료구조를 만들 때 사용하는 것은 닭 잡는 곳에 소 잡는 칼을 쓰는 것.

### 6장 클래스 설계

#### 상속보다는 컴포지션을 사용하라.

- 상속은 슈퍼클래스의 모든 것을 가져온다. 따라서 기본적으로는 위임으로 처리하자.
- 일부분만 재사용하기에는 상속은 적합하지 않는다.
- 컴포지션이 좀 더 안전하다. 관찰되는 동작에서만 의존하기 때문

```kotlin

class Progress {
	fun showProgress() {}
	fun hideProgress() {}
}

class ProfileLoader() {
	val progress = Progress()

	fun load() {
		progress.showProgress()
		// logic
		progress.hideProgress()
	}
}
```

- 리스코프 치환 법칙을 위반하는 사례가 발생할 수 있다.

```kotlin

class Labrador: Dog()

class RobotDog: Dog() {
	override fun sniff() {
		throw Error("Operation not supported") // 인터페이스 분리 원칙에 위배
	}
}
```

- 위임패턴

```kotlin
class CounterSet<T>(
	private val innerSet: MutableSet<T> = mutableSetOf()
): MutableSet<T> by innerSet

```

- open class 에서는 open 클래스만 오버라이드 할 수 있다.
- 상속을 사용 시에는 상위 클래스의 테스트를 하위클래스에서 모두 통과 할 수 있어야 한다.
- 상속을 위해 설계 되지 않는 메소드는 final 로 정의하자.

#### 데이터 집합 표현에 data 한정자를 사용하라.

- data class 해체 시에는 생성자에 정의한 property 이름과 동일하게 사용하자.
- 튜플(Pair) 보다는 데이터 클래스를 사용하는 게 더 명확하다.

#### 연산 또는 액션을 전달할 때는 인터페이스 대신 함수 타입을 사용하라.

- 함수 레퍼런스를 전달할 수 있다.
- 선언된 함수 타입을 구현한 객체로도 전달 가능

```kotlin

fun setOnClickListener(listener: (view:View) -> Unit) {

}


// or 
class ClickListener: (View) -> Unit {
	override fun invoke(view: View) {
		// do something
	}
}

fun doSomething() {
	setOnClickListener(ClickListener())
	setOnClieckListener(::println)
}

```

- 언제 SAM(Single Abstract Method) 을 사용할까?
  - 자바에서 사용해야 하는 경우에는 SAM 을 사용한다. (함수 타입은 IDE 에서 지원받을 수 없다.)

#### 태그  클래스 보다는 클래스 계층을 사용하라

- 상수를 모아 둔 클래스를 태그 클래스
  - 프로퍼티가 일관적으로 사용하지 않는 케이스가 발생한다.
  - 여러 목적으로 사용할 소지가 있다.
  - ==sealed class 를 사용하자. (외부에서 서브클래스를 만드는 행위를 제한할 수 있다. 즉 타입이 추가되지 않을 것이라는 보장)==
- 상태 클래스
  - 각 상태에 따라서 행위를 규정한다.

#### equals 의 규약을 지켜라.

- 구조적 동등성: `==, !=`
- 레퍼런스적 동등성: `===, !==`  를 통해 같은 객체를 가리키는 지
- data class 에서 생성자에 포함되지 않는 프로퍼티는:
  - equals 에 포함되지 않는다.
  - copy 에 포함되지 않는다.
- equals 의 규약
  - 반사적: x 가 null 이 아니면 x.equals(x) 는 참
  - 대칭적: x, y 가 null 이 아니면 x.equals(y) == y.equals(x)
    - 다른 타입을 검사하는 경우 실수가 생길 수 있다.
  - 연속적: x, y 가 equals 이고, y, z 가 equals 이면 x.equals(y) 도 같은 결과
    - ex) DateTime 과 Date 를 비교하는 경우
  - 일관적: 여러번 동작해도
  - x.equals(null) 은 항상 false 를 리턴해야 한다.
  - URL 의 equals 는 잘못된 설계
    - 네트워크 상태에 따라서 실패가 야기된다.
    - equals 의 실행이 느려질 수 있다.

#### hashcode 의 규약의 지켜라.

- 여러번 호출해도 동일 값
- equals 가 true 이면 hashcode 도 동일값
- 최대한 값을 넓게 퍼트려야 hashtable의 성능이 괜찮아 진다.
  - hashcode 를 먼저 호출 후에 equals 를 호출한다.
- equals 와 동일한 프로퍼티로 hashcode 를 구현해야 한다.

#### compareTo 의 규약을 지켜라

- 비대칭적인 동작: a>=b, b>=a 라면 a == b
- 연속적 동작: a>=b, b>=c 이면 a>=c
- 코넥스적 동작: a>=b, b>=a 이면 적어도 둘 중 하나는 true
- 자주 사용하는  여러 프로퍼티의 순서를 정해야 한다면

```kotlin

class User(val name:String, val surname:String) {
	companion object {
		val DISPLAY_ORDER = compareBy(User::usrname, User::name)
	}

}

val sorted = names.sortedWith(User.DISPLAY_ORDER)
```

- compareTo 구현할 때
  - compareValues 를 이용 : 단순 비교 시
  - compareValuesBy 를 이용: 좀 더 복잡한 경우

#### API 의 필수적이지 않는 부분을 확장함수로 추출하라.

- 확장 함수는 오버라이드가 불가능하다.
- 확장 함수는 어노테이션 프로세서가 처리하지 않는다.

#### 멤버 확장 함수의 사용을 피하라.

- 확장함수를 클래스 내부에 사용하지 말라.  (가시성을 제한하지 못한다.)
- 맴버 확장함수는 레퍼런스를 지원하지 않는다. ex) str::isPhoneNumber
- 확장 함수는 혼란을 야기할 여지가 있어 가시성 한정자를 사용하는 것을 고려하자.

### 7장 비용 줄이기

#### 뷸필요한 객체 생성을 피하라

- Int? 를 사용하면 Integer 로 컴파일 된다.  Int 는 - int
- 64bit 에서는 8 byte 의 배수만큼 공간을 차지
- 12 byte 헤더가 있어 최소 16 byte 를 차지한다.
- 64bit -Xmx 32G 부터는 8 Byte 레퍼런스 공간, 이전까지는 레퍼런스는 4 Byte
- [Java Object Layout](https://www.baeldung.com/java-memory-layout) 를 통해 class 의 메모리 layout 를 손쉽게 알 수 있다.
  - memory optimization 시에 재미 있게 사용할 수 있을 듯.
- Empty 클래스(특정 상태를 나타내는)를 생성하지 말고 재활용하자.

```kotlin

sealed class LinkedList<out T>

object Empty : LinkedList<Nothing>

class Node<out T>(
	val head T,
	va tail : LinkedList<T>
) : LinkedList<T>

val list: LinkedList<Int> = Node(1, Node(2, Node(3, Empty)))
```

- 캐시 활용

```kotlin
private val FIB_CACHE = mutableMapOf(Int, BigInteger)() 

fun fib(n: Int): BigInteger = FIB_CACHE.getOrPut(n) {
	if (n <= 1) BigInteger.ONE else fib(n-1) + fib(n-2)
}
```

- 캐시를 통해 처리할 때 메모리가 부담이 된다면
- SoftReference 를 사용하자. (gc 에서 대상일 수도 아닐 수도 있다.)  [예제 바로 가기](https://github.com/Mauker1/CacheMap/blob/master/CacheMap.kt)
- 무거운 객체 연산은 밖으로 빼자.
  - 가장 많이 실수하는 부분이 Rex 연산을 매번 생성하는 행위 등

```kotlin
private val IS_VALID_EMAIL_ADDRESS by lazy {
   "\\A..example".toRegex()
}
```

- 성능이 중요하다면 가급적이면 기본 타입을 통해 연산하라.

```kotlin
public fun <T: Compareable<T>> Interable<T>.max(): T? {
	val iterator = iterator()
	if (!iterator.hasNext()) return null. // 빠른 리턴, 엘비스 연산자를 지양하고 이렇게 처리
	val max = iterator.next()
	while(iterator.hasNext) {
		val e = iterator.next()
		if (max < e) max = e
	}

	return max
	
}

```

#### 함수 타입 파라미터를 갖는 함수에 inline  한정자를 붙여라

- reified 한정자를 붙여서 사용할 수 있다.
- 훨씬 빠르다.
- 비지역 리턴을 사용할 수 있다.
- 간단한 함수에는 inline 이 붙어 있다.
  - 함수를 호출하는 비용
  - argument 를 래핑해서 사용해야 하는 비용
- 단점
  - 재귀에서 사용하지 못한다.
  - 코드의 크기가 늘어날 수 있다.
- intellij 가 알아서 아래의 상황을 추천해준다.
  - crossinline: 비지역적 리턴 불가
  - noinline : 인라인 불가

#### 인라인 클래스의 사용을 고려하라.

- compile 시점에 대체되어 오버헤드가 없다.
- inline class 의 함수는 static 으로 컴파일 된다.
- 타입을 강제할 때, 타입을 통해 가독성을 높일 때
- interface 를 구현하는 inline class 는 소용이 없다.
- typealias 는 반복적으로 사용해아 하는 함수타입일 때 유용하다.

```kotlin
inline class Minutes(val minutes: Int) {
	fun toMillis(): Millis = Millis(minutes * 60 * 1000)
}

inline class Millis(val milliseconds) {

}

interface User {
	fun decideAboutTime(): Minutes
}

val Int.min get() = Minutes(this)

typealias ClickLinstener = (view: View, event:Event) -> Unit

class View {
	fun addClickListener(listener: ClickListener) {}
	fun removeClickListener(listener: ClickListener) {}
}

// typealias 는 안전하지 않다. 
typealias Seconds = Int
typealias Millis = Int

val seconds: Seconds = 10
val millis: Millis = seconds // 컴파일 오류가 나지 않는다. 

```

#### 더 이상 사용하지 않는 객체의 레퍼런스를 제거하라.

- lazy 시에 initializer 함수 타입을 사용 후에 null로 사용한다.
- SoftReference 를 사용한다.
- WeakReference 를 사용한다.
- 힙 프로파일러를 사용하자.
- 톱레벨 프로퍼티나 companion object 에는 용량이 큰 변수를 사용하지 않는다.

### 8장 효율적인 컬렉션 처리

#### 하나 이상의 처리 단계를 가지는 경우에는 시퀀스를 사용하라

- 자연스러운 처리순서를 유지한다.
- 최소한의 연산
- 무한 시퀀스 형태로 사용할 수 있다.
- 각각의 단계에서 컬렉션을 만들어 내지 않는다.
- iterator 는 eager order, sequence 는 lazy order

```kotlin
val fibonacci = sequence {
	yield(1)
	var current = 1
	var prev = 1
	while(true) {
		yield(current)
		val temp = prev
		prev = current
		current += temp
	}
}

fibonacci.take(10).toList()
```

- 무한 시퀀스는 무한루프에 빠지는 경우가 많으니, take 와 first 정도의 용도로만 사용하자.
- 무한시퀀스에서는 sorted 를 조심히 사용해야 한다.
- 자바 스트림과의 차이점
  - 자바스트림은 병렬 처리가 가능하다.
  - 코틀린이 확장함수가 많아 사용하기 편하다.

#### 컬렉션 처리 단계 수를 제한하라.

list 는 기본적으로 중간연산마다 객체를 새롭게 생성하기 때문에 단계를 줄이는 것이 효율적이다.
가급적이면 sequence 를 사용하자.

- filterNotNull,
- mapNotNull,
- filter { a && b},
- filterIsInstance

#### 성능이 중요한 부분에는 기본 자료형을 사용하라.

- 1,000,000 인 정수 일때 약 5배 차이가 난다.
	- header 12바이트, lenth 4byte 로 16바이트 추가
	- IntArray 는 4,000,016 바이트
	- `List<Int>` 는 2,0,006,944 바이트
```kotlin

import jdk.nashorn.internal.ir.debug.ObjectSizeCalculator


fun main() {
    val ints = List(1_000_000) { it }
    val array: Array<Int> = ints.toTypedArray()
    val intArray: IntArray = ints.toIntArray()
    println(getObjectSize(ints))     // 20 000 040
    println(getObjectSize(array))    // 20 000 016
    println(getObjectSize(intArray)) //  4 000 016

```

#### mutable 컬렉션 사용을 고려하라. 

- immutable 은 모든 연산에서 새로운 객체를 생성한다. 
- 지역변수는 mutable 을 고려하자.