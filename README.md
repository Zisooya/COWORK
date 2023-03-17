# COWORK
# 6조 Project(COWORK)

발표PPT : [https://1drv.ms/p/s!AlKn3EjiFBb7gXlrtv5cbO4uyjV0](https://1drv.ms/p/s!AlKn3EjiFBb7gXlrtv5cbO4uyjV0)

테이블 구조도(QuickDBD) : [https://app.quickdatabasediagrams.com/#/d/K6XpEe](https://app.quickdatabasediagrams.com/#/d/K6XpEe)

UI/UX 기획툴 : [https://ovenapp.io/](https://ovenapp.io/)

### 🚨ASAP🚨

~오늘 18시

- [x]  현우 : fileupload 문제, ppt
- [x]  지수 : 채팅
- [x]  귀근 : 메일 휴지통
- [x]  세건 : 댓글 수정, 삭제 문제
- [x]  형섭 : 회원정보 수정

~내일 9시

- [ ]  각자 기능 내용 정리(ppt파일로, 소감 포함)
    - [x]  현우
    - [x]  지수
    - [x]  세건
    - [x]  형섭
    - [ ]  귀근
- [ ]  테이블 구조도(QuickDBD) 최종본으로 업데이트
    - [x]  현우
    - [x]  지수
    - [x]  형섭
    - [ ]  귀근
    - [ ]  세건

~내일 12시

- [ ]  기능 최종 병합(**기능 업데이트 마감)**

~내일 18시

- [ ]  css 정리
- 완료
    - [x]  화면 설계(by oven) - (11/25~28)
    - [x]  테이블 짜기(by QuickDBD) - [https://app.quickdatabasediagrams.com/#/d/K6XpEe](https://app.quickdatabasediagrams.com/#/d/K6XpEe)
    - [x]  어플리케이션(프로젝트) 이름 짓기 - November 30, 2022
    - [x]  sql developer에서 oracle cloud로 연결하기(아래 DB란 참고) - (~11/29)

---

### 팀원 작업 요청

- 지수→ 귀근, 현우

주소록에 오른쪽 사이드바- **각 연락처 클릭 시 뜨는 상세 정보란**에 아이콘 만들어뒀으니

각자 이동할 경로 말씀해주시면 넣을게요!

- 이미지 참고
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c2748d3b-ff01-4c2e-a753-45ace22a793e/Untitled.png)
    

### 역할 분담

[[박지수] Top화면(include)/주소록(직원조회) / 메시지(채팅)](https://www.notion.so/Top-include-b19744d9c80c45528f36327a53c30efa)

[[박현우] 캘린더](https://www.notion.so/13b0a53013ac41e3a882c3551413d9f8)

[**[이세건]** 프로젝트 진행 관리 / to do](https://www.notion.so/to-do-cf5b2759ea754b3bb56b858a91ecb940)

[[이형섭] 회원가입 / 로그인](https://www.notion.so/cc21e064f5ea4b7f83f1ceff83129c2e)

[**[조귀근]** 메일, 커뮤니티(사내 게시판, 공지사항)](https://www.notion.so/45660c4e400e4c4dae449317884d00f5)

- Sub기능(여유되면 추가)
    - 채팅봇
    - 관리자(구성원 추가 기능)
    - 근태관리
    - 전자결재

- 회사 계급
    
    부서 > 소속 > 직책 & 직급
    소속과 직책은 프로젝트 단위로 생기고 사라짐.
    
    * 예시 - 홍길동의 직원 정보
    부서 : 마케팅
    소속 : 1팀
    직책 : 팀장
    직급 : 과장
     ==> 마케팅 부서에서 과장의 직급으로 일하고 있는 직원. 
    진행되는 프로젝트를 수행하기 위해 개설된 1팀의 팀장을 맡고 있다.
    

---

### GitHub

[3조 github 규칙]

- **작업 순서**
1. 학원 오자마자 **Pull** (develop → 개인 branch), root-context 파일 전자지갑 경로 확인
2. 겁나 코딩
(기능 단위든 태그 단위든 자신만의 기준으로 commit, **말머리 규칙 지키기!**)
3. 17:20까지 **push & merge** (개인 branch → develop)
4. develop 정상 작동 확인 (한 사람이)
5. 집 가기

- **commit시 말머리 작성**
    - [INITIAL] — repository를 생성하고 최초에 파일을 업로드 할 때
    - [ADD] — 신규 파일 추가
    - [UPDATE] — 코드 변경이 일어날때
    - [REFACTOR] — 코드를 리팩토링 했을때
    - [FIX] — 잘못된 링크 정보 변경, 필요한 모듈 추가 및 삭제
    - [REMOVE] — 파일 제거
    - [STYLE] — 디자인 관련 변경사항
- 오류 해결 case
    
    오류 메시지 : Context initialization failed. Error creating bean with name defined in file 어쩌구…
    
    1. tomcat과 이클립스 메뉴바 > Project 모두 Clean해보기
    2. Package Explorer창에서 해당 프로젝트 우클릭 > Build Path > Configure Build Path > ojdbc8파일 경로가 유실되었으면(뒤에 missing이라 뜸) Edit…버튼 누르고 경로 재설정

- 전반적인 이해에 도움되는 영상!
    
    [https://youtu.be/-27WScuoKQs](https://youtu.be/-27WScuoKQs)
    

[깃 플로우](https://www.notion.so/29609545adce44cb9053f94e91813a69)

---

[]()

[]()

[]()

### DB

- FK(외래키) 대신 Join 사용하기 예시 코드
    
    ```sql
    -- 회원 번호 3번으로 calendar 정보 조회
    select cal_no, cal_title, cal_start_time, m.mem_no
    from calendar c join member m
    on c.mem_no = m.mem_no
    where c.mem_no = 3;
    ```
    
    ```sql
    -- 회원 번호 3번으로 calendar테이블에 insert
    -- 위 select문과 거의 비슷
    insert into calendar values(
    	... , (select distinct c.mem_no from calendar c
    	join member m on c.mem_no = m.mem_no where m.mem_no = 3), ....)
    ```
    
- oracle cloud 전자지갑
    
    1 - 전자지갑(아래 파일) 다운
    
    [wallet.zip](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5ea0388e-72fe-495c-a0cc-2c6a8a57e296/wallet.zip)
    
    2 - SQL Developer > 왼쪽 ‘접속’창에서 +버튼 클릭 > ‘사용자 정보’란에 아래 ID와 PW 입력
    
    <전자지갑(생성자:현우) 계정정보>
    
    ID : ADMIN
    
    PW : KHteam3final
    
    3 - ‘접속유형’에서 ‘클라우드 전자 지갑’ 선택
    
    4 - ‘구성파일’에서 다운받은 전자지갑 경로 찾아 선택(*반드시 압축 풀고 그 폴더 경로로 설정)
    
    5 - 제대로 되는지 테스트 한 번 해보고 접속!
    
- 테이블
    
    ```sql
    member #JiSoo
    -
    mem_no PK number(5) FK >- calendar.mem_no      -- 직원 번호
    mem_name varchar2(20)                          -- 직원 이름
    mem_id varchar2(20)                            -- 직원 아이디
    mem_pwd varchar2(100)                          -- 직원 비밀번호 
    MEM_POSITION varchar2(20)                           -- 직책
    mem_rank varchar2(20)                          -- 직급              
    dept_no number(5)                              -- 부서 번호
    team_no number(5)                              -- 소속 팀 번호
    mem_email varchar2(100)                        -- 직원 이메일
    mem_phone varchar2(11)                         -- 직원 연락처
    
    team #jisoo
    -
    team_no PK number(5) FK >- member.team_no      
    team_name varchar2(20)                         -- 소속 팀 이름     
    
    department #jiSoo
    -
    dept_no PK number(5) FK >- member.dept_no
    dept_name varchar2(20)
    
    ```
    

---

### Design

- **CSS 색상**
    
    색상
    
    메인(강조 색) : #C2F347
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a09135dc-5d78-445e-a7c5-379efeb46621/Untitled.png)
    
    ---
    
    서브(바탕 색) : #E4F7BA
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7b8fe04d-29a2-44ab-bbb8-1c5f06006cf8/Untitled.png)
    
    ---
    
    버튼 배경색 : #7BE66D
    
    버튼 글자색 : #FFFFFF
    
    모서리 굴림 : border-radius: 5px;
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c3ca1e03-d686-439e-a944-b3a356f6b01e/Untitled.png)
    
    ---
    
    선(구역 나눌 때) or 기타 구분색 : #EAEAEA
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0e558c7b-4a0e-4d9a-878e-a38081761b91/Untitled.png)
    

[COWORK로고.zip](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/63898549-20db-46fb-978e-6fb7a7a79dbf/COWORK%EB%A1%9C%EA%B3%A0.zip)

#00C2FF

---

### References

[https://naver.worksmobile.com/feature/overview/](https://naver.worksmobile.com/feature/overview/)

[https://www.kakaowork.com/about](https://www.kakaowork.com/about)

---

### ETC

- 프로그램명 의미
    
    co(coworking + cozy) + work
