-- Database schema for CRUD example with 1:n, n:1, n:m relationships

-- Drop tables if exist (in reverse order due to foreign keys)
DROP TABLE IF EXISTS student_course CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS department CASCADE;

-- Department table (One department has many students - 1:n)
CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Student table (Many students belong to one department - n:1)
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES department(id) ON DELETE CASCADE
);

-- Course table
CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    credits INTEGER NOT NULL DEFAULT 3,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Student-Course junction table (Many students can take many courses - n:m)
CREATE TABLE student_course (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade VARCHAR(2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE(student_id, course_id)
);

-- Create indexes for better performance
CREATE INDEX idx_student_department_id ON student(department_id);
CREATE INDEX idx_student_course_student_id ON student_course(student_id);
CREATE INDEX idx_student_course_course_id ON student_course(course_id);

-- 한국어 샘플 데이터
INSERT INTO department (name, description) VALUES
('컴퓨터공학과', '컴퓨터 과학 및 소프트웨어 엔지니어링을 전문으로 하는 학과'),
('수학과', '순수수학과 응용수학, 통계학을 연구하는 학과'),
('물리학과', '물리학 이론과 실험을 통해 자연 현상을 탐구하는 학과'),
('전자공학과', '전자회로, 통신, 제어시스템을 연구하는 학과'),
('경영학과', '기업 경영과 관리 전략을 학습하는 학과');

INSERT INTO student (name, email, phone, department_id) VALUES
('김민수', 'kim.minsu@university.ac.kr', '010-1234-5678', 1),
('이지은', 'lee.jieun@university.ac.kr', '010-2345-6789', 1),
('박준호', 'park.junho@university.ac.kr', '010-3456-7890', 2),
('최수연', 'choi.suyeon@university.ac.kr', '010-4567-8901', 2),
('정민재', 'jung.minjae@university.ac.kr', '010-5678-9012', 3),
('한지훈', 'han.jihoon@university.ac.kr', '010-6789-0123', 4),
('윤소희', 'yoon.sohee@university.ac.kr', '010-7890-1234', 5),
('신동현', 'shin.donghyun@university.ac.kr', '010-8901-2345', 1);

INSERT INTO course (name, code, credits, description) VALUES
('자료구조', 'CS101', 3, '기본적인 자료구조와 알고리즘을 학습하는 과목'),
('데이터베이스', 'CS201', 3, '관계형 데이터베이스 설계와 SQL을 배우는 과목'),
('미적분학', 'MATH101', 4, '미분과 적분의 기초 이론과 응용을 다루는 과목'),
('선형대수학', 'MATH201', 3, '벡터공간과 선형변환을 연구하는 과목'),
('일반물리학', 'PHYS101', 4, '고전역학과 열역학의 기본 원리를 학습하는 과목'),
('디지털회로', 'EE101', 3, '디지털 논리회로 설계와 분석을 다루는 과목'),
('경영학원론', 'BIZ101', 3, '기업 경영의 기본 개념과 원리를 배우는 과목'),
('프로그래밍언어론', 'CS301', 3, '다양한 프로그래밍 언어의 특성과 설계 원리를 학습하는 과목');

INSERT INTO student_course (student_id, course_id, grade) VALUES
(1, 1, 'A'),   -- 김민수 - 자료구조
(1, 2, 'B+'),  -- 김민수 - 데이터베이스
(1, 8, 'A-'),  -- 김민수 - 프로그래밍언어론
(2, 1, 'A-'),  -- 이지은 - 자료구조
(2, 3, 'B'),   -- 이지은 - 미적분학
(3, 3, 'A'),   -- 박준호 - 미적분학
(3, 4, 'A-'),  -- 박준호 - 선형대수학
(4, 3, 'B+'),  -- 최수연 - 미적분학
(4, 4, 'A'),   -- 최수연 - 선형대수학
(5, 5, 'A'),   -- 정민재 - 일반물리학
(5, 3, 'B'),   -- 정민재 - 미적분학
(6, 6, 'A-'),  -- 한지훈 - 디지털회로
(6, 3, 'B+'),  -- 한지훈 - 미적분학
(7, 7, 'A'),   -- 윤소희 - 경영학원론
(7, 3, 'B'),   -- 윤소희 - 미적분학
(8, 1, 'A+'),  -- 신동현 - 자료구조
(8, 2, 'A');   -- 신동현 - 데이터베이스