# Toy JSP Application

Java Maven 프로젝트로 JSP, MyBatis, Spring MVC Framework, PostgreSQL JDBC를 사용한 학사 관리 시스템입니다.

## 프로젝트 개요

이 프로젝트는 다음과 같은 데이터베이스 관계를 통해 간단한 CRUD 기능을 제공합니다:
- **1:n 관계**: 학과 → 학생 (한 학과에 여러 학생)
- **n:1 관계**: 학생 → 학과 (여러 학생이 한 학과에 소속)
- **n:m 관계**: 학생 ↔ 과목 (학생은 여러 과목 수강, 과목은 여러 학생이 수강)

## 기술 스택

### Backend
- **Java 17**
- **Spring MVC 5.3**
- **MyBatis 3.5**

### Database
- **PostgreSQL**
- **HikariCP** (Connection Pool)
- **JDBC**

### Frontend
- **JSP** (Java Server Pages)
- **JSTL** (JSP Standard Tag Library)
- **CSS3** (Responsive Design)

## 프로젝트 구조

```
toy-jsp/
├── src/main/java/com/example/
│   ├── config/          # Spring 설정
│   ├── controller/      # Spring MVC 컨트롤러
│   ├── service/         # 비즈니스 로직
│   ├── mapper/          # MyBatis 매퍼 인터페이스
│   └── model/           # 엔티티 모델
├── src/main/resources/
│   ├── mappers/         # MyBatis XML 매퍼
│   └── application.properties
├── src/main/webapp/
│   ├── WEB-INF/views/   # JSP 뷰 파일
│   ├── css/             # 스타일시트
│   └── web.xml
├── database/
    └── schema.sql       # 데이터베이스 스키마

```

## 데이터베이스 설정

1. PostgreSQL 설치 및 실행
2. 데이터베이스 생성:
```sql
CREATE DATABASE toy_jsp_db;
```

3. 스키마 실행:
```bash
psql -U postgres -d toy_jsp_db -f database/schema.sql
```

4. 데이터베이스 연결 정보 수정 (`src/main/resources/application.properties`):
```properties
db.url=jdbc:postgresql://localhost:5432/toy_jsp_db
db.username=postgres
db.password=your_password
```


## 애플리케이션 접속

서버 실행 후 브라우저에서 접속:
- URL: `http://localhost:8080/toy-jsp`

## 주요 기능

### 1. 학과 관리 (`/departments`)
- 학과 목록 조회
- 학과 등록/수정/삭제
- 학과별 소속 학생 조회

### 2. 학생 관리 (`/students`)
- 학생 목록 조회 및 검색
- 학생 등록/수정/삭제
- 학생별 수강과목 조회

### 3. 과목 관리 (`/courses`)
- 과목 목록 조회
- 과목 등록/수정/삭제
- 과목별 수강학생 조회

### 4. 수강신청 관리 (`/enrollments`)
- 수강신청 등록/수정/삭제
- 학생별 수강현황 조회
- 과목별 수강학생 조회
- 성적 입력 및 관리

## 데이터베이스 관계 설명

### 1:n 관계 (Department → Student)
```sql
-- 한 학과에 여러 학생이 소속
department (1) → student (n)
```

### n:1 관계 (Student → Department)
```sql
-- 여러 학생이 하나의 학과에 소속
student (n) → department (1)
```

### n:m 관계 (Student ↔ Course)
```sql
-- 학생은 여러 과목을 수강하고, 과목은 여러 학생이 수강
student (n) ↔ student_course ↔ course (m)
```

## 샘플 데이터

프로젝트에는 다음과 같은 샘플 데이터가 포함되어 있습니다:
- 3개 학과 (컴퓨터공학과, 수학과, 물리학과)
- 5명 학생
- 5개 과목
- 10개 수강신청 기록

## 주요 특징

1. **관계형 데이터 모델링**: 1:n, n:1, n:m 관계를 실제 비즈니스 로직에 적용
2. **트랜잭션 관리**: Spring의 @Transactional을 통한 트랜잭션 처리
3. **데이터 검증**: 이메일 중복 체크, 과목코드 중복 체크 등
4. **사용자 친화적 UI**: 반응형 디자인과 직관적인 네비게이션
5. **에러 처리**: 적절한 에러 메시지와 사용자 피드백

## 개발 환경

- **IDE**: IntelliJ IDEA / Eclipse
- **Java**: JDK 17
- **PostgreSQL**: 12+
- **웹 서버**: Jetty (개발) / Tomcat (운영)
