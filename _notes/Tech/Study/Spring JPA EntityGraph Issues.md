
## Generic 을 사용하는 경우

```java
@Transactional(readOnly = true)  
fun get(id: ID): E {  
    requireNotNull(id)  
    return repository.findById(id).orElse(null).also {  
 logger.info { "result of get by id($id): $it" }  
 }}

```
SimpleJpaRepository -> QueryHints -> getFetchGraphs -> CrudMethodMetadataPostProcessor

ReflectiveMethodInvocation 에서 한번 호출한 것은 repository 는 캐시를 한다. 
ReflectiveMethodInvocation 에서 대상 repository 가 아닌 CrudReposiitory 에서 @EntityGraph 를 찾는다. 
findById 만 그렇고, findAll 은 대상 Repository 를 가져온다. 

QueryHints.java 에서 size 는 맞지만 빈 값이 들어 있다.

```java
metadata.getQueryHintsForCount() = 0

result = {QueryHints[2]@21394} 
 0 = {MutableQueryHints@21374} 
  values = {LinkedMultiValueMap@21375}  size = 0
 1 = {MutableQueryHints@21396} 
  values = {LinkedMultiValueMap@21397}  size = 0
```