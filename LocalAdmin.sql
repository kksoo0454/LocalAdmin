-- 시큐리티기능
-- JDBC를 이용하기 위한 테이블 설정
-- 스프링 시큐리티에서 지정된 SQL을 그대로 이용하고 싶다면 지정된 형식으로 테이블을 생성해야 한다.
-- (주의) 무조건 users 테이블과 authorities 테이블 사용해야 함
DROP TABLE admin;
DROP TABLE admin_auth;
DROP SEQUENCE notice_seq;
DROP TABLE notice;
drop sequence seq_reply;
drop table tbl_reply;
drop SEQUENCE post_id_seq;
drop table post;
DROP SEQUENCE seq_member_id;
DROP TABLE member;


CREATE TABLE admin (
  username VARCHAR2(50) PRIMARY KEY,
  password VARCHAR2(100) NOT NULL,
  enabled CHAR(1) DEFAULT '1',
  admin_name VARCHAR2(50),
  email VARCHAR2(100),
  admin_id int NOT NULL
);
select* from admin;
CREATE SEQUENCE seq_admin_id
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
commit;
CREATE TABLE admin_auth (
  username VARCHAR2(50),
  role VARCHAR2(50),
  FOREIGN KEY (username) REFERENCES admin(username)
);
SELECT SEQUENCE_NAME FROM USER_SEQUENCES;
ALTER TABLE admin ADD CONSTRAINT admin_name_unique UNIQUE(admin_name);
INSERT INTO admin (username, password, enabled, admin_name, email, admin_id)
VALUES ('admin01', '1234', '1', '한문철', 'admin01@example.com', seq_admin_id.NEXTVAL);
INSERT INTO admin (username, password, enabled, admin_name, email, admin_id)
VALUES ('admin02', '1234', '2', '윤기봉', 'admin02@example.com', seq_admin_id.NEXTVAL);
-- 권한 정보 입력
INSERT INTO admin_auth (username, role)
VALUES ('admin01', 'ROLE_ADMIN');
INSERT INTO admin_auth (username, role)
VALUES ('admin02', 'ROLE_ADMIN');

update admin SET enabled = '1' where username = 'admin02';

SELECT * FROM admin WHERE username = 'admin02';
select * from admin;
select * from admin_auth;

commit;




--notice 테이블 생성
CREATE TABLE notice (
    notice_id    NUMBER PRIMARY KEY,             -- 공지 ID
    admin_name   VARCHAR2(50) NOT NULL,          -- 작성한 관리자 이름
    title        VARCHAR2(100) NOT NULL,         -- 제목
    content      CLOB NOT NULL,                  -- 내용
    important    NUMBER(1) DEFAULT 0 NOT NULL,   -- 중요공지 여부 (0: 일반, 1: 중요)
    created_at   DATE DEFAULT SYSDATE NOT NULL   -- 작성일
);

--notice 시퀀스 생성
CREATE SEQUENCE notice_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

