//
//  SearchProductViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit
typealias SearchComplition = (_ searchText: String) -> Void
class SearchProduct: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
}
class SearchProductViewController: UIViewController {
    @IBOutlet weak var tableVIew: UITableView!
    var complition: Complition?
    var shouldAdd = true
    var shouldLoadTable = true
    var aSearchProductViewModel = SearchProductViewModel()
    var aSearchProducts: [SearchProductModel] = []
    var searchText: [String] = []
    var aSearchComplition: SearchComplition? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func initializeController(parent: UIViewController, top: CGFloat, text: String) {
        if shouldAdd == true {
            shouldAdd = false
            self.view.backgroundColor = .white
            self.view.frame = (UIApplication.shared.windows.first?.frame)!
            self.view.frame.origin.y = top
            self.view.frame.size.height =  self.view.frame.size.height - top
            UIApplication.shared.windows.first?.addSubview(self.view)
            self.view.alpha = 0.0
            UIView.animate(withDuration: 0.25, animations: {
                self.view.alpha = 1.0
            }, completion: { (_) in
                self.view.alpha = 1.0
            })
        }
        self.searchText = text.map { String($0) }
        self.serviceCall(text:text)
    }
    func removeSelfFromSuper(finished: @escaping Complition) {
        shouldLoadTable = false
        complition = finished
        shouldAdd = true
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.15, delay: 0.15, options: .curveEaseIn, animations: {
                self.view.alpha = 0.0
            }, completion: { (_) in
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
                self.didMove(toParent: nil)
                self.complition!()
            })
        })
    }
    func serviceCall(text: String) {
        self.shouldLoadTable = true
        self.aSearchProductViewModel.aSerachListServiceCall(aText: text) { (models) in
            if  self.shouldLoadTable == true {
                self.aSearchProducts = models
                self.tableVIew.reloadData()
            }else {
                self.aSearchProducts = []
                self.tableVIew.reloadData()
            }
        } aFailed: { (error) in
            if  self.shouldLoadTable == true {
                self.aSearchProducts = []
                self.tableVIew.reloadData()
            }else {
                self.aSearchProducts = []
                self.tableVIew.reloadData()
            }
        }
    }
}
extension SearchProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aSearchProducts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProduct") as! SearchProduct
        let font = UIFont.systemFont(ofSize: 18)
        let boldFont = UIFont.boldSystemFont(ofSize: 18)
        cell.labelName.attributedText = aSearchProducts[indexPath.row].search_name.withBoldText(
            boldPartsOfString: self.searchText, font: font, boldFont: boldFont)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeSelfFromSuper {
            if let complition = self.aSearchComplition {
                complition(self.aSearchProducts[indexPath.row].search_name)
            }
        }
    }
}
