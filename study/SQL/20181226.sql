-- ���� ������ : �� ������ ���� ������, ������, ������ ����
-- select �� select ���̿� ���� ������ ����

--1. ������
-- union : �������� �� ���� ���, �ߺ��� ���� �����ϱ� ���� ���������� ���� ����
-- union all : ������ ��ü ���
-- union �� union all�� ����� �����ϴٸ�(������ ����) union all�� ����Ͽ� 
-- ���ʿ��� ���� ����
select ename, deptno, sal
  from emp
 where deptno = 10
 union
select ename, deptno, 1000
  from emp
 where deptno = 20; 

select ename, deptno
  from emp
 where sal > 2000
 union all
select ename, deptno
  from emp
 where deptno = 10
;

--2. ������
select ename, deptno
  from emp
 where sal > 2000
intersect
select ename, deptno
  from emp
 where deptno = 10;

--3. ������
select ename, deptno
  from emp
 where sal > 2000
 minus
select ename, deptno
  from emp
 where deptno = 10;
