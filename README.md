# SClooset

### 실행화면
<p>
<!-- [회원가입화면]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/1431c5b0-7288-424a-bad5-514f5ec72b30" width="22%"/>  
<!-- [로그인화면]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/b2f85511-9965-410c-9ed0-b9299ecd2875" width="22%"/>  
<!-- [스타일리스트]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/664d2d39-a245-4a68-af6f-a413f914ba5b" width="22%"/>  
<!-- [스타일리스트_리프레시]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/f76b43ac-d27b-4a61-b31d-74856eeba5fb" width="22%"/>   
<!-- gif -->  
</p>

<p>
<!-- [글쓰기]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/bcd1dc66-af0a-448e-a1f3-0d0f8cffc829" width="22%"/>  
<!-- [게시글_리프레시]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/08618468-5b6b-449a-9096-cb97c9ed2be5" width="22%"/>  
<!-- [게시글_좋아요댓글_내용수정]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/7f4a8e5e-4a13-43b4-8bec-1e569533d4f9" width="22%"/>  
<!-- [동적높이테이블뷰]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/93e81805-3cbc-4f13-81c2-e2c26ec605df" width="22%"/>   
<!-- gif -->
</p>

<p>
<!-- [마이페이지_나의게시글_스크롤전]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/153b0fed-f747-4e30-bc7e-c8215bb0a561" width="22%"/>  
<!-- [마이페이지_스크롤후]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/56075d5a-7673-4f4a-8de7-6aa35495b557" width="22%"/>  
<!-- [마이페이지_좋아요게시글]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/fdaf9646-cd8a-44e6-9a9d-e23a841c6e16" width="22%"/>  
<!-- [이중스크롤]  -->
<img src = "https://github.com/LEESANGNAM/SCloset/assets/61412496/1b380ca9-e340-428a-9e73-a1e77703edad" width="22%"/>  
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

