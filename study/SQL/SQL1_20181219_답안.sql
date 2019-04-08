--1) EMP���̺�� dept ���̺�, p_grade ���̺��� �̿��Ͽ� �� ������ �̸�, �μ���, 
--�������ް� ���ο� ������ ��Ÿ�¾��.
--��, ���ο� ������ �ټӳ���� �������� ����Ѵ�;
select e.ENAME, e.DEPTNO, e.JOB, trunc((sysdate - hiredate)/365) AS �ټӳ��,
       p.POSITION, d.DNAME
  from emp e, P_GRADE p, DEPT d
 where trunc((sysdate - e.hiredate)/365) between p.S_YEAR and p.E_YEAR
   and e.DEPTNO = d.DEPTNO;

--2) student, exam_01, hakjum �� �л��� ������ ���ϰ� �� �������� ������ �л� ���� ������ ���� ���϶�.
--   A 4
--   B 12
--   C 3
--   D 1

select substr(h.GRADE,1,1) AS ����, count(s.STUDNO) AS �л���
  from STUDENT s, EXAM_01 e, HAKJUM h
 where s.STUDNO = e.STUDNO
   and e.TOTAL between h.MIN_POINT and h.MAX_POINT
 group by substr(h.GRADE,1,1);
   
--3) student ���̺�� exam_01, department ���̺��� �̿��Ͽ� �� �а��� ��� ������ �ְ� ����,
--���� ������ ��Ÿ���� �а��̸�, �а���ȣ�� �Բ� ��µǵ��� �ۼ��Ͽ���.
select d.DNAME, s.DEPTNO1, avg(e.TOTAL), max(e.TOTAL), min(e.TOTAL)
  from student s, exam_01 e, department d
 where s.STUDNO = e.STUDNO
   and s.DEPTNO1 = d.DEPTNO
 group by d.DNAME, s.DEPTNO1;

--4) student, professor ���̺��� ��������, ���� ������ ģ���� ������� ���ϰ�, 
--�� �л��� ��� �����̸��� �Բ� ��µǵ��� �Ͽ���.
--��, ��������, ���� ������ ������ ���Ե� �� ����.
select s1.NAME, p.NAME, count(s2.STUDNO)
  from STUDENT s1, STUDENT s2, PROFESSOR p
 where substr(s1.JUMIN,7,1) = substr(s2.JUMIN(+),7,1)
   and substr(s1.TEL,1,instr(s1.tel,')')-1) = substr(s2.TEL(+),1,instr(s2.tel(+),')')-1)
   and s1.STUDNO != s2.STUDNO(+)
   and s1.PROFNO = p.PROFNO(+)
 group by s1.NAME, p.NAME  
 order by 1;

s1 - s2(+)
|
p(+)
;

s1 - s2(+) - p(+)
;

--5) student, exam_01, department ���̺��� �� �л��� ���輺���� ������� 
--�����а����� ���κ��� ���輺���� ����� �л����� ��Ÿ������ �Ͽ���.
--��, �� �л��� ������ �л��̸�, �а��̸�, ���輺���� �Բ� ����Ͽ���.
--(�ƿ��������� ������� �ʴ´�)
select s1.NAME, s1.DEPTNO1, e1.TOTAL, d.DNAME,
       count(s2.STUDNO)
  from STUDENT s1, EXAM_01 e1, 
       STUDENT s2, EXAM_01 e2, 
       DEPARTMENT d
 where s1.STUDNO = e1.STUDNO 
   and s2.STUDNO = e2.STUDNO
   and s1.DEPTNO1 = s2.DEPTNO1
   and e1.TOTAL < e2.TOTAL(+)       -- *************
   and s1.DEPTNO1 = d.DEPTNO
 group by s1.NAME, s1.DEPTNO1, e1.TOTAL, d.DNAME  
 order by 1;
 
d(+)
|
s1(+) - e1(+)
|        |
s2(+) - e2(+)


d
|
s1e1 - s2e2(+)

;


select i1.NAME, i1.DEPTNO1, i1.TOTAL,
       count(i2.NAME)
  from (select s.NAME, s.DEPTNO1, e.TOTAL
          from STUDENT s, EXAM_01 e
         where s.STUDNO = e.STUDNO) i1,
       (select s.NAME, s.DEPTNO1, e.TOTAL
          from STUDENT s, EXAM_01 e
         where s.STUDNO = e.STUDNO) i2
  where i1.deptno1 = i2.deptno1(+)
    and i1.total   < i2.total(+) 
  group by i1.NAME, i1.DEPTNO1, i1.TOTAL;

-- ** �巡�� �� cttl + l : �巡�� ������ �Ϻ� ����






