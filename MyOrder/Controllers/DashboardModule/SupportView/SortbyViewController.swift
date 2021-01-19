//
//  SortbyViewController.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
//

import UIKit
typealias SortbyComplition = (_ index: Int) -> Void

class SortbyCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
}

class SortbyViewController: UIViewController {
    @IBOutlet weak var tableViewSortBy: UITableView!
    var complition: SortbyComplition?
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    var tableArray = ["Brand", "Price: Low to High", "Price: High to low"]
    var selectedIndex : IndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initializeController(parent: UIViewController, finished: @escaping SortbyComplition) {
        complition = finished
        self.view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        self.view.frame = (UIApplication.shared.windows.first?.frame)!
        UIApplication.shared.windows.first?.addSubview(self.view)
        self.view.alpha = 0.0
        self.constraintBottom.constant = -500.0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.constraintBottom.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.view.alpha = 1.0
            self.view.layoutIfNeeded()
            
        })
    }

//    func animmateView() {
//        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseIn, animations: {
//            self.view.layoutIfNeeded()
//        }, completion: { (_) in
//            self.view.layoutIfNeeded()
//        })
//    }

    func removeSelfFromSuper(index: Int) {
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseIn, animations: {
            self.constraintBottom.constant = -500.0
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
                if self.complition != nil{
                    self.complition!(index)
                }
            })
        })
    }
}

extension SortbyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortbyCell") as! SortbyCell
        cell.labelTitle.text = tableArray[indexPath.row]
        if selectedIndex == indexPath {
            cell.labelTitle.textColor = UIColor(named: "AppWhite")
            cell.contentView.backgroundColor = UIColor(named: "AppLightBlue")
        }else {
            cell.labelTitle.textColor = UIColor(named: "AppBlack")
            cell.contentView.backgroundColor = UIColor(named: "AppWhite")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        self.tableViewSortBy.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.removeSelfFromSuper(index: indexPath.row)
            self.selectedIndex = nil
            self.tableViewSortBy.reloadData()
           
        }
    }
}
