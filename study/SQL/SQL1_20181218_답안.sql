--1) Student 테이블의 jumin 컬럼을 참조하여 학생들의 이름과 태어난 달, 그리고 분기를 출력하라.
--태어난 달이 01-03월 은 1/4분기, 04-06월은 2/4 분기, 
--07-09 월은 3/4 분기, 10-12월은 4/4 분기로 출력하라 (decode,case모두)
select to_char(to_date(substr(jumin,1,6),'RRMMDD')
               ,'Q')||'/4분기' AS 분기1,
       decode(to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q'),'1','1/4분기',
                                                               '2','2/4분기',
                                                               '3','3/4분기',
                                                                   '4/4분기') AS 분기2,
       case to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q') when '1' then '1/4분기'
                                                             when '2' then '2/4분기'
                                                             when '3' then '3/4분기'
                                                                      else '4/4분기'
        end AS 분기3
  from STUDENT;
  
--2) EMP2 테이블에서 출생년도(1960,1970,1980,1990)별로 평균연봉을 구하라.
select trunc(to_char(BIRTHDAY,'YYYY'),-1) AS 출생년도,
       round(avg(pay))
  from EMP2
 group by trunc(to_char(BIRTHDAY,'YYYY'),-1) ;
  
--3) emp 테이블에서 인상된 연봉을 기준으로 2000 미만은 'C',
--2000이상 4000미만은 'B', 4000이상은 'A' 등급을 부여하여 각 직원의 현재 연봉과 함께 출력
--**인상된 연봉은 기존 연봉 대비 15% 상승률 + 보너스(comm)
select ename, sal, comm, sal*1.15 + nvl(comm,0),
       case when sal*1.15 + nvl(comm,0) < 2000 then 'C'
            when sal*1.15 + nvl(comm,0) < 4000 then 'B'
                                               else 'A'
        end AS grade
  from emp;
  
--4) studet 테이블과 EXAM_01 테이블을 사용하여
--각 학년별 평균 시험성적을 출력하여라
select s.GRADE, avg(e.TOTAL)
  from STUDENT s, EXAM_01 e
 where s.STUDNO = e.STUDNO
group by grade;
  
--5) 레포트를 작성하고자 한다.
--emp 테이블을 이용하여 각 부서별 직원수를 출력하되 다음과 같은 형식으로 작성하여라.
--
--레포트명	       10_직원수	 20_직원수	  30_학생수
----------------------------------------------------------
--본인이름 레포트	        3	         5           6
select '홍은혜 레포트' AS 레포트명,
        count(case when deptno = 10 then 1 end) AS "10_직원수",
        count(case when deptno = 20 then 1 end) AS "20_직원수",
        count(case when deptno = 30 then 1 end) AS "30_직원수"
  from emp;
 
 