--1) dept2 ���̺��� �̿��Ͽ� �����μ����� ������ ���� ����ϼ���.
-- "�濵�������� �����μ��� ����� �Դϴ�."
-- ��, �����μ��� ���� ���� ���κμ����� ��µǵ��� �Ͽ���.
--(��Į�� �������� �̿�)
select d1.DNAME||'�� �����μ��� '|| 
       nvl((select d2.DNAME from dept2 d2 where d1.PDEPT = d2.DCODE),
            d1.DNAME)||' �Դϴ�'
  from dept2 d1;
 
--2) emp ���̺��� �̿��Ͽ� �μ����� ���κ��� �Ի�⵵�� ���� ����� ���� �� ������ �̸�, 
-- �μ���� �Բ� ����ϼ���. ��, ������� ���� ��� ������ �����ϼ���
--2-1) ����
select e1.ename, d.DNAME, count(e2.ename) AS �����
  from emp e1, emp e2, DEPT d
 where e1.DEPTNO = e2.DEPTNO(+)
   and to_char(e1.hiredate,'YYYY') > to_char(e2.hiredate(+),'YYYY')
   and e1.DEPTNO = d.DEPTNO
 group by e1.ename, d.DNAME  
 order by ����� desc;

--2-2) ��Į�� ��������
select e1.ename
     , (select d.DNAME from DEPT d where e1.DEPTNO = d.DEPTNO)
     , e2.ename AS �����
  from emp e1, emp e2
 where e1.DEPTNO = e2.DEPTNO(+)
   and to_char(e1.hiredate,'YYYY') > to_char(e2.hiredate(+),'YYYY') 
 order by ����� desc;

select e1.ename, d.DNAME, 
       (select count(e2.ename) 
          from emp e2
         where e1.DEPTNO = e2.DEPTNO(+)
           and to_char(e1.hiredate,'YYYY') > to_char(e2.hiredate(+),'YYYY')) AS �����        
  from emp e1, DEPT d
  where e1.DEPTNO = d.DEPTNO
  order by ����� desc;
 
--3) emp ���̺��� �̿��Ͽ� ���ΰ� ������������ ��տ������� ���� ������ �޴� ������
--�̸�, �μ���, ����, ���������ڸ��� ����Ͽ���.
select e1.ename, e1.sal, d.DNAME, e2.ENAME
  from emp e1, emp e2, DEPT d
 where e1.MGR = e2.EMPNO
   and e1.sal > (e2.SAL + e1.sal)/2
   and e1.DEPTNO = d.DEPTNO
 ;
  
--4) ������ ���� ��ü �ڷḦ ������ ���� �������� ����� ����
--(��, ��� �����鿡 ���� ��µǵ��� �Ѵ�)
--�����̸�	�����л���	�����л�_�������	A_�����ڼ�	B_�����ڼ�	C_�����ڼ�	D_�����ڼ�
--�ɽ�          	2	        79	                1	        0	        0	        1
--����	            2	        83	                0	        1	        1	        0
--������	        1	        97	                1	        0	        0	        0

--P-S-E-H

select p.NAME , 
       count(s.NAME), avg(e.TOTAL), 
       count(decode(substr(h.GRADE,1,1),'A',1)),
       count(decode(substr(h.GRADE,1,1),'B',1)),
       count(decode(substr(h.GRADE,1,1),'C',1)),
       count(decode(substr(h.GRADE,1,1),'D',1))
  from PROFESSOR p,
       STUDENT s,
       EXAM_01 e,
       HAKJUM h
 where p.PROFNO = s.PROFNO(+)
   and s.STUDNO = e.STUDNO(+)
   and e.TOTAL between h.MIN_POINT(+) and h.MAX_POINT(+)
 group by p.NAME  
 order by 1;

