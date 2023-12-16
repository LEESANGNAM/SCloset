//
//  TabManViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit
import Tabman
import Pageboy

class TabManViewController: TabmanViewController {
    let baseView = UIView()
    
    private var ViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabMan()
    }
    private func setTabMan(){
        ViewControllers.append(MyPostViewController())
        ViewControllers.append(MyLikePostViewController())
        
        self.dataSource = self
        
        view.addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let bar = TMBar.ButtonBar()
        // 배경 회색으로 나옴 -> 하얀색으로 바뀜
        bar.backgroundView.style = .blur(style: .light)
        // 간격 설정
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        // 버튼 글씨 커스텀
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        // 밑줄 쳐지는 부분
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .custom(view: baseView, layout: nil))
    }
    
}

extension TabManViewController: TMBarDataSource, PageboyViewControllerDataSource{
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "나의 게시글")
        case 1:
            return TMBarItem(title: "좋아요 한 게시글")
        default:
            return TMBarItem(title: "")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return ViewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return ViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        nil
    }
    

    
    
}
