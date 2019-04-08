1. emp 테이블에서 커미션(comm)을 받지 않는 사원의 급여를 10% 인상하여 표시하되, 다음의 형식으로 출력하여라.
The salary of SMITH after a 10% raise is 880

2. emp 테이블에서 12월에 입사한 사람은 보너스를 줄 수 없다고 한다.
12월에 입사한 사람의 사번, 이름, 부서번호를 조회하여라.

3. professor 테이블에서 각 교수의 이메일 아이디를 출력하되,
다음의 특수기호를 제거한 형태로 출력하여라.
'-' 또는 '_'

4. EMPLOYEES 테이블에서 대소를 구분하지 않고 email에 last_name이 포함되어 있지 않은 사람의 EMPLOYEE_ID, FIRST_NAME, EMAIL을 출력하여라.
**  EMPLOYEES 테이블 조회 방법
sqlplus system/oracle
SQL> grant select on hr.EMPLOYEES to scott;
SQL> create public synonym EMPLOYEES for hr.EMPLOYEES;

5. student 테이블에서 성이 'ㅅ'인 학생의 학번, 이름, 학년을 출력하여라.