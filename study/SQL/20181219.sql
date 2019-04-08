-- non-equi join

-- GOGAK테이블과 GIFT테이블을 사용하여 각 고객의 포인트별로
-- 받아갈 수 있는 가장 좋은 상품명 출력
select g1.GNAME AS 고객명, g2.GNAME AS 상품명
  from GOGAK g1, GIFT g2
 where g1.POINT between g2.G_START and g2.G_END;

-- GOGAK테이블과 GIFT테이블을 사용하여 각 고객의 포인트별로
-- 받아갈 수 있는 모든 상품명 출력
select g1.GNAME AS 고객명, g2.GNAME AS 상품명
  from GOGAK g1, GIFT g2
 where g1.POINT >= g2.G_START
 order by 1;
 
-- GOGAK테이블과 GIFT테이블을 사용하여 각 상품별 최대 기대 수량 출력 
select count(g1.GNAME) AS 상품수, g2.GNAME AS 상품명
  from GOGAK g1, GIFT g2
 where g1.POINT >= g2.G_START
 group by g2.GNAME
 order by g2.GNAME;

select s.STUDNO, s.NAME, s.GRADE, e.TOTAL, h.GRADE
  from STUDENT s, EXAM_01 e, HAKJUM h
 where s.STUDNO = e.STUDNO
   and e.TOTAL between h.MIN_POINT and h.MAX_POINT;
 
select p.NAME, count(s.NAME)
  from PROFESSOR p, STUDENT s
 where p.PROFNO = s.PROFNO(+)
 group by p.NAME 
 order by 2;

select ENAME,JOB,SAL, d.DNAME 
from emp e, dept d
where e.DEPTNO = d.DEPTNO;

select e1.ENAME AS 이름, e1.sal AS 연봉,
       e2.ENAME AS 상위관리자명 , e2.SAL AS 상위관리자연봉
  from emp e1, emp e2
 where e1.MGR = e2.EMPNO(+) 
   and e1.sal > e2.sal;

-- PROFESSOR 테이블을 사용하여 각 교수의 이름, 입사일, 
-- 각 교수보다 먼저 입사한 교수의 이름과 입사일을 출력
select p1.NAME AS 이름, p1.HIREDATE AS 입사일,
       p2.NAME AS 선배이름, p2.HIREDATE AS 선배입사일
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE(+) 
 order by 1;

-- 위의 정보를 사용하여 각 교수별로 먼저 입사한 교수(선배교수)의 수를 
-- 교수 이름과 함께 출력
select p1.NAME AS 이름, p1.HIREDATE,
       count(p2.NAME) AS 선배수
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE (+)
 group by p1.NAME 
 order by 1;

-- 위의 데이터에 각 교수의 입사날짜 추가
select p1.NAME AS 이름, p1.HIREDATE, p1.pay, p1.POSITION,
       count(p2.NAME) AS 선배수
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE (+)
 group by p1.PROFNO, p1.NAME , p1.HIREDATE, p1.pay, p1.POSITION
 order by 1;
 
-- 아우터 조인 시 주의사항 : 연결 테이블에 모두 표현
-- professor 테이블에서 같은 학과 내의 선배의 수를 출력
select p1.PROFNO, p1.NAME AS 이름, count(p2.NAME) AS 선배수
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE (+)
   and p1.DEPTNO = p2.DEPTNO(+)
 group by p1.PROFNO, p1.NAME
 order by 1;

-- STUDENT 테이블에서 각 학년별로 각 학생마다 본인보다 키가 큰 친구의 수를
-- 학생의 이름, 학번, 학년, 키와 함께 출력
select s1.NAME, s1.STUDNO, s1.GRADE, s1.HEIGHT,
       count(s2.NAME) AS 친구수
  from STUDENT s1, STUDENT s2
 where s1.GRADE = s2.GRADE(+)
   and s1.HEIGHT < s2.HEIGHT(+)
 group by s1.STUDNO, s1.NAME, s1.GRADE, s1.HEIGHT; 

-- emp 테이블에서 각 부서별 최대 연봉자 확인
select * from emp;

delete emp
 where EMPNO = 9999;
commit;

select e.ENAME, e.DEPTNO, e.SAL
  from emp e, (select deptno, max(sal) AS max_sal
                 from emp
                group by deptno) i
 where e.DEPTNO = i.deptno             
   and e.SAL    = i.max_sal;

-- 서브쿼리 : 메인쿼리 내 또 다른 쿼리
select col1, (select ...)  -- 스칼라 서브쿼리 : 하나의 컬럼처럼 사용
  from (select ...)        -- 인라인 뷰 : 하나의 테이블처럼 사용
 where col = (select ...)  -- 일반 서브쿼리 : 하나의 변수(상수)처럼 사용






