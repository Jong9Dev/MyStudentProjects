--1) professor ���̺��� �� �а��� �ּҿ����� ���� ������ �̸�, �а��̸�, pay�� ����ϼ���.
--�ζ��κ�)
select p.NAME, d.DNAME, p.PAY
  from PROFESSOR p, department d, (select deptno, min(pay) AS min_pay
                                     from PROFESSOR
                                    group by deptno) i
 where p.DEPTNO = i.deptno
   and p.pay    = i.min_pay
   and p.DEPTNO = d.DEPTNO;
 
--�����÷�)
select p.NAME, d.DNAME, p.PAY
  from PROFESSOR p, department d
 where p.DEPTNO = d.DEPTNO
   and (p.deptno, p.PAY) in (select deptno, min(pay) AS min_pay
                               from PROFESSOR
                              group by deptno);
                              
--��ȣ����)
select p.NAME, d.DNAME, p.PAY
  from PROFESSOR p, department d
 where p.DEPTNO = d.DEPTNO
   and p.PAY = (select min(pay) AS min_pay
                  from PROFESSOR i
                 where p.DEPTNO = i.deptno);

--2) emp, dept ���̺��� ����Ͽ� �� �μ��� �ְ������� �̸�, �μ���, ������ ���ϰ�  
--���������ڿ� ������������ ������ �Բ� ��Ÿ������ �Ͽ���.
select e.ENAME, d.DNAME, e.SAL, s.ENAME, s.SAL
  from emp e, 
       dept d,
       emp s,
       (select deptno, max(sal) max_sal
          from emp
         group by deptno) i
 where e.DEPTNO = i.deptno
   and e.sal    = i.max_sal
   and e.DEPTNO = d.DEPTNO
   and e.MGR    = s.EMPNO(+);

 s
 |
 e - i   
 |
 d
 ;
--3) STUDENT, EXAM_01 ���̺��� ����Ͽ� �г⺰ ��������� ���ϰ� 
--�� �г⺰ ����������� ���� ������ ���� �л��� �̸�, �й�, ������ ����ϼ���.
select *
  from (select s.NAME, s.GRADE, s.STUDNO, e.TOTAL
          from STUDENT s, EXAM_01 e
         where s.STUDNO = e.STUDNO) i1,
        (select s.GRADE, avg(e.TOTAL) as total
           from STUDENT s, EXAM_01 e
          where s.STUDNO = e.STUDNO
          group by s.GRADE) i2
  where i1.grade = i2.grade
    and i1.total < i2.total ;

--4) professor, DEPARTMENT ���̺��� �Ի�⵵(1980,1990,2000���)�� ��տ������� 
--���� ������ �޴� ������ �̸�, �а���, ����, �����л� ���� ����Ͽ���.
--(�������)
select p.NAME, d.DNAME, p.PAY, p.PROFNO, count(s.STUDNO)
  from PROFESSOR p,
       DEPARTMENT d,
       STUDENT s,
       (select trunc(to_char(hiredate,'YYYY'),-1) AS hiredate, avg(pay) avg_pay
          from PROFESSOR p
         group by trunc(to_char(hiredate,'YYYY'),-1)) i    
 where trunc(to_char(p.hiredate,'YYYY'),-1) = i.hiredate
   and p.PAY > i.avg_pay
   and p.DEPTNO = d.DEPTNO
   and p.PROFNO = s.PROFNO(+)
 group by p.NAME, d.DNAME, p.PAY, p.PROFNO  
 order by 1;

s
|
p - i
|
d

;
