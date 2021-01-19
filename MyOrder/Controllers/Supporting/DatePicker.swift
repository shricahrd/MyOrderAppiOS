//
//  DatePicker.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit
typealias PickerComplition = (_ date:Date) -> Void

class DatePicker: UIViewController {
    var complition: PickerComplition?
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func initializeWithTitleController(parent: UIViewController,
                                       title: String = "",
                                       complition: @escaping PickerComplition) {
        self.complition = complition
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
    func removeSelfFromSuper(adate: Date) {
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
        self.removeSelfFromSuper(adate: datePicker.date)
    }
}
