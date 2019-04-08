select round(1.567,2), 
       round(123.567,-2)
  from dual;

select sign(10), sign(-10), sign(0)
  from dual;
  
 select sal, sign(sal - 2000)
   from emp; 
   
   
select sysdate,
       sysdate + 3 AS "3일 뒤",
       sysdate + 3*365 AS "3년 뒤",
       add_months(sysdate ,3) AS "3개월 뒤",
       add_months(sysdate ,-3) AS "3개월 이전"
  from dual;

select sysdate, hiredate, 
       trunc(sysdate - HIREDATE) AS "근무일수",
       trunc(trunc(sysdate - HIREDATE)/365) AS "근속년수",
       trunc(months_between(sysdate, HIREDATE)) AS "근무 개월 수"
  from emp;

alter session set nls_date_language='american';

select sysdate,
       next_day(sysdate,2), -- 숫자표현
       next_day(sysdate,'월') -- 한글 요일 표현,
       next_day(sysdate,'MON') -- 영문 요일 표현
  from dual;
       
select sysdate,
       round(sysdate,'day'),
       round(sysdate,'month')
  from dual;
  

--문제1) EMP 테이블에서 현재까지 근무일수가 몇 주, 몇 일인가를 출력하여라. 
--         단, 근무일수가 많은 사람 순으로 출력하여라.
select ename, 
       trunc(sysdate - hiredate) AS "근무 일수",
       trunc(trunc(sysdate - hiredate)/7) AS "근무 주 수",
       mod(trunc(sysdate - hiredate), 7) AS "나머지 근무 일 수"
  from emp
 order by "근무 일수" desc;
  
--문제2) EMP 테이블에서 10번 부서원의 현재까지의 근무 월수를 계산하여 
--         출력하여라. 
select ename, hiredate, trunc(months_between(sysdate,hiredate)) AS "근무 월 수"
  from emp
 where deptno = 10 ;
  
--문제3) EMP 테이블에서 입사한 달의 남은 근무 일수를 계산하여 출력하여라. 
--         단, 토요일과 일요일도 근무일수에 포함한다.
select hiredate, last_day(hiredate) - hiredate
  from emp;

--문제4) EMP 테이블에서 10번 부서원의 입사 일자로부터 돌아오는 금요일을 
--         계산하여 출력하여라.
select hiredate, next_day(hiredate,'FRI')
  from emp
 where deptno = 10 ;
  
select sal, to_char(sal, '9,999')
  from emp;



select sysdate,
       to_date(to_char(sysdate, 'YYYY-MM-DD'),'YYYY-MM-DD') + 1
  from dual;
  
select to_date('2018-12-17','YYYY-MM-DD') + 1,
       to_date('12/17/2018', 'MM/DD/YYYY')
  from dual;

select HIREDATE 
  from emp
 where to_char(hiredate,'MM') = '12' ;
 
desc emp ;

select BIRTHDAY , 
       to_char(BIRTHDAY,'MMDD'),
       to_char(BIRTHDAY,'DAY')
  from STUDENT;

-- 날짜의 포맷 변경 함수
-- to_char(날짜,'변경할 포맷) : 이미 날짜타입으로 인식된 데이터의 포맷 변경(문자형 리턴)
-- to_date(문자,'인식할 포맷') : 앞의 날짜처럼 생긴 문자 타입의 데이터를 날짜로 인식

-- 본인의 생년월일이 무슨 요일인지 확인
select to_char(to_date('19751023','YYYYMMDD'), 'DAY')
  from dual;
  
-- 날짜 포맷
select sysdate,
       to_char(sysdate,'MONTH'),  -- 월 fullname
       to_char(sysdate,'Month'), 
       to_char(sysdate,'Q'),      -- 분기
       to_char(sysdate,'DDTH'),   -- 날짜 서수(숫자)
       to_char(sysdate,'DDSPTH')  -- 날짜 서수(영문)
  from dual;

-- student 테이블의 jumin 컬럼을 사용하여 각 학생의 생년월일을 다음과 같은 포맷으로 변경
-- 751023  => 1975-10-23
select to_char(to_date(substr(jumin,1,6),'RRMMDD')
              ,'YYYY-MM-DD')
  from STUDENT;
  
-- student 테이블의 jumin 컬럼을 사용하여 각 학생의 생년월일을 다음과 같은 포맷으로 변경
-- 751023  => 1975년 10월 23일
select to_char(to_date(substr(jumin,1,6),'RRMMDD')
              ,'YYYY"년 "MM"월 "DD"일"')
  from STUDENT;

-- 묵시적 형 변환
select 1 + '100'  -- 아래와 같이 묵시적 형 변환이 일어남
  from dual;
  
select 1 + to_number('100')
  from dual;  

-- 문제3) february 22, 1982에 입사한 사원의 이름, 업무, 입사일자를 출력하여라.
select ename, hiredate, to_char(hiredate , 'month DD, YYYY')
  from emp
 where to_char(hiredate , 'month DD, YYYY') = 'february 22, 1982' ;
  
select ename, hiredate, to_char(hiredate , 'month DD, YYYY')
  from emp
 where hiredate = to_date('february 22, 1982','month DD, YYYY') ;  
 

select nvl(null,0)
  from dual;

select comm, nvl(comm,'보너스가 없다') -- comm 컬럼은 숫자이므로 nvl 결과 값도 숫자 컬럼
  from emp;                            -- 따라서 숫자 컬럼에 '보너스가 없다'라는 문자 
                                       -- 삽입 불가(아래와 같이 수정)
    
select comm, nvl(to_char(comm),'보너스가 없다')
  from emp;
  
select comm, nvl(to_char(comm), 0 )
  from emp;  
  
-- emp 테이블에서 comm이 null인 경우 200, null이 아닌 경우는 10% 인상
-- nvl2(조사컬럼, 널이 아닐 경우 치환 값, 널일 경우 치환 값)

select ename, comm, nvl2(comm, comm*1.1, 200) 
  from emp;

select ename, comm, nvl2(comm, 'yes', 'no') -- 출력 가능
  from emp;

select ename, comm, nvl2(comm, comm*1.1, 'no') -- 출력 불가
  from emp;

select ename, comm, nvl2(comm, 'yes', 200) -- 출력 가능(두번째 인자의 컬럼 타입이 리턴타입)
  from emp;

-- 조건문의 사용 : decode문(대소조건 불가), case문(대소조건 가능)

0 ~ 2000 : A
2000 ~ 3000 : B
3000 ~ : C
