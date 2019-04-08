--1) EMP테이블과 dept 테이블, p_grade 테이블을 이용하여 각 직원의 이름, 부서명, 
--기존직급과 새로운 직급을 나타태어라.
--단, 새로운 직급은 근속년수를 기준으로 계산한다;
select e.ENAME, e.DEPTNO, e.JOB, trunc((sysdate - hiredate)/365) AS 근속년수,
       p.POSITION, d.DNAME
  from emp e, P_GRADE p, DEPT d
 where trunc((sysdate - e.hiredate)/365) between p.S_YEAR and p.E_YEAR
   and e.DEPTNO = d.DEPTNO;

--2) student, exam_01, hakjum 각 학생의 학점을 구하고 각 학점별로 분포된 학생 수를 다음과 같이 구하라.
--   A 4
--   B 12
--   C 3
--   D 1

select substr(h.GRADE,1,1) AS 학점, count(s.STUDNO) AS 학생수
  from STUDENT s, EXAM_01 e, HAKJUM h
 where s.STUDNO = e.STUDNO
   and e.TOTAL between h.MIN_POINT and h.MAX_POINT
 group by substr(h.GRADE,1,1);
   
--3) student 테이블과 exam_01, department 테이블을 이용하여 각 학과별 평균 점수와 최고 점수,
--최저 점수를 나타내되 학과이름, 학과번호와 함께 출력되도록 작성하여라.
select d.DNAME, s.DEPTNO1, avg(e.TOTAL), max(e.TOTAL), min(e.TOTAL)
  from student s, exam_01 e, department d
 where s.STUDNO = e.STUDNO
   and s.DEPTNO1 = d.DEPTNO
 group by d.DNAME, s.DEPTNO1;

--4) student, professor 테이블에서 같은지역, 같은 성별의 친구가 몇명인지 구하고, 
--그 학생의 담당 교수이름도 함께 출력되도록 하여라.
--단, 같은지역, 같은 성별에 본인은 포함될 수 없다.
select s1.NAME, p.NAME, count(s2.STUDNO)
  from STUDENT s1, STUDENT s2, PROFESSOR p
 where substr(s1.JUMIN,7,1) = substr(s2.JUMIN(+),7,1)
   and substr(s1.TEL,1,instr(s1.tel,')')-1) = substr(s2.TEL(+),1,instr(s2.tel(+),')')-1)
   and s1.STUDNO != s2.STUDNO(+)
   and s1.PROFNO = p.PROFNO(+)
 group by s1.NAME, p.NAME  
 order by 1;

s1 - s2(+)
|
p(+)
;

s1 - s2(+) - p(+)
;

--5) student, exam_01, department 테이블에서 각 학생의 시험성적을 기반으로 
--같은학과에서 본인보다 시험성적이 우수한 학생수를 나타내도록 하여라.
--단, 각 학생의 정보는 학생이름, 학과이름, 시험성적과 함께 출력하여라.
--(아우터조인은 고려하지 않는다)
select s1.NAME, s1.DEPTNO1, e1.TOTAL, d.DNAME,
       count(s2.STUDNO)
  from STUDENT s1, EXAM_01 e1, 
       STUDENT s2, EXAM_01 e2, 
       DEPARTMENT d
 where s1.STUDNO = e1.STUDNO 
   and s2.STUDNO = e2.STUDNO
   and s1.DEPTNO1 = s2.DEPTNO1
   and e1.TOTAL < e2.TOTAL(+)       -- *************
   and s1.DEPTNO1 = d.DEPTNO
 group by s1.NAME, s1.DEPTNO1, e1.TOTAL, d.DNAME  
 order by 1;
 
d(+)
|
s1(+) - e1(+)
|        |
s2(+) - e2(+)


d
|
s1e1 - s2e2(+)

;


select i1.NAME, i1.DEPTNO1, i1.TOTAL,
       count(i2.NAME)
  from (select s.NAME, s.DEPTNO1, e.TOTAL
          from STUDENT s, EXAM_01 e
         where s.STUDNO = e.STUDNO) i1,
       (select s.NAME, s.DEPTNO1, e.TOTAL
          from STUDENT s, EXAM_01 e
         where s.STUDNO = e.STUDNO) i2
  where i1.deptno1 = i2.deptno1(+)
    and i1.total   < i2.total(+) 
  group by i1.NAME, i1.DEPTNO1, i1.TOTAL;

-- ** 드래그 후 cttl + l : 드래그 영역만 일부 실행