--더미 데이터 삽입
INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '한문철', '아랏동 춤축제 홍보', '아랏동 춤축제가 9월 12일 개최됩니다. 많은 참여 바랍니다!', 1, TO_DATE('2024-09-10', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '박도라', '고양이 입양 이벤트 안내', '사랑스러운 고양이 입양 이벤트가 열립니다.', 0, TO_DATE('2025-08-22', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '김반장', '주민센터 냉방기 점검 공지', '냉방기 점검으로 인한 일시 사용 불가 안내입니다.', 1, TO_DATE('2025-07-15', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '최민정', '요가 교실 신규 모집!', '건강한 삶을 위한 요가 교실이 개강합니다.', 0, TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '정재훈', '복지 신청 마감일 안내', '복지 신청 마감일은 8월 10일입니다. 기한 내 신청 부탁드립니다.', 1, TO_DATE('2025-07-20', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '이예린', '마을 벼룩시장 참여 신청', '마을 주민을 위한 벼룩시장에 참여하세요!', 0, TO_DATE('2025-07-25', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '남궁범', '음식물 쓰레기 분리 배출 안내', '음식물 쓰레기 배출 시 반드시 분리해주세요.', 1, TO_DATE('2025-07-14', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '류경수', '주민참여예산 공모 시작!', '2025년도 예산안에 참여할 수 있는 기회를 놓치지 마세요.', 0, TO_DATE('2025-08-05', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '오세은', '우리 동네 퀴즈 대회 개최', '다 함께 참여하는 퀴즈 대회! 상품도 있습니다.', 0, TO_DATE('2025-08-18', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '이강우', '밤길 안전 캠페인 안내', '야간 보행자 안전을 위한 캠페인을 진행합니다.', 0, TO_DATE('2025-07-30', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '송하늘', '어르신 스마트폰 교육 신청', '어르신들을 위한 스마트폰 기초 교육이 열립니다. 많은 신청 바랍니다.', 0, TO_DATE('2025-08-03', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '문다솜', '아랏동 그림대회 개최', '아이들을 위한 그림 대회가 열립니다. 창의력 넘치는 작품을 기다립니다.', 0, TO_DATE('2025-08-12', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '유성호', '정전 대비 가정용 랜턴 배포', '여름철 정전에 대비한 가정용 랜턴을 무료로 배포합니다.', 1, TO_DATE('2025-07-28', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '이주하', '아동 도서관 여름 독서 캠프', '아동 도서관에서 여름 독서 캠프가 진행됩니다. 책과 함께하는 여름을 보내세요!', 0, TO_DATE('2025-08-09', 'YYYY-MM-DD'));

INSERT INTO notice (notice_id, admin_name, title, content, important, created_at) VALUES 
(notice_seq.NEXTVAL, '박태우', '주차 단속 시간 변경 안내', '7월 25일부터 주차 단속 시간이 오전 9시~오후 7시로 변경됩니다.', 1, TO_DATE('2025-07-18', 'YYYY-MM-DD'));


--notice 테이블 확인
SELECT * FROM notice;

--주민등록기능
CREATE TABLE member (
    member_id   int NOT NULL,
    jumin       VARCHAR2(14) PRIMARY KEY,         -- 주민등록번호 (PK, 로그인 ID)
    name        VARCHAR2(50) NOT NULL,
    address     VARCHAR2(200),
    phone       VARCHAR2(20),
    email       VARCHAR2(100),
    reg_date    DATE DEFAULT SYSDATE
);

CREATE SEQUENCE seq_member_id
START WITH 1      
INCREMENT BY 1    
NOCACHE           
NOCYCLE; 

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9901011234567', '김민수', '서울시 강남구', '010-1111-0001', 'user01@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9802022234567', '이영희', '서울시 서초구', '010-1111-0002', 'user02@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9703031234567', '박지훈', '서울시 송파구', '010-1111-0003', 'user03@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9604042234567', '최은지', '서울시 노원구', '010-1111-0004', 'user04@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9505051234567', '정우성', '서울시 중랑구', '010-1111-0005', 'user05@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9406062234567', '한지민', '서울시 은평구', '010-1111-0006', 'user06@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9307071234567', '서강준', '서울시 종로구', '010-1111-0007', 'user07@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9208082234567', '고은아', '서울시 도봉구', '010-1111-0008', 'user08@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9109091234567', '장동건', '서울시 양천구', '010-1111-0009', 'user09@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '9001012234567', '윤아름', '서울시 구로구', '010-1111-0010', 'user10@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8902021234567', '노정열', '서울시 관악구', '010-1111-0011', 'user11@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8803032234567', '오세정', '서울시 강북구', '010-1111-0012', 'user12@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8704041234567', '박정아', '서울시 동작구', '010-1111-0013', 'user13@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8605052234567', '임수정', '서울시 마포구', '010-1111-0014', 'user14@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8506061234567', '김남길', '서울시 성북구', '010-1111-0015', 'user15@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8407072234567', '손예진', '서울시 서대문구', '010-1111-0016', 'user16@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8308081234567', '황민호', '서울시 용산구', '010-1111-0017', 'user17@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8209092234567', '이소라', '서울시 강서구', '010-1111-0018', 'user18@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8110101234567', '장기용', '서울시 중구', '010-1111-0019', 'user19@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '8001012234567', '유진', '서울시 동대문구', '010-1111-0020', 'user20@example.com');

INSERT INTO member (member_id, jumin, name, address, phone, email) VALUES 
(seq_member_id.nextval, '0104219876543', '박성준', '남양주 다산동', '010-1111-0001', 'user01@example.com');

commit;



--민원게시판기능
-- 게시글 테이블 (작성자 FK → jumin)

CREATE TABLE post (
    post_id     NUMBER PRIMARY KEY,
    jumin       VARCHAR2(14) NOT NULL,  -- 작성자 (FK → member.jumin)
    title       VARCHAR2(200) NOT NULL,
    content     CLOB NOT NULL,
    created_at  DATE DEFAULT SYSDATE,
    updated_at  DATE,
    category    VARCHAR2(50),
    completed   NUMBER NOT NULL, -- 민원처리 여부(0: 미처리, 1: 처리)
    CONSTRAINT fk_post_member
        FOREIGN KEY (jumin)
        REFERENCES member(jumin)
        ON DELETE CASCADE
);
-- 1. 시퀀스 생성 
CREATE SEQUENCE post_id_seq START WITH 1 INCREMENT BY 1;

-- post 더미데이터(주민 외래키 조건 만족함)
-- 교통
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9604042234567', 
  '불법 주정차 단속 요청', 
  '초등학교 정문 앞 도로에 매일 오전 7시부터 9시까지 불법 주정차 차량이 줄지어 서 있습니다. 
  특히 SUV나 대형 차량은 시야를 완전히 가려 아이들이 도로를 건너기 매우 위험합니다. 
  몇 차례 동네 커뮤니티에서도 문제가 제기되었고, 실제로 경미한 사고도 있었습니다. 
  주기적인 단속을 통해 아이들의 안전을 지켜주세요.', 
  SYSDATE, '교통', 1
);

-- 행정,서류
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8001012234567', 
  '주민등록등본 발급 문의', 
  '현재 병원 입원 수속을 위해 등본이 급하게 필요한 상황인데, 
  거동이 불편하여 주민센터를 직접 방문하기 어렵습니다. 
  무인 발급기나 온라인 신청이 가능한지, 
  가능하다면 어떤 절차를 따라야 하는지 상세히 알려주시면 감사하겠습니다.', 
  SYSDATE, '행정,서류', 0
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8605052234567', 
  '재산세 납부기한 문의', 
  '재산세 고지서를 아직 수령하지 못했는데, 
  납부 마감일이 언제인지 궁금합니다. 
  혹시 우편이 누락되었는지 걱정되어 확인 차 문의드립니다. 
  납부 기한을 놓쳐 가산세가 부과되는 일이 없도록 안내 부탁드립니다.', 
  SYSDATE, '세무', 1
);

-- 불편사항신고
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9109091234567', 
  '도로 파손 신고', 
  '우리 동네 골목길에 깊게 패인 구멍이 두세 곳 있습니다. 
  최근에는 자전거 타던 아이가 넘어져 무릎을 크게 다친 일도 있었습니다. 
  야간에는 조명이 어두워 운전자도 이를 인지하지 못해 사고 위험이 큽니다. 
  빠른 보수 작업을 요청드립니다.', 
  SYSDATE, '불편사항신고', 0
);

-- 기타
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9802022234567', 
  '문화행사 문의', 
  '지난달에 열린 구청 주관 음악회가 너무 좋았습니다. 
  이번 달에도 비슷한 행사나 지역 축제가 있는지 궁금합니다. 
  특히 어린이 대상 체험행사나 야외 콘서트 일정이 있다면 알려주세요. 
  홈페이지에서는 찾기 어려워 이렇게 문의드립니다.', 
  SYSDATE, '기타', 1
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8308081234567', 
  '세금 납부 관련 문의', 
  '자동이체로 납부가 되는 줄 알았는데 연체 안내문을 받았습니다. 
  어떤 사유로 납부가 되지 않았는지 확인을 요청드립니다. 
  연체료 발생 여부도 함께 알려주시면 감사하겠습니다.', 
  SYSDATE, '세무', 0
);

-- 행정,서류
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8506061234567', 
  '출생신고 관련 서류 문의', 
  '출생신고를 하려는데 혼인신고가 되어 있지 않은 경우 필요한 서류가 궁금합니다. 
  관할 주민센터를 꼭 방문해야 하는지도 알려주세요. 
  온라인으로 접수 가능한지 여부도 확인 부탁드립니다.', 
  SYSDATE, '행정,서류', 0
);

-- 교통
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8506061234567', 
  '주차장 부족 관련 민원', 
  '아파트 주변 도로에 주차 차량이 넘쳐나 인도까지 점령하고 있습니다. 
  노인과 어린이들의 보행이 매우 위험한 상태입니다. 
  구청 차원에서의 해결책 마련이 시급해 보입니다.', 
  SYSDATE, '교통', 0
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8605052234567', 
  '세금 환급 절차 문의', 
  '작년에 환급 대상이었는데 아직도 환급이 되지 않았습니다. 
  해당 부서에 문의해도 구체적인 안내가 없어 불편합니다. 
  정확한 일정이나 처리를 위한 절차를 알려주셨으면 합니다.', 
  SYSDATE, '세무', 0
);

-- 행정,서류
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '8704041234567', 
  '여권 발급 관련 문의', 
  '여권 사진 규정이 너무 애매해서 반려당했습니다. 
  명확한 기준과 예시 사진을 제공해주셨으면 좋겠습니다. 
  또, 재촬영 시 비용 부담은 어떻게 되는지도 궁금합니다.', 
  SYSDATE, '행정,서류', 0
);

-- 교통
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9307071234567', 
  '버스 노선 변경 요청', 
  '최근 재개발로 인해 많은 주민이 유입되었지만, 해당 지역을 지나는 버스가 거의 없습니다. 
  특히 어르신들이 병원에 가기 위해 먼 거리를 걸어가야 합니다. 
  노선 조정을 검토해 주세요.', 
  SYSDATE, '교통', 0
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9505051234567', 
  '지방세 자동이체 신청 문의', 
  '지방세 자동이체를 신청했는데 이번 달에 납부되지 않았습니다. 
  등록 상태 확인과 함께 다음 달부터는 문제가 발생하지 않도록 해주세요.', 
  SYSDATE, '세무', 0
);

-- 불편사항신고
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9901011234567', 
  '고교 CCTV 설치 요청', 
  '학교 앞에서 청소년 흡연 및 불량행위가 자주 발생합니다. 
  CCTV를 설치하여 예방 효과를 기대하고 있습니다. 
  학부모들 사이에서도 필요성에 대한 공감대가 형성되어 있습니다.', 
  SYSDATE, '불편사항신고', 0
);

-- 불편사항신고
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL, 
  '9901011234567', 
  '도로 파손 신고', 
  '골목길에 큰 웅덩이가 생겨 차량과 보행자 모두 불편을 겪고 있습니다. 
  특히 비가 오면 물이 고여 사고 위험이 커지니 빠른 조치 부탁드립니다.', 
  SYSDATE, '불편사항신고', 0
);
-- 행정,서류
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '9604042234567',
  '전자문서 지갑 오류',
  '혼인관계증명서에 생년월일이 잘못 기재되어 정정 요청드립니다.
등본에 나오는 주소가 옛날 주소로 계속 출력되고 있습니다.
해외 체류 중인데 서류를 대리인이 발급 가능한지 알고 싶습니다.
온라인 민원 신청 중 오류가 발생하여 접수가 되지 않습니다.',
  SYSDATE, '행정,서류', 0
);

