//
//  SecondVC.swift
//  Seventh Seminar
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class SecondVC: UIViewController {
    
    // MARK: - Identifier & Property
    
    static let id = "SecondVC"
    
    var receivedText = ""
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = receivedText
    }
    
    // MARK: - @IBAction
    
    @IBAction func touchUpToSendData(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("iOSSample"), object: textField.text ?? "")
        let presentingVC = presentingViewController as? ViewController
        presentingVC?.textField.text = textField.text
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Custom Method
    
    func setDataInTextField(data: String) {
        textField.text = data
    }
}
