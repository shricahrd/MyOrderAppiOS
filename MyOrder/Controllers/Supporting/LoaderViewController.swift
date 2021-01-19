//
//  LoaderViewController.swift
//  MyOrder
//
//  Created by sourabh on 10/10/20.
//

import UIKit

typealias Complition = () -> Void

class LoaderViewController: UIViewController {

    var complition: Complition?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func initializeController(parent: UIViewController) {
        self.view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        self.view.frame = (UIApplication.shared.windows.first?.frame)!
        UIApplication.shared.windows.first?.addSubview(self.view)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
        }, completion: { (_) in
            self.view.alpha = 1.0
        })
    }

    func animmateView() {
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.view.layoutIfNeeded()
        })
    }

    func removeSelfFromSuper(finished: @escaping Complition) {
        complition = finished
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
}
