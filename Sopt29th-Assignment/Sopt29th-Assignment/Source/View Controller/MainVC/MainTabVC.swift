//
//  MainTabVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/19.
//

import UIKit

import SnapKit
import Then

class MainTabVC: UITabBarController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configVC()
    }
    
    //MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func configVC() {
        let home = setNavigationController(title: "홈",
                                           unselectedImage: Const.Image.home!,
                                           selectedImage: Const.Image.homeFill!,
                                           rootViewController: HomeVC())
        
        let shorts = setNavigationController(title: "Shorts",
                                             unselectedImage: #imageLiteral(resourceName: "shortsIcon"),
                                             selectedImage: #imageLiteral(resourceName: "shortsIconFill"),
                                             rootViewController: ShortsVC())
        
        let add = setNavigationController(title: "추가",
                                          unselectedImage: #imageLiteral(resourceName: "plueCircleIcon"),
                                          selectedImage: #imageLiteral(resourceName: "plueCircleIcon"),
                                          rootViewController: AddVC())
        
        let subscribe = setNavigationController(title: "구독",
                                                unselectedImage: #imageLiteral(resourceName: "subscriptionsIcon"),
                                                selectedImage: #imageLiteral(resourceName: "subscriptionsIconFill"),
                                                rootViewController: SubscribeVC())
        
        let library = setNavigationController(title: "보관함",
                                              unselectedImage: #imageLiteral(resourceName: "LibraryIcon"),
                                              selectedImage: #imageLiteral(resourceName: "LibraryIconFill"),
                                              rootViewController: LibraryVC())
        
        viewControllers = [home, shorts, add, subscribe, library]
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    private func setNavigationController(title: String,
                                 unselectedImage: UIImage,
                                 selectedImage: UIImage,
                                 rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.isHidden = true
        return nav
    }
}
