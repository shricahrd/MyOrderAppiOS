//  IssueListingController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit
class IssueListingController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var tableViewList: UITableView!
    var arrayData = ["Mr order item count is less...", "My order is still showing pending ", "Accessories"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        self.registerNib()
    }
    
    func registerNib() {
        tableViewList.register(UINib(nibName: "IssueListCell", bundle: nil), forCellReuseIdentifier: "IssueListCell")
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        tableViewList.separatorStyle = .none
    }
    
    @IBAction func backAction(_ sender: Any) {
        
    }
    
     // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IssueListCell", for: indexPath) as? IssueListCell {
           cell.selectionStyle = .none
           cell.ticketid.text = "Ticket ID: #00001"
           cell.date.text = "26-07-2020"
           cell.status.text = "Status:"
           cell.titleText.text = "\(arrayData[indexPath.row])"
           cell.backgroundColor = UIColor(red:255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
           cell.titleText.textColor = UIColor(red:0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
           cell.statusValue.text = "Solved"
           cell.statusValue.textColor = .green
           return cell
         }
           return UITableViewCell()
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem
       }
}
