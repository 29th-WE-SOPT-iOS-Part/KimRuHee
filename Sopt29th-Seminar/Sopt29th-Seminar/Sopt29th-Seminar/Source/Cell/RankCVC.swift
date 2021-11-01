//
//  RankCVC.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/23.
//

import UIKit

class RankCVC: UICollectionViewCell {
    static let identifier = "RankCVC"
    
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    
    func setData(appName: String, appImage: UIImage?) {
        appLabel.text = appName
        appImageView.image = appImage
    }
    
}
