package com.aop.logger;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

//클래스에 @Aspect 어노테이션을 추가하여 Aspect를 생성한다. 
//@Aspect 설정이 되어 있는 경우 Spring은 자동적으로 @Aspect 어노테이션을 포함한 클래스를 검색하여 Spring AOP 설정에 반영한다.
@Aspect
public class TestLogger {
	
	/*
	 * 포인트컷은 결합점(Join points)을 지정하여  (Advice)가 언제 실행될지를 지정하는데 사용된다. 
	 * Spring AOP는 Spring 빈에 대한 메소드 실행 결합점만을 지원하므로, 
	 * Spring에서 포인트컷은 "빈의 메소드 실행점"을 지정하는 것으로 생각할 수 있다.
	 */
	@Pointcut("execution(public * com.spring.Controller.*.*(..))")
	public void targetMethod() {}


	/*
	 *  beforeTargetMethod() 메소드는 targetMethod()로 정의된 포인트컷 전에 수행된다.
	 */
	@Before("targetMethod()")
	public void beforeTargetMethod(JoinPoint thisJoinPoint) {
		Class clazz = thisJoinPoint.getTarget().getClass();
		String className = thisJoinPoint.getTarget().getClass().getSimpleName();
		String methodName = thisJoinPoint.getSignature().getName();
		System.out.println("AspectUsingAnnotation.beforeTargetMethod executed.");
		System.out.println(className + "." + methodName + " executed.");
	}

	/*
	 * afterReturningTargetMethod()  는 targetMethod()로 정의된 포인트컷 후에 수행된다. 
	 * targetMethod() 포인트컷의 실행 결과는 retVal 변수에 저장되어 전달된다.
	 */
	@AfterReturning(pointcut = "targetMethod()", returning = "retVal")
	public void afterReturningTargetMethod(JoinPoint thisJoinPoint, Object retVal) {

		System.out.println("AspectUsingAnnotation.afterReturningTargetMethod executed." + 
				" return value is [" + retVal + "]");

	}

	/*
	 * afterThrowingTargetMethod()  는 targetMethod()로 정의된 포인트컷에서 예외가 발생한 후에 수행된다. 
	 * targetMethod() 포인트컷에서 발생된 예외는 exception 변수에 저장되어 전달된다.
	 */
	@AfterThrowing(pointcut = "targetMethod()", throwing = "exception")
	public void afterThrowingTargetMethod(JoinPoint thisJoinPoint,
			Exception exception) throws Exception {
		System.out.println("AspectUsingAnnotation.afterThrowingTargetMethod executed.");
		System.out.println("에러가 발생했습니다. : "+ exception);
	}

	/*
	 * 메소드 수행 후 무조건 수행된다. After (finally)  는 @After 어노테이션을 사용한다. 
	 * After  는 정상 종료와 예외 발생 경우를 모두 처리해야 하는 경우에 사용된다. 
	 * 리소스 해제와 같은 작업이 해당된다.
	 */
	@After("targetMethod()")
	public void afterTargetMethod(JoinPoint thisJoinPoint) {
		System.out.println("AspectUsingAnnotation.afterTargetMethod executed.");
	}

	/*
	 * aroundTargetMethod()  는 파라미터로 ProceedingJoinPoint을 전달하며 
	 * proceed() 메소드 호출을 통해 대상 포인트컷을 실행한다. 
	 * 포인트컷 수행 결과값인 retVal을 Around   내에서 변환하여 반환할 수 있음을 보여준다.
	 */
	@Around("targetMethod()")
	public Object aroundTargetMethod(ProceedingJoinPoint thisJoinPoint)	throws Throwable {
		System.out.println("AspectUsingAnnotation.aroundTargetMethod start.");
		long time1 = System.currentTimeMillis();
		Object retVal2 = thisJoinPoint.proceed();

		System.out.println("ProceedingJoinPoint executed. return value is [" + retVal2 + "]");

		Object retVal = retVal2 + "(modified)";
		System.out.println("return value modified to [" + retVal + "]");

		long time2 = System.currentTimeMillis();
		System.out.println("AspectUsingAnnotation.aroundTargetMethod end. Time(" + (time2 - time1) + ")");
		return retVal2;
	}

}