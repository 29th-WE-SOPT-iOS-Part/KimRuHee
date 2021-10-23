//
//  PartDataModel.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/23.
//

import UIKit

struct PartData {
    var imageName: String
    var partName: String
    
    func makeImage() -> UIImage? {
        return UIImage(named: imageName)
    }
}
