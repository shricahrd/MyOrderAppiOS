//
//  ReferAndEarnViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit

class ReferAndEarnViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    @IBAction func actionOnInvite(_ sender: Any) {
        let shareText = "Dummy text!"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        present(vc, animated: true)
    }
}
