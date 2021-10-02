//
//  ViewController.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hungryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hungryButton(_ sender: UIButton) {
        hungryLabel.text = "종로불돼지가 너무너무 먹고 시퍼!!"
        hungryLabel.sizeToFit()
    }
    
    @IBAction func touchUpNextButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
//        nextVC.modalPresentationStyle = .fullScreen
//        nextVC.modalTransitionStyle = .partialCurl
//        self.present(nextVC, animated: true, completion: nil)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