-- 행정,서류
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '8001012234567',
  '등본 주소 오류',
  '전자문서 지갑 앱 연동이 제대로 되지 않습니다.
혼인관계증명서에 생년월일이 잘못 기재되어 정정 요청드립니다.
해외 체류 중인데 서류를 대리인이 발급 가능한지 알고 싶습니다.
온라인 민원 신청 중 오류가 발생하여 접수가 되지 않습니다.',
  SYSDATE, '행정,서류', 1
);

-- 행정,서류
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '8605052234567',
  '해외 서류 발급 문의',
  '혼인관계증명서에 생년월일이 잘못 기재되어 정정 요청드립니다.
온라인 민원 신청 중 오류가 발생하여 접수가 되지 않습니다.
등본에 나오는 주소가 옛날 주소로 계속 출력되고 있습니다.
해외 체류 중인데 서류를 대리인이 발급 가능한지 알고 싶습니다.',
  SYSDATE, '행정,서류', 1
);

-- 기타
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '9109091234567',
  '도서관 운영시간 연장 요청',
  '주민 대상 무료 법률 상담이 있는지 알고 싶습니다.
노인 대상 스마트폰 교육을 확대해 주세요.
재난대비 교육이 너무 적은 것 같습니다. 정기적으로 열어주세요.
지역 도서관 운영 시간을 연장해 주시면 좋겠습니다.',
  SYSDATE, '기타', 1
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '9802022234567',
  '자동차세 중복 발송',
  '납세 증명서를 어디서 발급할 수 있는지 알려주세요.
