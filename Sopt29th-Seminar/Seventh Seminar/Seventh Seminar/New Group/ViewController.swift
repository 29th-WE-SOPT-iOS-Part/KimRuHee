//
//  ViewController.swift
//  Seventh Seminar
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Identifier & Property
    
    static let id = "ViewController"

    // MARK: - @IBOutlet

    @IBOutlet weak var textField: UITextField!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - @IBAction

    @IBAction func sendButton(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: SecondVC.id) as? SecondVC else { return }
        nextVC.receivedText = textField.text ?? ""
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataReceived),
                                               name: NSNotification.Name("iOSSample"),
                                               object: nil)
        
        present(nextVC, animated: true, completion: nil)
        
//        performSegue(withIdentifier: "presentSecondVC", sender: sender)
    }
    
    // MARK: - Custom Method

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentSecondVC" {
            let nextVC = segue.destination as? SecondVC
            nextVC?.receivedText = textField.text ?? ""
        }
    }
    
    @objc func dataReceived(notification: Notification) {
        if let text = notification.object as? String {
            textField.text = text
        }
    }
}
