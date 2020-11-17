//
//  IssueDetailsViewController.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit

class IssueDetailsViewController: BaseViewController {
    
    @IBOutlet weak var labelIssueDate: UILabel!
    @IBOutlet weak var labelTicketId: UILabel!
    @IBOutlet weak var imageViewPic: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDis: UILabel!
    
    var aIssueList = IssueList()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        
        let url = URL(string: aIssueList.images)
        self.imageViewPic.kf.indicatorType = .activity
        self.imageViewPic.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.labelIssueDate.text = aIssueList.issue_date
        self.labelTitle.text = aIssueList.title
        self.labelDis.text = aIssueList.content
        self.labelTicketId.text = "Ticket ID: #" + aIssueList.trackId
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
}
