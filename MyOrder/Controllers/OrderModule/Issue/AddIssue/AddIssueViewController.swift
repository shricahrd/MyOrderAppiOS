//
//  AddIssueViewController.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit

class AddIssueViewController: BaseViewController {
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewDiscription: UITextView!
    @IBOutlet weak var textFieldAttachment: UITextField!
    @IBOutlet weak var imageViewAttachment: UIImageView!
    var imagePicker: ImagePicker!
    var aAddIssueViewModel = AddIssueViewModel()
    var productId = 0

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
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnAttachment(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func actionOnSubmit(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.addNewIssue()
        }
    }
    func isValidateUI() -> String? {
        if self.textFieldTitle.text?.isEmpty == true {
            return SelectTitle
        }
        if self.textViewDiscription.text?.isEmpty == true {
            return SelectDis
        }
        if self.textFieldAttachment.text?.isEmpty == true {
            return SelectAttachment
        }
        return nil
    }
}
extension AddIssueViewController {
    func addNewIssue(){
        self.showActivity()
        self.aAddIssueViewModel.submitIssueServiceCall(title: self.textFieldTitle.text ?? "",
                                                       content: self.textViewDiscription.text ?? "",
                                                       order_id: productId,
                                                       aAttechment: self.imageViewAttachment.image!)  { (msg) in
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
extension AddIssueViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.textFieldAttachment.text = "image.png"
        self.imageViewAttachment.image = image
    }
}
