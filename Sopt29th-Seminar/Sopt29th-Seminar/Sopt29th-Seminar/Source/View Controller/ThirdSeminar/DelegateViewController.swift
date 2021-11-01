//
//  DelegateViewController.swift
//  Sopt29th-Seminar
//
//  Created by Thisisme Hi on 2021/10/23.
//

import UIKit

class DelegateViewController: UIViewController {
    
    var partList: [PartData] = []
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var partImageView: UIImageView!
    @IBOutlet weak var partPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPartData()
        initPartLayout()
        setTextField()
        setPickerView()
    }
    
    func setTextField() {
        dataTextField.delegate = self
    }
    
    func setPickerView() {
        partPickerView.delegate = self
        partPickerView.dataSource = self
    }
    
    func initPartLayout() {
        partImageView.image = partList[0].makeImage()
        dataTextField.text = partList[0].partName
    }
    
    func initPartData(){
        partList.append(contentsOf: [
            PartData(imageName: "wesoptiOSPart", partName: "iOS"),
            PartData(imageName: "wesoptAndroidPart", partName: "Android"),
            PartData(imageName: "wesoptWebPart", partName: "Web"),
            PartData(imageName: "wesoptServerPart", partName: "Server"),
            PartData(imageName: "wesoptDesignPart", partName: "Design"),
            PartData(imageName: "wesoptPlanPart", partName: "Plan")
        ])
    }
}

// MARK: - UITextFieldDelegate
extension DelegateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("편집 시작")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("편집 끝")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return 키 누름")
        dataTextField.endEditing(true)
        return true
    }
}

// MARK: - UIPickerViewDelegate
extension DelegateViewController: UIPickerViewDelegate {
    // 각 행의 타이틀을 지정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return partList[row].partName
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        partImageView.image = partList[row].makeImage()
        dataTextField.text = partList[row].partName
    }
}

// MARK: - UIPickerViewDataSource
extension DelegateViewController: UIPickerViewDataSource {
    // 컴포넌트의 숫자를 지정하는 메소드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 각 컴포넌트의 행을 지정하는 메소드
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return partList.count
    }
}
