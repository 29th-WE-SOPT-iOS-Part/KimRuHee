//
//  KeywordCVC.swift
//  Seventh Seminar
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

protocol KeywordCellDelegate: AnyObject {
    func keywordCellSelected(cell: KeywordCVC)
    func keywordCellUnselected(cell: KeywordCVC, unselectedName: String)
}

class KeywordCVC: UICollectionViewCell {
    
    static let id = "KeywordCVC"
    
    weak var keywordDelegate: KeywordCellDelegate?
    
    var presentingClosure: (() -> ())?
    var keyword: String = ""
    var selectedKeyword: Bool = false

    @IBOutlet weak var keywordButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func touchupKeywordButton(_ sender: Any) {
        if selectedKeyword {
            keywordDelegate?.keywordCellUnselected(cell: self, unselectedName: keyword)
            keywordButton.backgroundColor = .clear
        } else {
            keywordDelegate?.keywordCellSelected(cell: self)
            keywordButton.backgroundColor = .black
            presentingClosure?()
        }
        selectedKeyword.toggle()
    }
    
    func setKeyword(text: String) {
        keyword = text
        keywordButton.setTitle(keyword, for: .normal)
    }
}
