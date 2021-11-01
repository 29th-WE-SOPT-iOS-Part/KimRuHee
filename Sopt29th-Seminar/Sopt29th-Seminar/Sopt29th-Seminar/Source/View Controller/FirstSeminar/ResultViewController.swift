//
//  ResultViewController.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/02.
//

import UIKit

class ResultViewController: UIViewController {
    
    var message: String?

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMessageInLabel()
    }
    
    func setMessageInLabel() {
        if let text = message {
            resultLabel.text = text
        }
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
