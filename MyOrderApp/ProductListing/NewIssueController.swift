//  NewIssueController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit

class NewIssueController: UIViewController,UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet var textViewComment: UITextView!
    @IBOutlet var attachmentButton: UIButton!
    let PLACEHOLDER_TEXT = "Describe the issue"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        
        let paddingL: UIView = UIView()
        paddingL.frame = CGRect(x: 0, y: 0,width: 10, height: 10)
        textFieldTitle.delegate = self
        textFieldTitle.layer.borderColor =  UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor
        textFieldTitle.layer.borderWidth = 1
        textFieldTitle.layer.cornerRadius = 8.0
        textFieldTitle.clipsToBounds = true
   
        textFieldTitle.textColor = UIColor.black
        textFieldTitle.leftView = paddingL
        textFieldTitle.rightView = paddingL
        textFieldTitle.placeholder = "Title"
        textFieldTitle.tintColor = UIColor.black;
        textFieldTitle.font = UIFont(name: "Arial",size: 15)
        textFieldTitle.backgroundColor = UIColor.white
        textFieldTitle.layer.cornerRadius = 8
        textFieldTitle.leftViewMode = .always
        textFieldTitle.rightViewMode = .always

        textViewComment.delegate = self
        textViewComment.layer.borderColor =  UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor
        textViewComment.layer.borderWidth = 1
        textViewComment.layer.cornerRadius = 8.0
        textViewComment.clipsToBounds = true
        textViewComment.delegate = self
        
        attachmentButton.layer.borderColor =  UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor
        attachmentButton.layer.borderWidth = 1
        attachmentButton.layer.cornerRadius = 8.0
        attachmentButton.clipsToBounds = true
        

        
        applyPlaceholderStyle(textViewComment, placeholderText: PLACEHOLDER_TEXT)
        
        
    }
    

    @IBAction func attchmentAction(_ sender: Any) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(Set<UITouch>(),with:event);
        self.view.endEditing(true)
        textViewComment.resignFirstResponder()
    }
    
    func applyNonPlaceholderStyle(_ aTextview: UITextView) {
        aTextview.textColor = UIColor.darkText
        aTextview.alpha = 1.0
    }
    
    func applyPlaceholderStyle(_ aTextview: UITextView, placeholderText: String) {
        aTextview.textColor = UIColor.lightGray
        aTextview.text = placeholderText
    }
    
    func textViewShouldBeginEditing(_ aTextView:UITextView)->Bool {
        if aTextView==textViewComment && aTextView.text == PLACEHOLDER_TEXT {
           moveCursorToStart(aTextView)
          // scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 200), animated: true)
        }
        return true
    }
    
    func moveCursorToStart(_ aTextView:UITextView) {
        DispatchQueue.main.async(execute: {
            aTextView.selectedRange = NSMakeRange(0, 0);
        })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.count+text.count-range.length
        if newLength > 0 {
            if textView == textViewComment && textView.text == PLACEHOLDER_TEXT {
                applyNonPlaceholderStyle(textView)
                textView.text=""
            }
            return newLength <= 1000
        } else {
            applyPlaceholderStyle(textView,placeholderText: PLACEHOLDER_TEXT)
            moveCursorToStart(textView)
            return false
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == PLACEHOLDER_TEXT) {
            textViewComment.text = nil
            textViewComment.textColor = UIColor.black
           // scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 200), animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textViewComment.text = PLACEHOLDER_TEXT
            textViewComment.textColor = UIColor.lightGray
        }
       // scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 0), animated: true)
        textView.resignFirstResponder()
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}
