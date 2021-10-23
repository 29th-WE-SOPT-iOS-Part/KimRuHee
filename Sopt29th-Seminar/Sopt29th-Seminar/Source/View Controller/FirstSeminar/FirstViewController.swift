//
//  FirstViewController.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/02.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func toupUpNextButton(_ sender: UIButton) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController
        else { return }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.message = textField.text
        self.present(nextVC, animated: true, completion: nil)
    }
    
}
