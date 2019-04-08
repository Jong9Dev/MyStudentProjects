select * 
  from emp
 where HIREDATE between '1982/01/01' and '1982/12/31' ;
 
select * 
  from emp
 where HIREDATE like '82%' ;
 

-- order by를 사용한 정렬
-- student 테이블에서 grade가 작은순으로 정렬
select * 
  from student
 order by grade;

-- student 테이블에서 grade가 작은순, 같은 학년내에선 생년월일이 느린순으로 정렬
select * 
  from student
 order by grade, BIRTHDAY DESC;

-- studnet 테이블에서 학번이 작은순으로 정렬하고 학번이 같을 경우 학년순으로 정렬
select * 
  from student
 order by studno, grade;

-- 문자함수의 사용 : 대소 치환
select ename,
       initcap(ename),
       lower(ename),
       upper(ename)
  from emp;

select ename, sal
  from emp
 where lower(ename) = 'smith';
 
select ename, sal
  from emp
 order by lower(ename);

select * from STUDENT;

-- substr(원본문자열 혹은 컬럼, 시작위치, 추출개수)
-- 시작위치 < 0 : 뒤에서부터 추출
-- 추출개수 생략 시 끝까지 추출

select name, 
       substr(name,1,1) AS 성,
       substr(name,2,2) AS 이름1,
       substr(name,2) AS 이름2
  from student;

-- student 테이블에서 각 학생의 이름, 성별 출력(1 또는 2)
select name, substr(jumin,7,1) AS 성별
  from student;

-- student 테이블에서 여학생 정보만 출력
select name, substr(jumin,7,1) AS 성별
  from student
 where substr(jumin,7,1) = 2;

select name, substr(jumin,7,1) AS 성별
  from student
 order by 성별;
 
 
-- student 테이블에서 TEL컬럼의 마지막 네자리 전화번호만 추출

select tel,
       substr(tel,9) AS "4자리 전화번호1",
       substr(tel,-4,4) AS "4자리 전화번호2"
  from student;

select 'abcdefg', substr('abcdefg',-4,2)  
  from dual;

select sysdate, 20||substr(sysdate,1,2) AS year,
       substr(sysdate,4,2) AS month,
       substr(sysdate,7,2) AS day   
  from dual;

-- student 테이블의 TEL 컬럼을 사용하여 각 학생의 지역번호 추출
select tel, substr(tel,1,3) AS 지역번호 
  from student;
  
--instr(추출 문자열 또는 컬럼, 찾고자하는 문자열, 시작위치, 반복번호)
select 'ab@cd@ef',
       instr('ab@cd@ef','@',1,1) AS "첫 번째 발견되는 @의 위치",
       instr('ab@cd@ef','@',1,2) AS "두 번째 발견되는 @의 위치"
  from dual;     
  
-- substr과 instr을 사용하여 각 학생의 지역번호만 추출
select *
  from student;






  