-- 집합 연산자 : 두 데이터 셋의 합집합, 교집합, 차집합 연산
-- select 와 select 사이에 집합 연산자 나열

--1. 합집합
-- union : 교집합은 한 번만 출력, 중복된 값을 제거하기 위해 내부적으로 정렬 수행
-- union all : 교집합 전체 출력
-- union 과 union all의 결과가 동일하다면(교집합 없음) union all을 사용하여 
-- 불필요한 정렬 방지
select ename, deptno, sal
  from emp
 where deptno = 10
 union
select ename, deptno, 1000
  from emp
 where deptno = 20; 

select ename, deptno
  from emp
 where sal > 2000
 union all
select ename, deptno
  from emp
 where deptno = 10
;

--2. 교집합
select ename, deptno
  from emp
 where sal > 2000
intersect
select ename, deptno
  from emp
 where deptno = 10;

--3. 차집합
select ename, deptno
  from emp
 where sal > 2000
 minus
select ename, deptno
  from emp
 where deptno = 10;
