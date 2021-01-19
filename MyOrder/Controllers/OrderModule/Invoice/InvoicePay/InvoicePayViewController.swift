//
//  InvoicePayViewController.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit

class InvoicePayViewController: BaseViewController {
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var textFieldPaymentMode: UITextField!
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var textFieldTransactionNumber: UITextField!
    @IBOutlet weak var textFieldAttachment: UITextField!
    @IBOutlet weak var imageViewAttachment: UIImageView!
    var aInvoicePayViewModel = InvoicePayViewModel()
    var aInvoiceList = InvoiceList()
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imageViewAttachment.clipsToBounds = true
        self.imageViewAttachment.layer.cornerRadius = 5.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    @IBAction func actionOnSelectDate(_ sender: Any) {
        if let aDatePicker = DatePicker.getController(story: "Order")  as? DatePicker {
            aDatePicker.initializeWithTitleController(parent: self, title: "Select Date") { (date) in
                self.textFieldDate.text = date.getInvoiceDate()
            }
        }
    }
    @IBAction func actionOnPaymentMode(_ sender: Any) {
        if let aListPicker = ListPicker.getController(story: "Order")  as? ListPicker {
            if self.textFieldPaymentMode.text?.isEmpty == true {
                self.textFieldPaymentMode.text = "DD"
            } 
            aListPicker.initializeWithTitleController(parent: self, list: ["DD","Cheque"], title: "Select Mode Of Payment") { (str) in
                if str.isEmpty == false {
                    self.textFieldPaymentMode.text = str
                }
            }
        }
    }
    @IBAction func actionOnattachment(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func actionOnSubmit(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.submitInvoice()
        }
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }

    func isValidateUI() -> String? {
        if self.textFieldDate.text?.isEmpty == true {
            return SelectDate
        }
        if self.textFieldPaymentMode.text?.isEmpty == true {
            return SelectPaymentMode
        }
        if self.textFieldAmount.text?.isEmpty == true {
            return SelectAmount
        }
        if self.textFieldTransactionNumber.text?.isEmpty == true {
            return SelectTxNumber
        }
        if self.textFieldAttachment.text?.isEmpty == true {
            return SelectAttachment
        }
        return nil
    }
}
extension InvoicePayViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.textFieldAttachment.text = "image.png"
        self.imageViewAttachment.image = image
    }
}

extension InvoicePayViewController {
    func submitInvoice() {
        self.showActivity()

        self.aInvoicePayViewModel.submitInvoiceServiceCall(aPayment_mode: self.textFieldPaymentMode.text ?? "",
                                                           aReceipt_no: self.textFieldTransactionNumber.text ?? "",
                                                           aAmt: self.textFieldAmount.text ?? "",
                                                           aPay_date: self.textFieldDate.text ?? "",
                                                           aNarration: "",
                                                           aReceipt_image: self.imageViewAttachment.image!) { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                self.navigationController?.popViewController(animated: true)
            }
        }  aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
