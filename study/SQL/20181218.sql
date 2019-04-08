--if A = 1 then 'a'
--   A = 2 then 'b'
--   A = 3 then 'c'
--         else 'd'

decode(A,1,'a',
         2,'b',
         3,'c',
           'd')
           
case when A > 1 then 'a'         
     when B = 2 then 'b'
     when A = 3 then 'c'
                else 'd'
 end       
 
;

--조건문 예제
--emp 테이블에서 부서번호가 10이면 총무부, 20이면 인사부, 30이면 재무부
select deptno, decode(DEPTNO, 10,'총무부',20,'인사부','재무부') AS 부서이름 
  from emp;
 
select deptno, case when DEPTNO = 10 then '총무부'
                    when DEPTNO = 20 then '인사부'
                                     else '재무부'
                end AS 부서이름 
  from emp; 
 
select deptno, case DEPTNO when 10 then '총무부'
                           when 20 then '인사부'
                                   else '재무부'
                end AS 부서이름 
  from emp;  
 
--if A = 1 and B = 1 then 'a'
--         and B = 2 then 'b'
--   A = 3 then 'c'
--         else 'd'
 
decode(A,1,decode(B,1,'a','b'),
         3,'c',
           'd') 
 
case when A = 1 and B = 1 then 'a'
     when A = 1 and B = 2 then 'b'
     when A = 3 then 'c'
                else 'd' 
 end
;
 
-- 이중분기 조건문 예제
-- PROFESSOR 테이블에서 교수 후보를 뽑는데
-- 101번 부서에서 정교수만이 교수 후보가 될 수 있다
-- 교수 후보 여부를 출력
 
select DEPTNO, POSITION,
       decode(DEPTNO,101,decode(POSITION,'정교수','교수 후보'))
  from PROFESSOR;
 
 
-- STUDENT 테이블을 사용하여 각 학생의 이름, 학번, 성별 출력
select name, studno, jumin,
       decode(substr(jumin,7,1),'1','남자','여자') AS 성별
  from STUDENT;
 
-- emp 테이블에서 sal 기준으로 각 직원의 등급 산정(기준 아래) 
-- 0 ~ 2000 : A
-- 2000 ~ : B
select ename, sal,
       case when sal < 2000 then 'A'
                            else 'B'
        end AS grade,
       sign(sal - 2000),
       decode(sign(sal - 2000), -1 ,'A','B')
  from emp;
  
select count(*), count(ename), count(sal), count(comm)  
  from emp;
  
select avg(comm), sum(comm) / count(*), avg(nvl(comm,0)), ename
  from emp;
  
select deptno, job, avg(sal)
  from EMP
 group by deptno, job;
  
select deptno, max(sal)
  from emp
 group by deptno ;

select substr(jumin,7,1), avg(weight) 
  from STUDENT
 group by substr(jumin,7,1);

select grade, avg(height)
  from STUDENT
 where avg(height) >= 170 
 group by grade;
 
select grade, avg(height)
  from STUDENT
 group by grade
having grade != 2;
  
select grade, avg(height)
  from STUDENT
 where grade != 2
 group by grade
;

--[ 실습 ] 
--
--문제1) emp 테이블을 이용하여 각 부서별로 사원수, 최대연봉, 최소연봉, 
--         평균연봉을 구하고 급여평균으로 정렬하여라.
select deptno, count(EMPNO), max(sal), min(sal), avg(sal)
  from emp
 group by deptno;

desc emp;
--문제2) emp 테이블을 이용하여 각 업무별로 사원수, 급여평균을 구하고 
--        업무별로 정렬하여라.
select job AS 업무, count(EMPNO), avg(sal) AS 급여평균
  from emp
 group by job
 order by 업무;

--문제3) emp 테이블을 이용하여 업무별(JOB), 부서별(DEPTNO)로 그룹화하여 
--         각각의 인원수와 급여평균을 구하고 급여평균이 많은 순으로 정렬하여라.
select job, deptno, count(EMPNO), avg(sal) AS 급여평균
  from emp
 group by job, deptno
 order by 급여평균 desc;

--문제4) EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 
--         급여의 합을 출력하여라.
select deptno, count(ename), sum(sal)
  from emp
 group by deptno
having count(ename) > 4;
  
--문제5) EMP 테이블에서 업무별 급여의 평균이 3000 이상인 업무에 대해서 
--         업무명, 평균 급여, 급여의 합을 구하여라.
select job, avg(sal), sum(sal)
  from emp
 group by job
having avg(sal) >= 3000;




select s.name, p.name
  from STUDENT s, PROFESSOR p
 where s.PROFNO = p.PROFNO(+);

-- 카티시안 곱 발생(cross join)
select s.NAME, s.STUDNO, d.DNAME 
  from STUDENT s, DEPARTMENT d
 order by name; 

select s.NAME, s.STUDNO, d.DNAME 
  from STUDENT s, DEPARTMENT d
 where s.DEPTNO1 = d.DEPTNO
 order by name; 

-- STUDENT, DEPARTMENT, EXAM_01 테이블을 사용하여
-- 각 학생의 이름, 제1전공명, 시험점수를 출력
select s.NAME, d.DNAME, e.TOTAL
  from STUDENT s, DEPARTMENT d, EXAM_01 e
 where s.DEPTNO1 = d.DEPTNO
   and s.STUDNO = e.STUDNO;
   
 select * from EXAM_01  