자동차세 고지서가 중복으로 발송된 것 같습니다.
세금 계산 내역이 불명확해 상세 내역을 요청합니다.
지방세 납부를 위해 모바일 앱 사용 방법을 안내해 주세요.
재산세와 종합부동산세의 차이를 명확히 안내해 주세요.',
  SYSDATE, '세무', 1
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '8308081234567',
  '세금 내역 확인 요청',
  '세금 계산 내역이 불명확해 상세 내역을 요청합니다.
자동차세 고지서가 중복으로 발송된 것 같습니다.
지방세 납부를 위해 모바일 앱 사용 방법을 안내해 주세요.',
  SYSDATE, '세무', 1
);

-- 기타
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '8506061234567',
  '도서관 운영시간 연장 요청',
  '노인 대상 스마트폰 교육을 확대해 주세요.
지역 도서관 운영 시간을 연장해 주시면 좋겠습니다.
재난대비 교육이 너무 적은 것 같습니다. 정기적으로 열어주세요.
주민 대상 무료 법률 상담이 있는지 알고 싶습니다.',
  SYSDATE, '기타', 1
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '8704041234567',
  '세금 내역 확인 요청',
  '지방세 납부를 위해 모바일 앱 사용 방법을 안내해 주세요.
납세 증명서를 어디서 발급할 수 있는지 알려주세요.
재산세와 종합부동산세의 차이를 명확히 안내해 주세요.
자동차세 고지서가 중복으로 발송된 것 같습니다.',
  SYSDATE, '세무', 1
);

