//
//  ProfileSetUpVC.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 13/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit
import AVFoundation



protocol ToolbarPickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

class ToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func doneTapped() {
        self.toolbarDelegate?.didTapDone()
    }

    @objc func cancelTapped() {
        self.toolbarDelegate?.didTapCancel()
    }
}

// City

protocol cityToolbarPickerViewDelegate: class {
    func citydidTapDone()
    func citydidTapCancel()
}

class cityToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: cityToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.citydoneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.citycancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func citydoneTapped() {
        self.toolbarDelegate?.citydidTapDone()
    }

    @objc func citycancelTapped() {
        self.toolbarDelegate?.citydidTapCancel()
    }
}


// MAEK: AREA LISR

protocol areaToolbarPickerViewDelegate: class {
    func areadidTapDone()
    func areadidTapCancel()
}

class areaToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: areaToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.areadoneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.areacancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func areadoneTapped() {
        self.toolbarDelegate?.areadidTapDone()
    }

    @objc func areacancelTapped() {
        self.toolbarDelegate?.areadidTapCancel()
    }
}



class ProfileSetUpVC: UIViewController {
    
    
    @IBOutlet weak var NametextFiled: UITextField!
    @IBOutlet weak var stateTextFiled: UITextField!
    @IBOutlet weak var cityTextFiled: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
   fileprivate let pickerView = ToolbarPickerView()
    fileprivate let cityPickerpickerView = cityToolbarPickerView()
    fileprivate let areaPickerpickerView = areaToolbarPickerView()

    var stateArraya:[StateDatum] = []
    var cityArrayaData:[CityCodeResponces] = []
    var areaArryaList:[AreaDatum] = []
    
    var stateId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         stateList()
        self.stateTextFiled.inputView = self.pickerView
        self.stateTextFiled.inputAccessoryView = self.pickerView.toolbar
        
        //StatePicker
        
        self.cityTextFiled.inputView = self.cityPickerpickerView
        self.cityTextFiled.inputAccessoryView = self.cityPickerpickerView.toolbar
        
        // Areapcker
        
        self.areaTextField.inputView = self.areaPickerpickerView
        self.areaTextField.inputAccessoryView = self.areaPickerpickerView.toolbar
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
        
        // CityPicker
        
        self.cityPickerpickerView.dataSource = self
        self.cityPickerpickerView.delegate = self
        self.cityPickerpickerView.toolbarDelegate = self
        self.cityPickerpickerView.reloadAllComponents()
        
        // Area Picker
        
        self.areaPickerpickerView.dataSource = self
        self.areaPickerpickerView.delegate = self
        self.areaPickerpickerView.toolbarDelegate = self
        self.areaPickerpickerView.reloadAllComponents()
        
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func skipeButton(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        
        
    }
    
    func stateList(){
        
        ApiClient.loder(roughter: APIRouter.stateLis) { (stateResponce:StateResponce) in
            
            print("\(stateResponce)")
            
            if stateResponce.statusCode == 201 {
                
                self.stateArraya.append(contentsOf: stateResponce.stateData ?? [])
            }else {
                
                Utility.showAlert(withMessage: stateResponce.message ?? "", onController: self)

            }
            
        }
    }
}






extension ProfileSetUpVC: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      //  return self.stateArraya.count
        
        if pickerView == cityPickerpickerView{
            return self.cityArrayaData.count

            
        } else if pickerView == areaPickerpickerView {
            return self.areaArryaList.count

        }
        
        return self.stateArraya.count

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == cityPickerpickerView{
            
            return self.cityArrayaData[row].name

        } else if pickerView == areaPickerpickerView {
            return self.areaArryaList[row].name
        }
        return self.stateArraya[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == cityPickerpickerView{
            
            self.cityTextFiled.text = self.cityArrayaData[row].name
        } else if pickerView == areaPickerpickerView {
            
            self.cityTextFiled.text = self.areaArryaList[row].name

        }
        self.stateTextFiled.text = self.stateArraya[row].name
    }
}

extension ProfileSetUpVC: ToolbarPickerViewDelegate,cityToolbarPickerViewDelegate,areaToolbarPickerViewDelegate{
    func areadidTapDone() {
        let rows = self.areaPickerpickerView.selectedRow(inComponent: 0)
        self.areaPickerpickerView.selectRow(rows, inComponent: 0, animated: false)
        self.areaTextField.text = self.areaArryaList[rows].name
        self.areaTextField.resignFirstResponder()
        
    }
    
    func areadidTapCancel() {
        self.areaTextField.text = nil
        self.areaTextField.resignFirstResponder()
    }
    
    func citydidTapDone() {
        let rows = self.cityPickerpickerView.selectedRow(inComponent: 0)
        self.cityPickerpickerView.selectRow(rows, inComponent: 0, animated: false)
        self.cityTextFiled.text = self.cityArrayaData[rows].name
        self.cityTextFiled.resignFirstResponder()
        areaList(stateId: stateId, cityid: "\(self.cityArrayaData[rows].id ?? 0)")

    }
    
    func citydidTapCancel() {
        self.cityTextFiled.text = nil
        self.cityTextFiled.resignFirstResponder()
    }
    
    
    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.stateTextFiled.text = self.stateArraya[row].name
        self.stateTextFiled.resignFirstResponder()
        
       stateId = "\(self.stateArraya[row].id ?? 0)"
        
        //
        stateCode(StateCode: "\(self.stateArraya[row].id ?? 0)")
    }
    
    func didTapCancel() {
        self.stateTextFiled.text = nil
        self.stateTextFiled.resignFirstResponder()
        
       
    }
    
    
    func stateCode(StateCode:String){
        ApiClient.loder(roughter:APIRouter.cityList(stateCode: StateCode)) { (cityList:CityCodeResponce) in
            print("\(cityList)")
            if cityList.statusCode == 201 {
                self.cityArrayaData.append(contentsOf: cityList.cityData ?? [])
            }else {
                Utility.showAlert(withMessage: cityList.message ?? "", onController: self)
            }
        }
    }
    
    // AREA API
    func areaList(stateId:String,cityid:String){
        
        ApiClient.loder(roughter: APIRouter.areaList(stateId: stateId, cityId: cityid)) { (areaResponce:AreaResponce) in
            
            print("123\(areaResponce)")
            
            if areaResponce.statusCode == 201{
                self.areaArryaList.append(contentsOf: areaResponce.areaData ?? [])
                
            }else {
                
                Utility.showAlert(withMessage: areaResponce.message ?? "", onController: self)
                
            }
        }
    }
}