### WeatherKit, 사용자 위치와 기온정보
[사용법](https://sangnam2.tistory.com/entry/1129-위젯)
+ 앱을 사용할 때 사용자의 위치와 기온을 유지 시킬 필요가 있다고 생각 되어 데이터 모델을 생성하고, 싱글톤패턴을 이용하여 앱을 사용하는동안 정보를 유지시켰다.
~~~ swift 
struct TodayWeatherModel {
    let date : String
    let location: String
    let highTemperature: Measurement<UnitTemperature>
    let lowTemperature: Measurement<UnitTemperature>
    let symbolName: String
    
    
    var temperatureString: String {
        return "\(lowTemperature) / \(highTemperature)"
    }
    
}
~~~
~~~ swift 
class WeatherManager: NSObject {
    static let shared = WeatherManager()
    private var currentLocation: CLLocation?
    private var currentWeather: TodayWeatherModel?
    private var locationName = ""

     private func fetchCurrentWeather() {
         Task {
            do {
                let result = try await WeatherService().weather(for: location)
                guard let weather = result.dailyForecast.forecast.first else { return }
                ...
                currentWeather = todayWeather
            }
         }
     }
     private func fetchAddressNameAndWeather() {
        guard let location = currentLocation else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error {
                print("Geocoding 실패: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                self.locationName = self.getAddressName(placemark: placemark)
                self.fetchCurrentWeather()
            } else {
                print("placemarks 실패")
            }
        }
    }
    private func getAddressName(placemark: CLPlacemark) -> String {
        var result = ""
        guard let administrativeArea = placemark.administrativeArea,
              let locality = placemark.locality,
              let subLocality = placemark.subLocality else { return "" }
        
        if administrativeArea == "서울특별시" {
            result = "\(locality) \(subLocality)"
        } else {
            result = "\(administrativeArea) \(locality) \(subLocality)"
        }
        return result
    }
}
~~~

### dynamic height tableView
댓글 창을 구현하면서 컨텐츠에 따라 높이가 늘어나는 뷰가 필요했다.
+ selfSize TableView를 생성
+ TableView 스크롤막기
+ stackView에 넣기
+ 스크롤뷰에 넣기

~~~ swift 
class SelfSizingTableView: UITableView {
  override var intrinsicContentSize: CGSize {
    contentSize
  }
  
  override func layoutSubviews() {
    invalidateIntrinsicContentSize()
    super.layoutSubviews()
  }
}
~~~

~~~ swift 
class StyleDetailView: BaseView {
let commentTableView = {
        let view = SelfSizingTableView()
        view.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        view.allowsSelection = false
        view.rowHeight = UITableView.automaticDimension
        view.isScrollEnabled = false
        view.estimatedRowHeight = 120
        return view
    }()
    lazy var commentStackView = {
       let view = UIStackView(arrangedSubviews: [commentTableView])
        view.axis = .vertical
        return view
    }()
}
~~~
### netstedScroll (이중스크롤)
+ 스크롤 될때 isScrollEnabled를 변경 했더니 스크롤이 끊기는 현상이 발생
+ 각 스크롤뷰의 contentOffset을 조절하는방식으로 해결 
~~~ swift 
class MyInfoView: BaseView {
    var innerScrollView: UIScrollView? {
            if let currentTabmanMyPostVC = tabmanVC.currentViewController as? MyPostViewController {
                return currentTabmanMyPostVC.collectionView
            } else if let currentTabmanMyLikePostVC = tabmanVC.currentViewController as? MyLikePostViewController{
                return currentTabmanMyLikePostVC.collectionView
            } else {
                return nil
            }
        }
}
~~~

~~~ swift 
class MyInfoViewController: UIScrollViewDelegate {
    var innerScrollingDownDueToOuterScroll = false //외부스크롤뷰 로인한 내부스크롤여부

    private enum Policy {
        static let floatingPointTolerance = 0.1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // ex) more scroll: 손가락을 아래에서 위로 
        
        guard let innerScrollView = mainView.innerScrollView else {
            return
        }
        
        // 스크롤되는 뷰의 위치
        let outerScroll = mainView.outerScrollView == scrollView
        let innerScroll = !outerScroll 
        // 스크롤되는 방향
        let moreScroll = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 
        let lessScroll = !moreScroll 
        
        let outerScrollView = mainView.outerScrollView
        // outer scroll이 스크롤 할 수 있는 최대값 (헤더뷰의 값)
        let outerScrollMaxOffsetY = outerScrollView.contentSize.height - outerScrollView.frame.height + 80
        let innerScrollMaxOffsetY = innerScrollView.contentSize.height - innerScrollView.frame.height
        
        // 1. outer scroll을 more 스크롤
        // 만약 outer scroll을 more scroll 다 했으면, inner scroll을 more scroll
        if outerScroll && moreScroll {
            guard outerScrollMaxOffsetY < outerScrollView.contentOffset.y + Policy.floatingPointTolerance else { return }
            innerScrollingDownDueToOuterScroll = true
            defer { innerScrollingDownDueToOuterScroll = false }
            
            // innerScrollView를 모두 스크롤 한 경우 stop
            guard innerScrollView.contentOffset.y < innerScrollMaxOffsetY else { return }
            innerScrollView.contentOffset.y = innerScrollView.contentOffset.y + outerScrollView.contentOffset.y - outerScrollMaxOffsetY
            outerScrollView.contentOffset.y = outerScrollMaxOffsetY
            
        }
        
        // 2. outer scroll을 less 스크롤
        // 만약 inner scroll이 less 스크롤 할게 남아 있다면 inner scroll을 less 스크롤
        if outerScroll && lessScroll {
            guard innerScrollView.contentOffset.y > 0 && outerScrollView.contentOffset.y < outerScrollMaxOffsetY else { return }
            innerScrollingDownDueToOuterScroll = true
            defer { innerScrollingDownDueToOuterScroll = false }
            
            // outer scroll에서 스크롤한 만큼 inner scroll에 적용
            innerScrollView.contentOffset.y = max(innerScrollView.contentOffset.y - (outerScrollMaxOffsetY - outerScrollView.contentOffset.y), 0)
            
            // outer scroll은 스크롤 되지 않고 고정
            
            outerScrollView.contentOffset.y = outerScrollMaxOffsetY
        }
        
        // 3. inner scroll을 less 스크롤
        // inner scroll을 모두 less scroll한 경우, outer scroll을 less scroll
        if innerScroll && lessScroll {
            defer { innerScrollView.lastOffsetY = innerScrollView.contentOffset.y }
            guard innerScrollView.contentOffset.y < 0 && outerScrollView.contentOffset.y > 0 else { return }
            
            // innerScrollView의 bounces에 의하여 다시 outerScrollView가 당겨질수 있으므로 bounces로 다시 되돌아가는 offset 방지
            guard innerScrollView.lastOffsetY > innerScrollView.contentOffset.y else { return }
            
            let moveOffset = outerScrollMaxOffsetY - abs(innerScrollView.contentOffset.y) * 3
            guard moveOffset < outerScrollView.contentOffset.y else { return }
            
            outerScrollView.contentOffset.y = max(moveOffset, 0)
        }
        
        // 4. inner scroll을 more 스크롤
        // outer scroll이 아직 more 스크롤할게 남아 있다면, innerScroll을 그대로 두고 outer scroll을 more 스크롤
        if innerScroll && moreScroll {
            guard
                outerScrollView.contentOffset.y + Policy.floatingPointTolerance < outerScrollMaxOffsetY,
                !innerScrollingDownDueToOuterScroll
            else { return }
            // outer scroll를 more 스크롤
            let minOffetY = min(outerScrollView.contentOffset.y + innerScrollView.contentOffset.y, outerScrollMaxOffsetY)
            let offsetY = max(minOffetY, 0)
            outerScrollView.contentOffset.y = offsetY
            
            // inner scroll은 스크롤 되지 않아야 하므로 0으로 고정
            innerScrollView.contentOffset.y = 0
        }
        
        // todo: scroll to top 시, inner scroll도 top으로 스크롤
    }
}

private struct AssociatedKeys {
    static var lastOffsetY = "lastOffsetY"
}

extension UIScrollView {
    var lastOffsetY: CGFloat {
        get {
            (objc_getAssociatedObject(self, &AssociatedKeys.lastOffsetY) as? CGFloat) ?? contentOffset.y
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.lastOffsetY, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


~~~
