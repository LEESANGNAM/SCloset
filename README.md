# SClooset

### 실행화면


### 간단소개
사용자가 입은 스타일과 지역의 기온 공유 할 수 있는 어플리케이션

## 개발기간
+ 개인프로젝트
+ 2023.11.22 ~ 2024.1.3 (6주)
## 최소타겟
+ iOS 16.0

## 기술스택
+ MVVM,RXSwift
+ UIKit,
+ SnapKit, AutoLayout
+ Kingfisher, Tabman, Toast, Alamofire
+ WeatherKit

## 기능소개
### 회원가입,로그인
+ 이메일 유효성검사 api 를 통해 사용가능한 이메일인지 확인 후 회원가입을 가능하게 했다.

### JWT 토큰관리
+ **Alamofire Intercepter** 를 이용해서 에러코드에 따라 토큰을 갱신하거나 다시 로그인하게 했다.

### 게시글작성 및 조회, 댓글
+ **refreshControl** 을 이용해 게시글목록과, 게시글의 최신 정보를 확인 할 수 있다.
+ **PHPicker** 로 앨범의 사진을 업로드 해서 게시글 작성과 수정을 할 수 있다.
+ **WeatherKit** 을 통해 지역과 날씨를 자동으로 입력되게 했다.
+ **dynamic height tableView** 을 구현하여 댓글을 한 화면에서 볼 수 있다.
### 마이페이지
+ **Tabman** 을 사용해 작성한 글과 좋아요한 글을 카테고리별로 나눠 볼 수 있다.
+ **netstedScroll** 을 구현하여 프로필을 제외한 컨텐츠를 한 화면에서 볼 수 있다.
+ 프로필 수정과 로그아웃이 가능하다.

## 트러블슈팅

### 웨더킷

### dynamic height tableView

### netstedScroll (이중스크롤)


