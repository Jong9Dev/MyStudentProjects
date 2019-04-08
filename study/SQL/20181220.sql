-- 서브쿼리
-- emp 테이블에서 allen의 연봉보다 높은 연봉을 받는 사람의 정보 출력
-- step1) allen의 연봉 확인
select sal
  from emp
 where ename='ALLEN'; -- 1600
 
-- step2) 위에서 확인한 연봉을 기준으로 쿼리 작성
select * 
  from emp
 where sal > 1600;
 
-- 위의 두 쿼리를 합치게 되면
select * 
  from emp
 where sal > (select sal
                from emp
               where ename='ALLEN');
 
-- 이름이 A로 시작하는 직원과 같은 부서 직원 출력
select deptno
  from emp
 where ename like 'A%';
 
select *
  from emp
 where deptno in (20,30);
 
select *
  from emp
 where deptno in (select deptno
                    from emp
                   where ename like 'A%'); 
 
-- 이름이 A로 시작하는 직원의 연봉보다 높은 직원 출력 
select sal
  from emp
 where ename like 'A%';
 
select *
  from emp
 where sal > min(1100,1600);  -- 1100과 1600중 최소를 선택하기 위해 min을 where절에 쓰면
                              -- 에러 발생(any와 all표현식으로 대체)
                              
select *
  from emp
 where sal > any(1100,1600);
 
> any(a,b) : a,b중 최소보다 큰
> all(a,b) : a,b중 최대보다 큰
< any(a,b) : a,b중 최대보다 작은
< all(a,b) : a,b중 최소보다 작은

 
select *
  from emp
 where sal > (select min(sal)
                from emp
               where ename like 'A%'); 

select *
  from emp
 where sal > any(select sal
                   from emp
                  where ename like 'A%'); 

-- 다중 행 서브쿼리의 연산자 대체
=   => in 
>,< => any, all 또는 서브쿼리 내의 min, max 함수의 사용

;

-- emp 테이블에서 부서별 최대 연봉자의 이름 조회
select deptno, max(sal), ename?????(X)
  from emp
 group by deptno;

--sol1) inline view
select e.ENAME, e.DEPTNO, e.SAL
  from emp e, (select deptno, max(sal) AS max_sal
                 from emp
                group by deptno) i
 where e.DEPTNO = i.deptno
   and e.SAL    = i.max_sal;

--sol2) multi column sub query
select *
  from emp
 where deptno in (select deptno
                   from emp
                  group by deptno)
   and sal in (select max(sal)
                from emp
               group by deptno);               
                  
select *
  from emp
 where sal in (select max(sal)
                from emp
               group by deptno); 


select *
  from emp
 where (deptno,sal) in (select deptno, max(sal)
                          from emp
                         group by deptno); 

 
-- STUDENT 테이블에서 각 학년별로 몸무게가 가장 많이 나가는 학생의 이름, 학년, 몸무게 출력
--sol1) inline view
select NAME, s.GRADE, WEIGHT
  from STUDENT s, (select grade, max(WEIGHT) AS max_weight
                     from STUDENT
                    group by grade) i
 where s.GRADE = i.grade
   and s.WEIGHT = i.max_weight;
 
--sol2) multi column sub-query
select NAME, GRADE, WEIGHT
  from STUDENT 
 where (grade, WEIGHT) in (select grade, max(WEIGHT) AS max_weight
                             from STUDENT
                            group by grade);
 
-- STUDENT 테이블에서 각 학년별로 평균 몸무게보다 많이 나가는 
-- 학생의 이름, 학년, 몸무게 출력
select NAME, s.GRADE, WEIGHT, avg_weight
  from STUDENT s, (select grade, avg(WEIGHT) AS avg_weight
                     from STUDENT
                    group by grade) i
 where s.GRADE  = i.grade
   and s.WEIGHT > i.avg_weight;
   
select NAME, GRADE, WEIGHT
  from STUDENT 
 where (grade, WEIGHT) > (select grade, max(WEIGHT) AS max_weight
                             from STUDENT
                            group by grade);   -- 불가

--sol3) 상호연관 서브쿼리(그룹별 대소비교 가능) 
select NAME, GRADE, WEIGHT
  from STUDENT s1
 where WEIGHT > (select avg(WEIGHT) AS avg_weight
                   from STUDENT s2
                  where s1.grade = s2.grade 
                  group by grade); -- 생략가능  
       


-- 스칼라 서브쿼리 : select절에 서브쿼리를 사용하여 하나의 컬럼처럼 사용하기 위한 목적
-- 조인의 대체 표현식으로도 자주 사용된다

-- emp 테이블과 dept 테이블을 사용하여 각 직원의 이름, 부서번호, 부서명 출력
-- sol1) 조인
select e.ename, e.DEPTNO, d.DNAME
  from emp e, dept d
 where e.DEPTNO = d.DEPTNO;
 
-- sol2) 스칼라 서브쿼리
select e.ename, e.DEPTNO, (select d.DNAME
                             from dept d
                            where e.DEPTNO = d.DEPTNO)              
  from emp e; 

-- emp 테이블에서 각 직원의 이름과 매니저의 이름 출력
select e1.ename, (select e2.ename
                    from emp e2
                   where e1.mgr = e2.empno) AS 매니저명
  from emp e1;




   
 

