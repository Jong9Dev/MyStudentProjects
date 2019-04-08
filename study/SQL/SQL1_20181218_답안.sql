--1) Student ���̺��� jumin �÷��� �����Ͽ� �л����� �̸��� �¾ ��, �׸��� �б⸦ ����϶�.
--�¾ ���� 01-03�� �� 1/4�б�, 04-06���� 2/4 �б�, 
--07-09 ���� 3/4 �б�, 10-12���� 4/4 �б�� ����϶� (decode,case���)
select to_char(to_date(substr(jumin,1,6),'RRMMDD')
               ,'Q')||'/4�б�' AS �б�1,
       decode(to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q'),'1','1/4�б�',
                                                               '2','2/4�б�',
                                                               '3','3/4�б�',
                                                                   '4/4�б�') AS �б�2,
       case to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q') when '1' then '1/4�б�'
                                                             when '2' then '2/4�б�'
                                                             when '3' then '3/4�б�'
                                                                      else '4/4�б�'
        end AS �б�3
  from STUDENT;
  
--2) EMP2 ���̺��� ����⵵(1960,1970,1980,1990)���� ��տ����� ���϶�.
select trunc(to_char(BIRTHDAY,'YYYY'),-1) AS ����⵵,
       round(avg(pay))
  from EMP2
 group by trunc(to_char(BIRTHDAY,'YYYY'),-1) ;
  
--3) emp ���̺��� �λ�� ������ �������� 2000 �̸��� 'C',
--2000�̻� 4000�̸��� 'B', 4000�̻��� 'A' ����� �ο��Ͽ� �� ������ ���� ������ �Բ� ���
--**�λ�� ������ ���� ���� ��� 15% ��·� + ���ʽ�(comm)
select ename, sal, comm, sal*1.15 + nvl(comm,0),
       case when sal*1.15 + nvl(comm,0) < 2000 then 'C'
            when sal*1.15 + nvl(comm,0) < 4000 then 'B'
                                               else 'A'
        end AS grade
  from emp;
  
--4) studet ���̺�� EXAM_01 ���̺��� ����Ͽ�
--�� �г⺰ ��� ���輺���� ����Ͽ���
select s.GRADE, avg(e.TOTAL)
  from STUDENT s, EXAM_01 e
 where s.STUDNO = e.STUDNO
group by grade;
  
--5) ����Ʈ�� �ۼ��ϰ��� �Ѵ�.
--emp ���̺��� �̿��Ͽ� �� �μ��� �������� ����ϵ� ������ ���� �������� �ۼ��Ͽ���.
--
--����Ʈ��	       10_������	 20_������	  30_�л���
----------------------------------------------------------
--�����̸� ����Ʈ	        3	         5           6
select 'ȫ���� ����Ʈ' AS ����Ʈ��,
        count(case when deptno = 10 then 1 end) AS "10_������",
        count(case when deptno = 20 then 1 end) AS "20_������",
        count(case when deptno = 30 then 1 end) AS "30_������"
  from emp;
 
 