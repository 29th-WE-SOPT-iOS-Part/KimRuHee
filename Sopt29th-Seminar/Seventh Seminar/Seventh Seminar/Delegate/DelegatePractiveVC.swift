//
//  DelegatePractiveVC.swift
//  Seventh Seminar
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class DelegatePractiveVC: UIViewController {
    
    var nameList = [String]()
    var selectedNameList = [String]()
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var mainCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        initDataList()
    }
    
    func setupCollectionView() {
        let nibName = UINib(nibName: KeywordCVC.id, bundle: nil)
        mainCV.register(nibName, forCellWithReuseIdentifier: KeywordCVC.id)
        mainCV.dataSource = self
    }
    
    func initDataList(){
        nameList.append(contentsOf: ["김루희","김선영","김소연","김수연","김승찬","김윤서","김인환",
                                     "김지수","김태현","김현규","김혜수","박예빈","박익범","배은서",
                                     "송지훈","신윤아","안현주","양수빈","이경민","이남준","이유진",
                                     "이준호","임주민","장혜령","정은희","정정빈","조양원","최은주",
                                     "최이준","홍승현","황지은"])
    }
}

extension DelegatePractiveVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCVC.id, for: indexPath) as? KeywordCVC else { return UICollectionViewCell() }
        cell.setKeyword(text: nameList[indexPath.row])
        cell.keywordDelegate = self
        return cell
        
    }
}

extension DelegatePractiveVC: KeywordCellDelegate {
    func keywordCellSelected(cell: KeywordCVC) {
        selectedNameList.append(cell.keyword)
        updateWarningLabel()
    }
    
    func keywordCellUnselected(cell: KeywordCVC, unselectedName: String) {
        let deleteIndex = selectedNameList.firstIndex(of: unselectedName) ?? -1
        selectedNameList.remove(at: deleteIndex)
        updateWarningLabel()
    }
    
    func updateWarningLabel() {
        warningLabel.text = "\(selectedNameList.count)명이 선택됐다"
        warningLabel.textColor = selectedNameList.count > 8 ? .systemPink : .black
    }
    
}