-- 불편사항신고
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '9307071234567',
  '엘리베이터 악취 신고',
  '공원 벤치 주변에 벌레가 너무 많아 앉을 수가 없습니다.
아파트 단지 내에서 큰 소리로 음악을 트는 주민이 있어 불편합니다.
맨홀뚜껑이 제대로 닫혀있지 않아 아이가 발을 헛디뎠습니다.
쓰레기 무단 투기 지역에 CCTV 설치를 요청드립니다.',
  SYSDATE, '불편사항신고', 0
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '9505051234567',
  '자동차세 중복 발송',
  '재산세와 종합부동산세의 차이를 명확히 안내해 주세요.
지방세 납부를 위해 모바일 앱 사용 방법을 안내해 주세요.
자동차세 고지서가 중복으로 발송된 것 같습니다.
세금 계산 내역이 불명확해 상세 내역을 요청합니다.
납세 증명서를 어디서 발급할 수 있는지 알려주세요.',
  SYSDATE, '세무', 0
);

-- 세무
INSERT INTO post (post_id, jumin, title, content, created_at, category, completed)
VALUES (
  post_id_seq.NEXTVAL,
  '9901011234567',
  '지방세 앱 납부 방법',
  '재산세와 종합부동산세의 차이를 명확히 안내해 주세요.
납세 증명서를 어디서 발급할 수 있는지 알려주세요.
지방세 납부를 위해 모바일 앱 사용 방법을 안내해 주세요.
자동차세 고지서가 중복으로 발송된 것 같습니다.',
  SYSDATE, '세무', 1
);

select * from post;



-- 대쉬보드기능
-- 전체 민원 게시글 수 불러오기
SELECT COUNT(*) AS post_count FROM post;

-- 댓글 테이블
create table tbl_reply (
  rno number(10,0), 
  post_id number(10,0) not null,
  reply varchar2(1000) not null,
  admin_name varchar2(50) not null, 
  replyDate date default sysdate, 
  updateDate date default sysdate
);
-- 시퀀스 만들기
create sequence seq_reply;
-- rno 기본키 만들기
alter table tbl_reply add constraint pk_reply primary key (rno);
-- 참조키명 만들기 , 참조키 bno와 게시판의 bno기본키와 연결
alter table tbl_reply  add constraint fk_reply_post
foreign key (post_id)  references  post (post_id); 

alter table tbl_reply  add constraint fk_reply_admin
foreign key (admin_name)  references  admin (admin_name); 

-- 댓글 더미 데이터 추가 (한문철 관리자, 게시글 1번에 대한 댓글)
INSERT INTO tbl_reply (rno, post_id, reply, admin_name)
VALUES (seq_reply.nextval, 1, '처리완료했습니다. 문의해주셔서 감사합니다.', '한문철');

commit;
-- 게시판 테이블에 bno 번호 확인
select * from post where rownum < 10 order by post_id desc;
-- 댓글 게시판 테스트 댓글 등록후 PK/FK 확인 쿼리
select * from tbl_reply order by rno desc;

-- tbl_reply 테이블에 bno 열을 내림차순으로, rno 열을 오름차순으로 정렬하는 idx_reply라는 인덱스를 생성
create index idx_reply on tbl_reply(post_id desc, rno asc);


commit;

select*from member;
select*from admin;
select*from post;
select*from tbl_reply;
select*from notice;
