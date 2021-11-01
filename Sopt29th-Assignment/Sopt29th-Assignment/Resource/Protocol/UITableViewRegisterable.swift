//
//  UITableViewRegisterable.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/02.
//

import UIKit

protocol UITableViewRegisterable {
    static func register(target: UITableView)
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static func register(target: UITableView) {
        target.register(Self.self, forCellReuseIdentifier: Self.className)
    }
}

