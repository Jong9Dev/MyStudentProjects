select * 
  from emp
 where HIREDATE between '1982/01/01' and '1982/12/31' ;
 
select * 
  from emp
 where HIREDATE like '82%' ;
 

-- order by�� ����� ����
-- student ���̺��� grade�� ���������� ����
select * 
  from student
 order by grade;

-- student ���̺��� grade�� ������, ���� �г⳻���� ��������� ���������� ����
select * 
  from student
 order by grade, BIRTHDAY DESC;

-- studnet ���̺��� �й��� ���������� �����ϰ� �й��� ���� ��� �г������ ����
select * 
  from student
 order by studno, grade;

-- �����Լ��� ��� : ��� ġȯ
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

-- substr(�������ڿ� Ȥ�� �÷�, ������ġ, ���ⰳ��)
-- ������ġ < 0 : �ڿ������� ����
-- ���ⰳ�� ���� �� ������ ����

select name, 
       substr(name,1,1) AS ��,
       substr(name,2,2) AS �̸�1,
       substr(name,2) AS �̸�2
  from student;

-- student ���̺��� �� �л��� �̸�, ���� ���(1 �Ǵ� 2)
select name, substr(jumin,7,1) AS ����
  from student;

-- student ���̺��� ���л� ������ ���
select name, substr(jumin,7,1) AS ����
  from student
 where substr(jumin,7,1) = 2;

select name, substr(jumin,7,1) AS ����
  from student
 order by ����;
 
 
-- student ���̺��� TEL�÷��� ������ ���ڸ� ��ȭ��ȣ�� ����

select tel,
       substr(tel,9) AS "4�ڸ� ��ȭ��ȣ1",
       substr(tel,-4,4) AS "4�ڸ� ��ȭ��ȣ2"
  from student;

select 'abcdefg', substr('abcdefg',-4,2)  
  from dual;

select sysdate, 20||substr(sysdate,1,2) AS year,
       substr(sysdate,4,2) AS month,
       substr(sysdate,7,2) AS day   
  from dual;

-- student ���̺��� TEL �÷��� ����Ͽ� �� �л��� ������ȣ ����
select tel, substr(tel,1,3) AS ������ȣ 
  from student;
  
--instr(���� ���ڿ� �Ǵ� �÷�, ã�����ϴ� ���ڿ�, ������ġ, �ݺ���ȣ)
select 'ab@cd@ef',
       instr('ab@cd@ef','@',1,1) AS "ù ��° �߰ߵǴ� @�� ��ġ",
       instr('ab@cd@ef','@',1,2) AS "�� ��° �߰ߵǴ� @�� ��ġ"
  from dual;     
  
-- substr�� instr�� ����Ͽ� �� �л��� ������ȣ�� ����
select *
  from student;






  