select round(1.567,2), 
       round(123.567,-2)
  from dual;

select sign(10), sign(-10), sign(0)
  from dual;
  
 select sal, sign(sal - 2000)
   from emp; 
   
   
select sysdate,
       sysdate + 3 AS "3�� ��",
       sysdate + 3*365 AS "3�� ��",
       add_months(sysdate ,3) AS "3���� ��",
       add_months(sysdate ,-3) AS "3���� ����"
  from dual;

select sysdate, hiredate, 
       trunc(sysdate - HIREDATE) AS "�ٹ��ϼ�",
       trunc(trunc(sysdate - HIREDATE)/365) AS "�ټӳ��",
       trunc(months_between(sysdate, HIREDATE)) AS "�ٹ� ���� ��"
  from emp;

alter session set nls_date_language='american';

select sysdate,
       next_day(sysdate,2), -- ����ǥ��
       next_day(sysdate,'��') -- �ѱ� ���� ǥ��,
       next_day(sysdate,'MON') -- ���� ���� ǥ��
  from dual;
       
select sysdate,
       round(sysdate,'day'),
       round(sysdate,'month')
  from dual;
  

--����1) EMP ���̺��� ������� �ٹ��ϼ��� �� ��, �� ���ΰ��� ����Ͽ���. 
--         ��, �ٹ��ϼ��� ���� ��� ������ ����Ͽ���.
select ename, 
       trunc(sysdate - hiredate) AS "�ٹ� �ϼ�",
       trunc(trunc(sysdate - hiredate)/7) AS "�ٹ� �� ��",
       mod(trunc(sysdate - hiredate), 7) AS "������ �ٹ� �� ��"
  from emp
 order by "�ٹ� �ϼ�" desc;
  
--����2) EMP ���̺��� 10�� �μ����� ��������� �ٹ� ������ ����Ͽ� 
--         ����Ͽ���. 
select ename, hiredate, trunc(months_between(sysdate,hiredate)) AS "�ٹ� �� ��"
  from emp
 where deptno = 10 ;
  
--����3) EMP ���̺��� �Ի��� ���� ���� �ٹ� �ϼ��� ����Ͽ� ����Ͽ���. 
--         ��, ����ϰ� �Ͽ��ϵ� �ٹ��ϼ��� �����Ѵ�.
select hiredate, last_day(hiredate) - hiredate
  from emp;

--����4) EMP ���̺��� 10�� �μ����� �Ի� ���ڷκ��� ���ƿ��� �ݿ����� 
--         ����Ͽ� ����Ͽ���.
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

-- ��¥�� ���� ���� �Լ�
-- to_char(��¥,'������ ����) : �̹� ��¥Ÿ������ �νĵ� �������� ���� ����(������ ����)
-- to_date(����,'�ν��� ����') : ���� ��¥ó�� ���� ���� Ÿ���� �����͸� ��¥�� �ν�

-- ������ ��������� ���� �������� Ȯ��
select to_char(to_date('19751023','YYYYMMDD'), 'DAY')
  from dual;
  
-- ��¥ ����
select sysdate,
       to_char(sysdate,'MONTH'),  -- �� fullname
       to_char(sysdate,'Month'), 
       to_char(sysdate,'Q'),      -- �б�
       to_char(sysdate,'DDTH'),   -- ��¥ ����(����)
       to_char(sysdate,'DDSPTH')  -- ��¥ ����(����)
  from dual;

-- student ���̺��� jumin �÷��� ����Ͽ� �� �л��� ��������� ������ ���� �������� ����
-- 751023  => 1975-10-23
select to_char(to_date(substr(jumin,1,6),'RRMMDD')
              ,'YYYY-MM-DD')
  from STUDENT;
  
-- student ���̺��� jumin �÷��� ����Ͽ� �� �л��� ��������� ������ ���� �������� ����
-- 751023  => 1975�� 10�� 23��
select to_char(to_date(substr(jumin,1,6),'RRMMDD')
              ,'YYYY"�� "MM"�� "DD"��"')
  from STUDENT;

-- ������ �� ��ȯ
select 1 + '100'  -- �Ʒ��� ���� ������ �� ��ȯ�� �Ͼ
  from dual;
  
select 1 + to_number('100')
  from dual;  

-- ����3) february 22, 1982�� �Ի��� ����� �̸�, ����, �Ի����ڸ� ����Ͽ���.
select ename, hiredate, to_char(hiredate , 'month DD, YYYY')
  from emp
 where to_char(hiredate , 'month DD, YYYY') = 'february 22, 1982' ;
  
select ename, hiredate, to_char(hiredate , 'month DD, YYYY')
  from emp
 where hiredate = to_date('february 22, 1982','month DD, YYYY') ;  
 

select nvl(null,0)
  from dual;

select comm, nvl(comm,'���ʽ��� ����') -- comm �÷��� �����̹Ƿ� nvl ��� ���� ���� �÷�
  from emp;                            -- ���� ���� �÷��� '���ʽ��� ����'��� ���� 
                                       -- ���� �Ұ�(�Ʒ��� ���� ����)
    
select comm, nvl(to_char(comm),'���ʽ��� ����')
  from emp;
  
select comm, nvl(to_char(comm), 0 )
  from emp;  
  
-- emp ���̺��� comm�� null�� ��� 200, null�� �ƴ� ���� 10% �λ�
-- nvl2(�����÷�, ���� �ƴ� ��� ġȯ ��, ���� ��� ġȯ ��)

select ename, comm, nvl2(comm, comm*1.1, 200) 
  from emp;

select ename, comm, nvl2(comm, 'yes', 'no') -- ��� ����
  from emp;

select ename, comm, nvl2(comm, comm*1.1, 'no') -- ��� �Ұ�
  from emp;

select ename, comm, nvl2(comm, 'yes', 200) -- ��� ����(�ι�° ������ �÷� Ÿ���� ����Ÿ��)
  from emp;

-- ���ǹ��� ��� : decode��(������� �Ұ�), case��(������� ����)

0 ~ 2000 : A
2000 ~ 3000 : B
3000 ~ : C
