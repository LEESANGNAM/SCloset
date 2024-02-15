# SClooset

### 실행화면
<p>
<!-- [회원가입화면]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/1431c5b0-7288-424a-bad5-514f5ec72b30" width="20%"/>  
<!-- [로그인화면]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/b2f85511-9965-410c-9ed0-b9299ecd2875" width="20%"/>  
<!-- [스타일리스트]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/664d2d39-a245-4a68-af6f-a413f914ba5b" width="20%"/>  
<!-- [스타일리스트_리프레시]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/f76b43ac-d27b-4a61-b31d-74856eeba5fb" width="20%"/>   
<!-- gif -->  
</p>

<p>
<!-- [글쓰기]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/bcd1dc66-af0a-448e-a1f3-0d0f8cffc829" width="20%"/>  
<!-- [게시글_리프레시]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/08618468-5b6b-449a-9096-cb97c9ed2be5" width="20%"/>  
<!-- [게시글_좋아요댓글_내용수정]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/7f4a8e5e-4a13-43b4-8bec-1e569533d4f9" width="20%"/>  
<!-- [동적높이테이블뷰]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/662ab1ca-368d-4daa-a586-0efde8e09bc2" width="20%"/>   
<!-- gif -->
</p>

<p>
<!-- [마이페이지_나의게시글_스크롤전]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/153b0fed-f747-4e30-bc7e-c8215bb0a561" width="20%"/>  
<!-- [마이페이지_스크롤후]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/56075d5a-7673-4f4a-8de7-6aa35495b557" width="20%"/>  
<!-- [마이페이지_좋아요게시글]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/fdaf9646-cd8a-44e6-9a9d-e23a841c6e16" width="20%"/>  
<!-- [이중스크롤]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/1b380ca9-e340-428a-9e73-a1e77703edad" width="20%"/>  
<!-- gif -->
</p>


 




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


