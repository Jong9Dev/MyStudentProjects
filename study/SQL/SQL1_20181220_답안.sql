--1) professor 테이블에서 각 학과별 최소연봉을 갖는 교수의 이름, 학과이름, pay를 출력하세요.
--인라인뷰)
select p.NAME, d.DNAME, p.PAY
  from PROFESSOR p, department d, (select deptno, min(pay) AS min_pay
                                     from PROFESSOR
                                    group by deptno) i
 where p.DEPTNO = i.deptno
   and p.pay    = i.min_pay
   and p.DEPTNO = d.DEPTNO;
 
--다중컬럼)
select p.NAME, d.DNAME, p.PAY
  from PROFESSOR p, department d
 where p.DEPTNO = d.DEPTNO
   and (p.deptno, p.PAY) in (select deptno, min(pay) AS min_pay
                               from PROFESSOR
                              group by deptno);
                              
--상호연관)
select p.NAME, d.DNAME, p.PAY
  from PROFESSOR p, department d
 where p.DEPTNO = d.DEPTNO
   and p.PAY = (select min(pay) AS min_pay
                  from PROFESSOR i
                 where p.DEPTNO = i.deptno);

--2) emp, dept 테이블을 사용하여 각 부서별 최고연봉자의 이름, 부서명, 연봉을 구하고  
--상위관리자와 상위관리자의 연봉도 함께 나타내도록 하여라.
select e.ENAME, d.DNAME, e.SAL, s.ENAME, s.SAL
  from emp e, 
       dept d,
       emp s,
       (select deptno, max(sal) max_sal
          from emp
         group by deptno) i
 where e.DEPTNO = i.deptno
   and e.sal    = i.max_sal
   and e.DEPTNO = d.DEPTNO
   and e.MGR    = s.EMPNO(+);

 s
 |
 e - i   
 |
 d
 ;
--3) STUDENT, EXAM_01 테이블을 사용하여 학년별 평균점수를 구하고 
--각 학년별 평균점수보다 낮은 점수를 갖는 학생의 이름, 학번, 점수를 출력하세요.
select *
  from (select s.NAME, s.GRADE, s.STUDNO, e.TOTAL
          from STUDENT s, EXAM_01 e
         where s.STUDNO = e.STUDNO) i1,
        (select s.GRADE, avg(e.TOTAL) as total
           from STUDENT s, EXAM_01 e
          where s.STUDNO = e.STUDNO
          group by s.GRADE) i2
  where i1.grade = i2.grade
    and i1.total < i2.total ;

--4) professor, DEPARTMENT 테이블에서 입사년도(1980,1990,2000년대)별 평균연봉보다 
--높은 연봉을 받는 교수의 이름, 학과명, 연봉, 지도학생 수를 출력하여라.
--(마음대로)
select p.NAME, d.DNAME, p.PAY, p.PROFNO, count(s.STUDNO)
  from PROFESSOR p,
       DEPARTMENT d,
       STUDENT s,
       (select trunc(to_char(hiredate,'YYYY'),-1) AS hiredate, avg(pay) avg_pay
          from PROFESSOR p
         group by trunc(to_char(hiredate,'YYYY'),-1)) i    
 where trunc(to_char(p.hiredate,'YYYY'),-1) = i.hiredate
   and p.PAY > i.avg_pay
   and p.DEPTNO = d.DEPTNO
   and p.PROFNO = s.PROFNO(+)
 group by p.NAME, d.DNAME, p.PAY, p.PROFNO  
 order by 1;

s
|
p - i
|
d

;
