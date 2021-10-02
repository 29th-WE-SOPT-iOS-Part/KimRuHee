//
//  SecondViewController.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/02.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.presentingViewController!.dismiss(animated: false, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
