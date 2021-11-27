//
//  GestureVC.swift
//  Seventh Seminar
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class GestureVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(mainView(gestureRecognizer:)))
        
        let tapRecognizer2 = UITapGestureRecognizer()
        tapRecognizer2.addTarget(self, action: #selector(mainView(gestureRecognizer:)))
        
        mainView.addGestureRecognizer(tapRecognizer)
    }
 
    @objc func mainView(gestureRecognizer: UIGestureRecognizer) {
        print("뷰안에탭")
    }
    
    
}
