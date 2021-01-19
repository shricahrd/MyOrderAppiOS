//
//  HelpAboutViewController.swift
//  MyOrder
//
//  Created by sourabh on 02/12/20.
//

import UIKit
import WebKit

class HelpAboutViewController: BaseViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textFieldSearch: UITextField!

    var aHelpAboutViewModel = HelpAboutViewModel()
    var isHelp = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.serviceCall()
        if isHelp == true {
            self.labelTitle.text = "Help & Support"
        }else {
            self.labelTitle.text = "About"
        }
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
    }

}
extension HelpAboutViewController {
    func serviceCall() {
        self.showActivity()
        self.aHelpAboutViewModel.aGetHelpAboutServiceCall(isHelp: self.isHelp) { (url) in
            self.hideActivity()
            self.webView.load(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}

extension HelpAboutViewController: UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if result.contains("\n") { return true}
        if result.count > 0 {
            if let frame = textField.superview?.convert(textField.frame, to: nil) {
                self.showSearchList(top: frame.maxY + 20, text: result)
            }
        }else {
            self.hideSearchList()
        }
        return true
    }
    func goToSearchResult(text: String){
        if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
            aProductListViewController.searchText = text
            self.navigationController?.pushViewController(aProductListViewController, animated: true)
        }
    }
}
