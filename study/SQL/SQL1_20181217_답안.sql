--1) student ���̺��� ��ȭ��ȣ ������ ������ ���� �����ϼ���.  
--051)426-1700 => 051 426 1700
select TEL, translate(TEL,')-','  ')
  from student;
  
--2) EMP ���̺��� �̿��Ͽ� �̸��� J,A �Ǵ� M���� �����ϴ� ��� ����� �̸��� ǥ���Ͽ���.
select *
  from emp
 where substr(ename,1,1) in ('J','A','M') ;

select *
  from emp
 where ename like 'J%'
    or ename like 'A%'
    or ename like 'M%';
    
--3) EMP ���̺��� �̿��Ͽ� ����̸�, �Ի��� �� �޿��������� ǥ���մϴ�. 
--�޿��������� ������ �ٹ��� �ش�Ǵ� ù��° �������Դϴ�. 
--��¥�� "Sunday the Seventh of September, 1981" �������� ǥ���ϵ��� �Ѵ�. 
--�� �̸��� check�� �Ѵ�.
alter session set nls_date_language=american;

select ename, hiredate,
       next_day(add_months(hiredate,6),'mon') AS �޿�������,
       to_char(next_day(add_months(hiredate,6),'mon'),
               'Day "the" Ddspth "of" Month, YYYY')
  from emp;
  
--4) emp ���̺��� �̿��Ͽ� 19810701�ϰ� �Ի糯¥���� ���� ���̸� ����Ͽ���.
--��, ���� ���� ������ �� �� ����.
select abs(hiredate - to_date('19810701','YYYYMMDD'))
  from emp;
  
--5) emp ���̺��� �̿��Ͽ� ������� �ٹ��ϼ��� XX�� XX���� XX�� ���·� ����Ͽ���.
select hiredate,
       trunc(sysdate - hiredate) AS �ٹ��ϼ�,
       trunc(months_between(sysdate,hiredate)) AS �ٹ�������,
       trunc(trunc(months_between(sysdate,hiredate))/12) AS �ټӳ��,
       mod(trunc(months_between(sysdate,hiredate)),12) AS �������ٹ�������,
       trunc(sysdate - add_months(hiredate,trunc(months_between(sysdate,hiredate)))) AS 
       �������ٹ��ϼ�
  from emp;

--** ����(orange ����Ű)
--ctrl + - : �ּ�ó��(�ش� Ŀ�� �� ����, Ȥ�� �巡�� ���� �ּ� ó��)
--ctrl + shift + - : �ּ�����
--ctrl + u : �巡�� ���� �ҹ��� ����
--ctrl + shift + u : �巡�� ���� �빮�� ����
--ctrl + shift + f : �巡�� ���� ǥ�� ���˿� �°� �ٸ���(�Ϻ� ���� ����)
--ctrl + ���콺 ��ũ�� up : ���� Ȯ��
--ctrl + ���콺 ��ũ�� down : ���� ���

