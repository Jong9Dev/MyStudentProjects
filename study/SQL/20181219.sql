-- non-equi join

-- GOGAK���̺�� GIFT���̺��� ����Ͽ� �� ���� ����Ʈ����
-- �޾ư� �� �ִ� ���� ���� ��ǰ�� ���
select g1.GNAME AS ����, g2.GNAME AS ��ǰ��
  from GOGAK g1, GIFT g2
 where g1.POINT between g2.G_START and g2.G_END;

-- GOGAK���̺�� GIFT���̺��� ����Ͽ� �� ���� ����Ʈ����
-- �޾ư� �� �ִ� ��� ��ǰ�� ���
select g1.GNAME AS ����, g2.GNAME AS ��ǰ��
  from GOGAK g1, GIFT g2
 where g1.POINT >= g2.G_START
 order by 1;
 
-- GOGAK���̺�� GIFT���̺��� ����Ͽ� �� ��ǰ�� �ִ� ��� ���� ��� 
select count(g1.GNAME) AS ��ǰ��, g2.GNAME AS ��ǰ��
  from GOGAK g1, GIFT g2
 where g1.POINT >= g2.G_START
 group by g2.GNAME
 order by g2.GNAME;

select s.STUDNO, s.NAME, s.GRADE, e.TOTAL, h.GRADE
  from STUDENT s, EXAM_01 e, HAKJUM h
 where s.STUDNO = e.STUDNO
   and e.TOTAL between h.MIN_POINT and h.MAX_POINT;
 
select p.NAME, count(s.NAME)
  from PROFESSOR p, STUDENT s
 where p.PROFNO = s.PROFNO(+)
 group by p.NAME 
 order by 2;

select ENAME,JOB,SAL, d.DNAME 
from emp e, dept d
where e.DEPTNO = d.DEPTNO;

select e1.ENAME AS �̸�, e1.sal AS ����,
       e2.ENAME AS ���������ڸ� , e2.SAL AS ���������ڿ���
  from emp e1, emp e2
 where e1.MGR = e2.EMPNO(+) 
   and e1.sal > e2.sal;

-- PROFESSOR ���̺��� ����Ͽ� �� ������ �̸�, �Ի���, 
-- �� �������� ���� �Ի��� ������ �̸��� �Ի����� ���
select p1.NAME AS �̸�, p1.HIREDATE AS �Ի���,
       p2.NAME AS �����̸�, p2.HIREDATE AS �����Ի���
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE(+) 
 order by 1;

-- ���� ������ ����Ͽ� �� �������� ���� �Ի��� ����(���豳��)�� ���� 
-- ���� �̸��� �Բ� ���
select p1.NAME AS �̸�, p1.HIREDATE,
       count(p2.NAME) AS �����
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE (+)
 group by p1.NAME 
 order by 1;

-- ���� �����Ϳ� �� ������ �Ի糯¥ �߰�
select p1.NAME AS �̸�, p1.HIREDATE, p1.pay, p1.POSITION,
       count(p2.NAME) AS �����
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE (+)
 group by p1.PROFNO, p1.NAME , p1.HIREDATE, p1.pay, p1.POSITION
 order by 1;
 
-- �ƿ��� ���� �� ���ǻ��� : ���� ���̺� ��� ǥ��
-- professor ���̺��� ���� �а� ���� ������ ���� ���
select p1.PROFNO, p1.NAME AS �̸�, count(p2.NAME) AS �����
  from PROFESSOR p1, PROFESSOR p2
 where p1.HIREDATE > p2.HIREDATE (+)
   and p1.DEPTNO = p2.DEPTNO(+)
 group by p1.PROFNO, p1.NAME
 order by 1;

-- STUDENT ���̺��� �� �г⺰�� �� �л����� ���κ��� Ű�� ū ģ���� ����
-- �л��� �̸�, �й�, �г�, Ű�� �Բ� ���
select s1.NAME, s1.STUDNO, s1.GRADE, s1.HEIGHT,
       count(s2.NAME) AS ģ����
  from STUDENT s1, STUDENT s2
 where s1.GRADE = s2.GRADE(+)
   and s1.HEIGHT < s2.HEIGHT(+)
 group by s1.STUDNO, s1.NAME, s1.GRADE, s1.HEIGHT; 

-- emp ���̺��� �� �μ��� �ִ� ������ Ȯ��
select * from emp;

delete emp
 where EMPNO = 9999;
commit;

select e.ENAME, e.DEPTNO, e.SAL
  from emp e, (select deptno, max(sal) AS max_sal
                 from emp
                group by deptno) i
 where e.DEPTNO = i.deptno             
   and e.SAL    = i.max_sal;

-- �������� : �������� �� �� �ٸ� ����
select col1, (select ...)  -- ��Į�� �������� : �ϳ��� �÷�ó�� ���
  from (select ...)        -- �ζ��� �� : �ϳ��� ���̺�ó�� ���
 where col = (select ...)  -- �Ϲ� �������� : �ϳ��� ����(���)ó�� ���






