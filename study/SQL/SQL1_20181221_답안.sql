--1) dept2 테이블을 이용하여 상위부서명을 다음과 같이 출력하세요.
-- "경영지원부의 상위부서는 사장실 입니다."
-- 단, 상위부서가 없는 경우는 본인부서명이 출력되도록 하여라.
--(스칼라 서브쿼리 이용)
select d1.DNAME||'의 상위부서는 '|| 
       nvl((select d2.DNAME from dept2 d2 where d1.PDEPT = d2.DCODE),
            d1.DNAME)||' 입니다'
  from dept2 d1;
 
--2) emp 테이블을 이용하여 부서에서 본인보다 입사년도가 빠른 사람의 수를 각 직원의 이름, 
-- 부서명과 함께 출력하세요. 단, 선배수가 많은 사람 순으로 정렬하세요
--2-1) 조인
select e1.ename, d.DNAME, count(e2.ename) AS 선배수
  from emp e1, emp e2, DEPT d
 where e1.DEPTNO = e2.DEPTNO(+)
   and to_char(e1.hiredate,'YYYY') > to_char(e2.hiredate(+),'YYYY')
   and e1.DEPTNO = d.DEPTNO
 group by e1.ename, d.DNAME  
 order by 선배수 desc;

--2-2) 스칼라 서브쿼리
select e1.ename
     , (select d.DNAME from DEPT d where e1.DEPTNO = d.DEPTNO)
     , e2.ename AS 선배수
  from emp e1, emp e2
 where e1.DEPTNO = e2.DEPTNO(+)
   and to_char(e1.hiredate,'YYYY') > to_char(e2.hiredate(+),'YYYY') 
 order by 선배수 desc;

select e1.ename, d.DNAME, 
       (select count(e2.ename) 
          from emp e2
         where e1.DEPTNO = e2.DEPTNO(+)
           and to_char(e1.hiredate,'YYYY') > to_char(e2.hiredate(+),'YYYY')) AS 선배수        
  from emp e1, DEPT d
  where e1.DEPTNO = d.DEPTNO
  order by 선배수 desc;
 
--3) emp 테이블을 이용하여 본인과 상위관리자의 평균연봉보다 많은 연봉을 받는 직원의
--이름, 부서명, 연봉, 상위관리자명을 출력하여라.
select e1.ename, e1.sal, d.DNAME, e2.ENAME
  from emp e1, emp e2, DEPT d
 where e1.MGR = e2.EMPNO
   and e1.sal > (e2.SAL + e1.sal)/2
   and e1.DEPTNO = d.DEPTNO
 ;
  
--4) 교수에 대한 전체 자료를 다음과 같은 형식으로 만들어 보자
--(단, 모든 교수들에 대해 출력되도록 한다)
--교수이름	지도학생수	지도학생_성적평균	A_학점자수	B_학점자수	C_학점자수	D_학점자수
--심슨          	2	        79	                1	        0	        0	        1
--허은	            2	        83	                0	        1	        1	        0
--조인형	        1	        97	                1	        0	        0	        0

--P-S-E-H

select p.NAME , 
       count(s.NAME), avg(e.TOTAL), 
       count(decode(substr(h.GRADE,1,1),'A',1)),
       count(decode(substr(h.GRADE,1,1),'B',1)),
       count(decode(substr(h.GRADE,1,1),'C',1)),
       count(decode(substr(h.GRADE,1,1),'D',1))
  from PROFESSOR p,
       STUDENT s,
       EXAM_01 e,
       HAKJUM h
 where p.PROFNO = s.PROFNO(+)
   and s.STUDNO = e.STUDNO(+)
   and e.TOTAL between h.MIN_POINT(+) and h.MAX_POINT(+)
 group by p.NAME  
 order by 1;

