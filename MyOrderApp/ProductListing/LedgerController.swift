//  LedgerController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit

class LedgerController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textFieldSearchLedger: UITextField!
    @IBOutlet var textFieldFrom: UITextField!
    @IBOutlet var textFieldTo: UITextField!
    @IBOutlet var dropDownButton: UIButton!
    var pickerViewLedger = UIPickerView()
    var tablleViewList = UITableView()
    var arrayLedgerData = [String]()
    var toolBar = UIToolbar()
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var selectedValue = ""
    var AgeLimit = 0
    var formatter: DateFormatter!
    var keyboardToolbarDate: UIToolbar!
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true

        textFieldSearchLedger.delegate = self
        textFieldFrom.delegate = self
        textFieldTo.delegate = self
        
        textFieldSearchLedger.layer.borderColor = UIColor.gray.cgColor
        textFieldSearchLedger.layer.borderWidth = 1
        textFieldSearchLedger.layer.cornerRadius = 10
        textFieldSearchLedger.clipsToBounds = true
        
        textFieldFrom.layer.borderColor = UIColor.gray.cgColor
        textFieldFrom.layer.borderWidth = 1
        textFieldFrom.layer.cornerRadius = 10
        textFieldFrom.clipsToBounds = true
        textFieldFrom.delegate = self

        textFieldTo.layer.borderColor = UIColor.gray.cgColor
        textFieldTo.layer.borderWidth = 1
        textFieldTo.layer.cornerRadius = 10
        textFieldTo.clipsToBounds = true

        arrayLedgerData = ["A Ledger","B Ledger","C Ledger", "D ledger"]
        
        //createPicker()
        self.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
        
//        //Create a DatePicker
//        datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        //Position date picker within a view
//        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
//        //Set Mode for Picker
//        datePicker.datePickerMode = .dateAndTime
//        //Set some of UIDatePicker properties
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.backgroundColor = UIColor.white
//        //Set minimum and Maximum Dates
//        let calendar = Calendar(identifier: .gregorian)
//        var comps = DateComponents()
//        comps.month = 1
//        let maxDate = calendar.date(byAdding: comps, to: Date())
//        comps.month = 0
//        comps.day = -1
//        let minDate = calendar.date(byAdding: comps, to: Date())
//        datePicker.maximumDate = maxDate
//        datePicker.minimumDate = minDate
//        //add the picker to view
//        self.view.addSubview(datePicker)

    
//      keyboardToolbarDate = UIToolbar();
//      keyboardToolbarDate.sizeToFit()
//      let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerChanged));
//      let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//      //let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//      keyboardToolbarDate.setItems([doneButton,spaceButton], animated: false)
//
//        textFieldFrom.inputAccessoryView = keyboardToolbarDate
//        textFieldFrom.inputView = datePicker
    }
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
           let screenWidth = UIScreen.main.bounds.width
           let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
           datePicker.datePickerMode = .date
           textFieldFrom.inputView = datePicker

           let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
           let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
           let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
           toolBar.setItems([cancel, flexible, barButton], animated: false)
           self.textFieldFrom.inputAccessoryView = toolBar
           
       }
       
       @objc func tapCancel() {
           self.resignFirstResponder()
       }
    @objc func tapDone() {
        if let datePicker = self.textFieldFrom.inputView as? UIDatePicker {
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.textFieldFrom.text = dateformatter.string(from: datePicker.date) 
        }
        self.textFieldFrom.resignFirstResponder() // 2-5
    }
    
     @objc func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        textFieldFrom.text = strDate
    }
    

      @objc func donedatePicker(){
         let formatter = DateFormatter()
         formatter.dateFormat = "dd/MM/yyyy"
         textFieldFrom.text = formatter.string(from: datePicker.date)
         self.view.endEditing(true)
      }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    
    @IBAction func dropDownAction(_ sender: Any) {
        DispatchQueue.main.async {
             self.toolBar.isHidden = false
             self.pickerViewLedger.isHidden = false
        }
    }
    
    //MARK: - Textfield Delegates
    func textFieldShouldReturn(_ textField: UITextField)->Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(textFieldSearchLedger) {
            self.pickerViewLedger.isHidden = false
            self.textFieldSearchLedger.becomeFirstResponder()
            self.pickerViewLedger.reloadAllComponents()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func resignKeyboard() {
        view.endEditing(true)
    }

}

extension LedgerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func createPicker() {
        self.pickerViewLedger = UIPickerView()
        self.pickerViewLedger.frame = CGRect(x: CGFloat(0), y: screenHeight - 250, width: screenWidth, height: 250)
        self.pickerViewLedger.delegate = self
        self.pickerViewLedger.dataSource = self
        self.pickerViewLedger.backgroundColor = UIColor.white
        self.view.addSubview(self.pickerViewLedger)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 250, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(onDoneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        self.view.addSubview(toolBar)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        self.toolBar.isHidden = true
        self.pickerViewLedger.isHidden = true
        self.selectedValue = arrayLedgerData[0]
    }
    
    // MARK:- UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayLedgerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if arrayLedgerData.count > 0 {
            return arrayLedgerData[row] as? String ?? ""
        }
        return "0"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerViewLedger.selectRow(row, inComponent: 0, animated: false)
        selectedValue = arrayLedgerData[pickerView.selectedRow(inComponent: 0)]
        self.textFieldSearchLedger.text = "  \(selectedValue)"
    }
    
    @objc func onDoneButtonTapped() {
        DispatchQueue.main.async {
            self.toolBar.isHidden = true
            self.pickerViewLedger.isHidden = true
            self.textFieldSearchLedger.text = "  \(self.selectedValue)"
        }
    }
}

//extension UITextField {
//
//    func setInputViewDatePicker(target: Any, selector: Selector) {
//        let screenWidth = UIScreen.main.bounds.width
//        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
//        datePicker.datePickerMode = .date
//        self.inputView = datePicker
//
//        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
//        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
//        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
//        toolBar.setItems([cancel, flexible, barButton], animated: false)
//        self.inputAccessoryView = toolBar
//
//    }
//
//    @objc func tapCancel() {
//        self.resignFirstResponder()
//    }
//
//}
