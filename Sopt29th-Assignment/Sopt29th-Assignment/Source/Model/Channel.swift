//
//  Channel.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/01.
//

import UIKit

struct Channel {
    var name: String
    var imageName: String
    
    func makeImage() -> UIImage? {
        return UIImage(named: imageName)
    }
}

class ChannelData {
    var list: [Channel]
    
    init() {
        self.list = [Channel(name: "RUHEE", imageName: Const.Image.ggamju1),
                     Channel(name: "HUREE", imageName: Const.Image.ggamju2),
                     Channel(name: "MONSTARX", imageName: Const.Image.ggamju3),
                     Channel(name: "GGAMJU", imageName: Const.Image.ggamju4),
                     Channel(name: "SO_CUTE", imageName: Const.Image.ggamju5),
                     Channel(name: "HEERUCAN", imageName: Const.Image.ggamju6),
                     Channel(name: "APPLE", imageName: Const.Image.ggamju7),
                     Channel(name: "ZZANG", imageName: Const.Image.ggamju8)]
    }
}
