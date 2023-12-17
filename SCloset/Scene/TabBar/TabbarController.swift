//
//  TabbarController.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import UIKit

class TabbarController: UITabBarController {
    let StyleVC = UINavigationController(rootViewController: StyleListViewController())
    let MyInfoVC = UINavigationController(rootViewController: MyInfoViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [StyleVC,MyInfoVC]
        setupTabbar()
    }
    
    private func setupTabbar(){
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .white
        setupTabbarItem()
    }
    
    private func setupTabbarItem(){
        StyleVC.tabBarItem = UITabBarItem(title: "스타일", image: UIImage(systemName: "tshirt.fill"), tag: 0)
        MyInfoVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)
    }
    
    
}
