//
//  Video.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/01.
//

import UIKit

struct Video {
    var thumbnail: String
    var title: String
    var sub: String
    
    func makeImage() -> UIImage? {
        return UIImage(named: thumbnail)
    }
}

class VideoData {
    var list: [Video]
    
    init() {
        self.list = [Video(thumbnail: Const.Image.isfp,
                           title: "극강의 E들 사이에서 살아남는 I (NextLevel, 오리날다, ASAP)",
                           sub: "비디터 Viditor ・조회수 174만회 ・ 4주 전"),
                     Video(thumbnail: Const.Image.monstarx,
                           title: "동글동글말티쥬 : 개웃긴 대유잼 그룹 몬스타엑스 대유잼 모음",
                           sub: "MONSTARX ・조회수 1000만회 ・ 3주 전"),
                     Video(thumbnail: Const.Image.cocomoo,
                           title: "[꼬꼬무 4회 요약] : 연쇄살인마 엄여인은 누구인가, 꼬리에 꼬리를 무는 그날의 이야기 (SBS 방송)",
                           sub: "달리 ・조회수 85만회 ・ 2주 전"),
                     Video(thumbnail: Const.Image.hochang,
                           title: "[Live] : 이창호와 함께하는 Study with 이호창",
                           sub: "빵송국 ・조회수 10만회 ・ 1주 전"),
                     Video(thumbnail: Const.Image.playlist,
                           title: "[Playlist] BennySings와 런던에서의 아침 산책",
                           sub: "리플레이LEEPLAY ・조회수 28만회 ・ 5일 전"),
                     Video(thumbnail: Const.Image.aespa,
                           title: "에스파(aespa) - Next Level 교차편집(stage mix)",
                           sub: "SM Entertainment ・조회수 974만회 ・ 1일 전")]
    }
}
