1. 패키지구조

ROOT
  └ipam_user[사용자관리프로그램이 존재한다.]
     ├css
     ├js
     └import

추가된 프로그램 소스[설명]
ROOT/ipam_user/css/user_style.css
ROOT/ipam_user/js/user_script.js
ROOT/ipam_user/user_template.jsp[메인템플릿으로 GNB/LNB/Footer를 가지고 레이아웃을 결정한다.]
ROOT/ipam_user/user_service.jsp[서비스구현체]
ROOT/ipam_user/user_list.jsp[사용자목록]
ROOT/ipam_user/user_manage.jsp[사용자추가/수정/삭제 화면 및 로직을 관리한다.]


※ ROOT/ipam_user 디렉토리가 기본경로로, 이후 내용에서는 이부분을 제외하고 작성합니다.


2. 클래스다이어그램

범례
┌─────────────────────┐
│ 사용만하는 소스일 경우 │(단, 사용만 한 경우에도 charset은 euc-kr로 수정함)
└─────────────────────┘
------------------
 작업한 소스일 경우
------------------



┌────────────────────┐
│import/ipam_init.jsp│
└────────────────────┘
  △[include]
-----------------
user_template.jsp
-----------------



┌────────────────────┐
│import/ipam_init.jsp│
└────────────────────┘
  △[include]
┌───────────────────────┐
│import/DBConnection.jsp│
└───────────────────────┘
  △[include]
----------------
user_service.jsp
----------------
  △[include]
-------------
user_list.jsp
-------------




┌────────────────────┐
│import/ipam_init.jsp│
└────────────────────┘
  △[include]
┌───────────────────────┐
│import/DBConnection.jsp│
└───────────────────────┘
  △[include]
----------------
user_service.jsp
----------------
  △[include]
---------------
user_manage.jsp
---------------





3. 프로그램설명

user_service.jsp 는 현 프로그램의 서비스구현을 맡고있다.
SQL 부터 Utility, new CLASS 까지 비지니스처리를 모두 담당한다.
DB 연결을 위해 DBConnection.jsp 를 include 하였다.

user_template.jsp 에서는 레이아웃만 구성하고 있다.
서비스적인 부분이 없어서 ipam_init.jsp 만 include 한다.
┌───────────────────────┐
│          GNB          │
├───┬───────────────────┤
│   │                   │
│ L │     --------      │
│ N │     CONTENTS      │
│ B │     --------      │
│   │                   │
├───┴───────────────────┤
│         FOOTER        │
└───────────────────────┘
GNB, LNB, FOOTER 영역의 내용을 template에서 가지나,
일부 CONTENTS 상단 부분도 가지고 있다.

user_list.jsp 에서는 CONTENTS 영역의 실제 사용자목록 화면을 가진다.
또한, 사용자목록을 가져오는 서비스를 호출하는 로직도 가진다.

user_manage.jsp 에서는 사용자 추가/수정 화면이 있고,
특정 파라미터 정보에 따라서, 사용자 추가/수정 및 삭제하는 서비스를 호출하기도 한다.




