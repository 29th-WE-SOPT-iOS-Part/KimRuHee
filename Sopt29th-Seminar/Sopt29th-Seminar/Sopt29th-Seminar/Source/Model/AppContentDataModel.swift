//
//  AppContentDataModel.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/23.
//

import UIKit

struct AppContentData{
    let appName: String
    let description: String
    let appIconName: String
    
    func makeImage() -> UIImage? {
        return UIImage(named: appIconName)
    }
}
