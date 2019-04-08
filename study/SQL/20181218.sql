--if A = 1 then 'a'
--   A = 2 then 'b'
--   A = 3 then 'c'
--         else 'd'

decode(A,1,'a',
         2,'b',
         3,'c',
           'd')
           
case when A > 1 then 'a'         
     when B = 2 then 'b'
     when A = 3 then 'c'
                else 'd'
 end       
 
;

--���ǹ� ����
--emp ���̺��� �μ���ȣ�� 10�̸� �ѹ���, 20�̸� �λ��, 30�̸� �繫��
select deptno, decode(DEPTNO, 10,'�ѹ���',20,'�λ��','�繫��') AS �μ��̸� 
  from emp;
 
select deptno, case when DEPTNO = 10 then '�ѹ���'
                    when DEPTNO = 20 then '�λ��'
                                     else '�繫��'
                end AS �μ��̸� 
  from emp; 
 
select deptno, case DEPTNO when 10 then '�ѹ���'
                           when 20 then '�λ��'
                                   else '�繫��'
                end AS �μ��̸� 
  from emp;  
 
--if A = 1 and B = 1 then 'a'
--         and B = 2 then 'b'
--   A = 3 then 'c'
--         else 'd'
 
decode(A,1,decode(B,1,'a','b'),
         3,'c',
           'd') 
 
case when A = 1 and B = 1 then 'a'
     when A = 1 and B = 2 then 'b'
     when A = 3 then 'c'
                else 'd' 
 end
;
 
-- ���ߺб� ���ǹ� ����
-- PROFESSOR ���̺��� ���� �ĺ��� �̴µ�
-- 101�� �μ����� ���������� ���� �ĺ��� �� �� �ִ�
-- ���� �ĺ� ���θ� ���
 
select DEPTNO, POSITION,
       decode(DEPTNO,101,decode(POSITION,'������','���� �ĺ�'))
  from PROFESSOR;
 
 
-- STUDENT ���̺��� ����Ͽ� �� �л��� �̸�, �й�, ���� ���
select name, studno, jumin,
       decode(substr(jumin,7,1),'1','����','����') AS ����
  from STUDENT;
 
-- emp ���̺��� sal �������� �� ������ ��� ����(���� �Ʒ�) 
-- 0 ~ 2000 : A
-- 2000 ~ : B
select ename, sal,
       case when sal < 2000 then 'A'
                            else 'B'
        end AS grade,
       sign(sal - 2000),
       decode(sign(sal - 2000), -1 ,'A','B')
  from emp;
  
select count(*), count(ename), count(sal), count(comm)  
  from emp;
  
select avg(comm), sum(comm) / count(*), avg(nvl(comm,0)), ename
  from emp;
  
select deptno, job, avg(sal)
  from EMP
 group by deptno, job;
  
select deptno, max(sal)
  from emp
 group by deptno ;

select substr(jumin,7,1), avg(weight) 
  from STUDENT
 group by substr(jumin,7,1);

select grade, avg(height)
  from STUDENT
 where avg(height) >= 170 
 group by grade;
 
select grade, avg(height)
  from STUDENT
 group by grade
having grade != 2;
  
select grade, avg(height)
  from STUDENT
 where grade != 2
 group by grade
;

--[ �ǽ� ] 
--
--����1) emp ���̺��� �̿��Ͽ� �� �μ����� �����, �ִ뿬��, �ּҿ���, 
--         ��տ����� ���ϰ� �޿�������� �����Ͽ���.
select deptno, count(EMPNO), max(sal), min(sal), avg(sal)
  from emp
 group by deptno;

desc emp;
--����2) emp ���̺��� �̿��Ͽ� �� �������� �����, �޿������ ���ϰ� 
--        �������� �����Ͽ���.
select job AS ����, count(EMPNO), avg(sal) AS �޿����
  from emp
 group by job
 order by ����;

--����3) emp ���̺��� �̿��Ͽ� ������(JOB), �μ���(DEPTNO)�� �׷�ȭ�Ͽ� 
--         ������ �ο����� �޿������ ���ϰ� �޿������ ���� ������ �����Ͽ���.
select job, deptno, count(EMPNO), avg(sal) AS �޿����
  from emp
 group by job, deptno
 order by �޿���� desc;

--����4) EMP ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, 
--         �޿��� ���� ����Ͽ���.
select deptno, count(ename), sum(sal)
  from emp
 group by deptno
having count(ename) > 4;
  
--����5) EMP ���̺��� ������ �޿��� ����� 3000 �̻��� ������ ���ؼ� 
--         ������, ��� �޿�, �޿��� ���� ���Ͽ���.
select job, avg(sal), sum(sal)
  from emp
 group by job
having avg(sal) >= 3000;




select s.name, p.name
  from STUDENT s, PROFESSOR p
 where s.PROFNO = p.PROFNO(+);

-- īƼ�þ� �� �߻�(cross join)
select s.NAME, s.STUDNO, d.DNAME 
  from STUDENT s, DEPARTMENT d
 order by name; 

select s.NAME, s.STUDNO, d.DNAME 
  from STUDENT s, DEPARTMENT d
 where s.DEPTNO1 = d.DEPTNO
 order by name; 

-- STUDENT, DEPARTMENT, EXAM_01 ���̺��� ����Ͽ�
-- �� �л��� �̸�, ��1������, ���������� ���
select s.NAME, d.DNAME, e.TOTAL
  from STUDENT s, DEPARTMENT d, EXAM_01 e
 where s.DEPTNO1 = d.DEPTNO
   and s.STUDNO = e.STUDNO;
   
 select * from EXAM_01  


