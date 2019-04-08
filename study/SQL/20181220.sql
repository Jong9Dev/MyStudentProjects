-- ��������
-- emp ���̺��� allen�� �������� ���� ������ �޴� ����� ���� ���
-- step1) allen�� ���� Ȯ��
select sal
  from emp
 where ename='ALLEN'; -- 1600
 
-- step2) ������ Ȯ���� ������ �������� ���� �ۼ�
select * 
  from emp
 where sal > 1600;
 
-- ���� �� ������ ��ġ�� �Ǹ�
select * 
  from emp
 where sal > (select sal
                from emp
               where ename='ALLEN');
 
-- �̸��� A�� �����ϴ� ������ ���� �μ� ���� ���
select deptno
  from emp
 where ename like 'A%';
 
select *
  from emp
 where deptno in (20,30);
 
select *
  from emp
 where deptno in (select deptno
                    from emp
                   where ename like 'A%'); 
 
-- �̸��� A�� �����ϴ� ������ �������� ���� ���� ��� 
select sal
  from emp
 where ename like 'A%';
 
select *
  from emp
 where sal > min(1100,1600);  -- 1100�� 1600�� �ּҸ� �����ϱ� ���� min�� where���� ����
                              -- ���� �߻�(any�� allǥ�������� ��ü)
                              
select *
  from emp
 where sal > any(1100,1600);
 
> any(a,b) : a,b�� �ּҺ��� ū
> all(a,b) : a,b�� �ִ뺸�� ū
< any(a,b) : a,b�� �ִ뺸�� ����
< all(a,b) : a,b�� �ּҺ��� ����

 
select *
  from emp
 where sal > (select min(sal)
                from emp
               where ename like 'A%'); 

select *
  from emp
 where sal > any(select sal
                   from emp
                  where ename like 'A%'); 

-- ���� �� ���������� ������ ��ü
=   => in 
>,< => any, all �Ǵ� �������� ���� min, max �Լ��� ���

;

-- emp ���̺��� �μ��� �ִ� �������� �̸� ��ȸ
select deptno, max(sal), ename?????(X)
  from emp
 group by deptno;

--sol1) inline view
select e.ENAME, e.DEPTNO, e.SAL
  from emp e, (select deptno, max(sal) AS max_sal
                 from emp
                group by deptno) i
 where e.DEPTNO = i.deptno
   and e.SAL    = i.max_sal;

--sol2) multi column sub query
select *
  from emp
 where deptno in (select deptno
                   from emp
                  group by deptno)
   and sal in (select max(sal)
                from emp
               group by deptno);               
                  
select *
  from emp
 where sal in (select max(sal)
                from emp
               group by deptno); 


select *
  from emp
 where (deptno,sal) in (select deptno, max(sal)
                          from emp
                         group by deptno); 

 
-- STUDENT ���̺��� �� �г⺰�� �����԰� ���� ���� ������ �л��� �̸�, �г�, ������ ���
--sol1) inline view
select NAME, s.GRADE, WEIGHT
  from STUDENT s, (select grade, max(WEIGHT) AS max_weight
                     from STUDENT
                    group by grade) i
 where s.GRADE = i.grade
   and s.WEIGHT = i.max_weight;
 
--sol2) multi column sub-query
select NAME, GRADE, WEIGHT
  from STUDENT 
 where (grade, WEIGHT) in (select grade, max(WEIGHT) AS max_weight
                             from STUDENT
                            group by grade);
 
-- STUDENT ���̺��� �� �г⺰�� ��� �����Ժ��� ���� ������ 
-- �л��� �̸�, �г�, ������ ���
select NAME, s.GRADE, WEIGHT, avg_weight
  from STUDENT s, (select grade, avg(WEIGHT) AS avg_weight
                     from STUDENT
                    group by grade) i
 where s.GRADE  = i.grade
   and s.WEIGHT > i.avg_weight;
   
select NAME, GRADE, WEIGHT
  from STUDENT 
 where (grade, WEIGHT) > (select grade, max(WEIGHT) AS max_weight
                             from STUDENT
                            group by grade);   -- �Ұ�

--sol3) ��ȣ���� ��������(�׷캰 ��Һ� ����) 
select NAME, GRADE, WEIGHT
  from STUDENT s1
 where WEIGHT > (select avg(WEIGHT) AS avg_weight
                   from STUDENT s2
                  where s1.grade = s2.grade 
                  group by grade); -- ��������  
       


-- ��Į�� �������� : select���� ���������� ����Ͽ� �ϳ��� �÷�ó�� ����ϱ� ���� ����
-- ������ ��ü ǥ�������ε� ���� ���ȴ�

-- emp ���̺�� dept ���̺��� ����Ͽ� �� ������ �̸�, �μ���ȣ, �μ��� ���
-- sol1) ����
select e.ename, e.DEPTNO, d.DNAME
  from emp e, dept d
 where e.DEPTNO = d.DEPTNO;
 
-- sol2) ��Į�� ��������
select e.ename, e.DEPTNO, (select d.DNAME
                             from dept d
                            where e.DEPTNO = d.DEPTNO)              
  from emp e; 

-- emp ���̺��� �� ������ �̸��� �Ŵ����� �̸� ���
select e1.ename, (select e2.ename
                    from emp e2
                   where e1.mgr = e2.empno) AS �Ŵ�����
  from emp e1;




   
 

