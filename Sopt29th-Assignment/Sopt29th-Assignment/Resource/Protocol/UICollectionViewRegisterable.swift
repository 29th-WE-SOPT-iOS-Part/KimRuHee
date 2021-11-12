//
//  UICollectionViewRegisterable.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/02.
//

import UIKit

protocol UICollectionViewRegisterable {
    static func register(target: UICollectionView)
}

extension UICollectionViewRegisterable where Self: UICollectionViewCell {
    static func register(target: UICollectionView) {
        target.register(Self.self, forCellWithReuseIdentifier: Self.className)
    }
}
