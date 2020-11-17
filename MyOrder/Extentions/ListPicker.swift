//
//  ListPicker.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

typealias ListPickerComplition = (_ text: String) -> Void

import UIKit
class ListPicker: UIViewController {
    var complition: ListPickerComplition?
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var aPicker: UIPickerView!
    var aList: [String] = []
    var selectedValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func initializeWithTitleController(parent: UIViewController,
                                       list: [String],
                                       title: String = "",
                                       complition: @escaping ListPickerComplition) {
        self.complition = complition
        self.aList = list
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        parent.present(self, animated: true) {
            if let pVC = self.parent {
                pVC.accessibilityElementsHidden = true
            }
        }
        if title.isEmpty == false {
            self.labelTitle.text = title
        }
    }
    func removeSelfFromSuper(adate: String) {
        if let pVC = self.parent {
            pVC.accessibilityElementsHidden = false
        }
        if let com = self.complition {
            self.dismiss(animated: true) {
               com(adate)
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func acionactionOnAddCalender(_ sender: Any) {
        self.removeSelfFromSuper(adate: selectedValue)
    }
    
    
    
}
extension ListPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        aList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if aList.count > 0 {
            selectedValue = aList[pickerView.selectedRow(inComponent: 0)]
        }
    }
}
