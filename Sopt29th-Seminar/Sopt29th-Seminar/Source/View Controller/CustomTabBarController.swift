//
//  CustomTabBarController.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/09.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }
    
    func setTabBar() {
        guard let orangeVC = self.storyboard?.instantiateViewController(withIdentifier: "OrangeVC"),
              let purpleVC = self.storyboard?.instantiateViewController(withIdentifier: "PurpleVC")
        else { return }
        
        orangeVC.tabBarItem.title = "Home"
        orangeVC.tabBarItem.image = UIImage(systemName: "house")
        orangeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        purpleVC.tabBarItem.title = "Profile"
        purpleVC.tabBarItem.image = UIImage(systemName: "person")
        purpleVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        
        setViewControllers([orangeVC, purpleVC], animated: true)

    }

}
