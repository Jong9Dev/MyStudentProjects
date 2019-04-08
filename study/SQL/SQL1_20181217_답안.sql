--1) student 테이블에서 전화번호 형식을 다음과 같이 변경하세요.  
--051)426-1700 => 051 426 1700
select TEL, translate(TEL,')-','  ')
  from student;
  
--2) EMP 테이블을 이용하여 이름이 J,A 또는 M으로 시작하는 모든 사원의 이름을 표시하여라.
select *
  from emp
 where substr(ename,1,1) in ('J','A','M') ;

select *
  from emp
 where ename like 'J%'
    or ename like 'A%'
    or ename like 'M%';
    
--3) EMP 테이블을 이용하여 사원이름, 입사일 및 급여검토일을 표시합니다. 
--급여검토일은 여섯달 근무후 해당되는 첫번째 월요일입니다. 
--날짜는 "Sunday the Seventh of September, 1981" 형식으로 표시하도록 한다. 
--열 이름은 check로 한다.
alter session set nls_date_language=american;

select ename, hiredate,
       next_day(add_months(hiredate,6),'mon') AS 급여검토일,
       to_char(next_day(add_months(hiredate,6),'mon'),
               'Day "the" Ddspth "of" Month, YYYY')
  from emp;
  
--4) emp 테이블을 이용하여 19810701일과 입사날짜와의 일자 차이를 계산하여라.
--단, 차이 값은 음수가 될 수 없다.
select abs(hiredate - to_date('19810701','YYYYMMDD'))
  from emp;
  
--5) emp 테이블을 이용하여 현재까지 근무일수를 XX년 XX개월 XX일 형태로 출력하여라.
select hiredate,
       trunc(sysdate - hiredate) AS 근무일수,
       trunc(months_between(sysdate,hiredate)) AS 근무개월수,
       trunc(trunc(months_between(sysdate,hiredate))/12) AS 근속년수,
       mod(trunc(months_between(sysdate,hiredate)),12) AS 나머지근무개월수,
       trunc(sysdate - add_months(hiredate,trunc(months_between(sysdate,hiredate)))) AS 
       나머지근무일수
  from emp;

--** 참고(orange 단축키)
--ctrl + - : 주석처리(해당 커서 한 라인, 혹은 드래그 영역 주석 처리)
--ctrl + shift + - : 주석해제
--ctrl + u : 드래그 영역 소문자 변경
--ctrl + shift + u : 드래그 영역 대문자 변경
--ctrl + shift + f : 드래그 쿼리 표준 포맷에 맞게 줄맞춤(일부 오류 있음)
--ctrl + 마우스 스크롤 up : 글자 확대
--ctrl + 마우스 스크롤 down : 글자 축소

