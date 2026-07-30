-- ============================================
-- [BE14] MySQL 연습문제 (12강) - scott 스키마
-- 아래 스키마를 먼저 실행한 뒤, 각 문제 아래에 SQL을 작성하세요.
-- ============================================

-- ===== 스키마 및 데이터 세팅 (그대로 실행) =====
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

DROP DATABASE IF EXISTS scott;

CREATE DATABASE scott;

USE scott;

CREATE TABLE DEPT (
    DEPTNO DECIMAL(2), # 부서 번호
    DNAME VARCHAR(14), # 부서 이름
    LOC VARCHAR(13), # 부서 위치
    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO) 
);
CREATE TABLE EMP (
    EMPNO DECIMAL(4), # 사원 번호
    ENAME VARCHAR(10), # 사원 이름
    JOB VARCHAR(9), # 직책
    MGR DECIMAL(4), # 상사 번호
    HIREDATE DATE, # 입사일
    SAL DECIMAL(7,2), # 급여
    COMM DECIMAL(7,2), # 커미션
    DEPTNO DECIMAL(2), # 부서 번호
    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
    CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);
CREATE TABLE SALGRADE ( 
    GRADE TINYINT, # 급여 등급
    LOSAL SMALLINT, # 등급 최저 금액
    HISAL SMALLINT  # 등급 최고 금액
);

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('13-7-1987','%d-%m-%Y')-85,3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-9-1981','%d-%m-%Y'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,STR_TO_DATE('13-7-1987', '%d-%m-%Y'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,STR_TO_DATE('3-12-1981','%d-%m-%Y'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,STR_TO_DATE('3-12-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,STR_TO_DATE('23-1-1982','%d-%m-%Y'),1300,NULL,10);
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);


-- ===== 연습 문제 (각 문제 아래에 답을 작성) =====
#1. 사원 테이블의 모든 레코드를 조회하시오.
SELECT * 
FROM EMP;

#2. 사원명과 입사일을 조회하시오.
SELECT ENAME as '사원명'
	, HIREDATE as '입사일'
FROM EMP;

#3. 사원번호와 이름을 조회하시오.
SELECT EMPNO as '사원번호'
	, ENAME as '사원명'
FROM EMP;

#4. 사원테이블에 있는 직책의 목록을 조회하시오. (hint : distinct, group by)
SELECT DISTINCT JOB as '직책'
FROM EMP;

SELECT JOB as '직책'
FROM EMP
GROUP BY JOB;

#5. 총 사원수를 구하시오. (hint : count)
SELECT COUNT(*) as '총사원수'
FROM EMP;

#6. 부서번호가 10인 사원을 조회하시오.
SELECT ename as '사원명'
	 , deptno as '부서번호'
from emp
where deptno = 10;

#7. 월급여가 2500이상 되는 사원을 조회하시오.
select ename as '사원명'
from emp
where sal >= 2500;

#8. 이름이 'KING'인 사원을 조회하시오.
select ename
from emp
where ename = 'King';

#9. 사원들 중 이름이 S로 시작하는 사원의 사원번호와 이름을 조회하시오. (hint : like)
select ename
from emp
where ename like 's%';

#10. 사원 이름에 T가 포함된 사원의 사원번호와 이름을 조회하시오. (hint : like)
select ename, empno
from emp
where ename like '%t%';

#11. 커미션이 300, 500, 1400 인 사원의 사번,이름,커미션을 조회하시오. (hint : OR, in )
select empno, ename, comm
from emp 
where comm in(300, 500, 1400);

#12. 월급여가 1200 에서 3500 사이의 사원의 사번,이름,월급여를 조회하시오. (hint : AND, between)
select empno, ename, sal
from emp
where sal between 1200 and 3500;

#13. 직급이 매니저이고 부서번호가 30번인 사원의 이름,사번,직급,부서번호를 조회하시오. 
select ename, empno, job, deptno
from emp
where deptno = 30 and job='manager';

#14. 부서번호가 30인 아닌 사원의 사번,이름,부서번호를 조회하시오. (not)
select empno, ename, deptno
from emp
where not deptno=30;

#15. 커미션이 300, 500, 1400 이 모두 아닌 사원의 사번,이름,커미션을 조회하시오. (hint : not in)
select empno, ename, comm
from emp
where comm not in (300, 500, 1400);

#16. 이름에 S가 포함되지 않는 사원의 사번,이름을 조회하시오. (hint : not like)
select empno, ename, comm
from emp
where ename not like '%s%';

#17. 급여가 1200보다 미만이거나 3700 초과하는 사원의 사번,이름,월급여를 조회하시오. (hint : not, between)
select empno, ename, sal
from emp
where sal not between 1200 and 3700;

#18. 직속상사가 NULL 인 사원의 이름과 직급을 조회하시오. (hint : is null, is not null)
select ename, job
from emp
where mgr is null;

#19. 부서별 평균월급여를 구하는 쿼리 (hint : group by, avg())
select deptno as '부서 번호'
		, avg(sal) as '평균 월급여'
from emp
group by deptno;

#20. 부서별 전체 사원수와 커미션을 받는 사원들의 수를 구하는 쿼리 (hint : group by, count())
select deptno as '부서번호'
		, count(ename)  '부서별 전체 사원 수'
		, count(comm)  '커미션 받는 사원 수'
from emp
group by deptno;

#21. 부서별 최대 급여와 최소 급여를 구하는 쿼리 (hint : group by, min(), max())
select deptno as '부서번호'
	, max(sal) as '최대급여'
	, min(sal) AS '최소급여'
from emp 
group by deptno;

#22. 부서별로 급여 평균 (단, 부서별 급여 평균이 2000 이상만) (hint : group by, having)
select deptno as '부서번호'
	,avg(sal) as '급여 평균'
from emp 
group by deptno
having avg(sal)>= 2000;

#23. 월급여가 1000 이상인 사원만을 대상으로 부서별로 월급여 평균을 구하라. 단, 평균값이 2000 이상인 레코드만 구하라. (hint : group by, having)
select deptno as '부서번호'
	, avg(sal) as '급여 평균'
from emp 
where 1000 <= sal
group by deptno 
having avg(sal)>=2000;

#24. 사원명과 부서명을 조회하시오. (hint : inner join
select d.dname as '부서명'
	, e.ename as '사원명'
from emp as e
inner join dept as d
on e.deptno = d.deptno;

#25. 이름,월급여,월급여등급을 조회하시오. (hint : inner join, between)
select e.ename as '사원명'
	, e.sal as '월급여'
	, s.grade as '월급여등급'
from emp as e
inner join salgrade as s
on e.sal between s.losal and s.hisal;


#26. 이름,부서명,월급여등급을 조회하시오. 
select e.ename  as '사원명'
	, d.dname as '부서명'
	, s.grade as '월급여등급'
from emp as e
inner join dept as d
on e.deptno = d.deptno
inner join salgrade as s
on e.sal between s.losal and s.hisal;

#27. 이름,직속상사이름을 조회하시오. (hint : self join)
select e.ename  as '사원명'
	, m.ename as '상사이름'
from emp as e
inner join emp as m
on e.mgr = m.empno;

#28. 이름,직속상사이름을 조회하시오.(단 직속 상사가 없는 사람도 직속상사 결과가 null값으로 나와야 함) (hint : outer join)
select e.ename  as '사원명'
	, m.ename as '상사이름'
from emp as e
left join emp as m
on e.mgr = m.empno;
