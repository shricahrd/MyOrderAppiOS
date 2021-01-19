//
//  RewardDetailsViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit
class RewardDetailsViewController: BaseViewController {
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var pagger: UIPageControl!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDiscription: UILabel!
    @IBOutlet weak var buttonAddUpdateCart: BorderButton!
    @IBOutlet weak var textFieldQtySingle: UITextField!
    var aRewardProductListModel = RewardProductListModel()
    var cellsize = CGSize(width: 0, height: 0)
    var aRewardDetailsViewModel = RewardDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.labelName.text = aRewardProductListModel.name
        self.labelPrice.text = "Points: " + aRewardProductListModel.points.description
        self.labelDiscription.text = aRewardProductListModel.descriptionLocal
        self.textFieldQtySingle.text = aRewardProductListModel.qty.description
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnAddCart(_ sender: Any) {
        let qty = Int(textFieldQtySingle.text!) ?? 0
        if qty == 0 {
            self.showAlartWith(message: "Qty can't be zero." )
        }else {
            self.addProduct()
        }
    }
    func addProduct(){
        self.showActivity()
        self.aRewardDetailsViewModel.aAddProductServiceCall(fld_product_id: aRewardProductListModel.id,
                                                            fld_product_qty: self.textFieldQtySingle.text!,
                                                            fld_product_points: aRewardProductListModel.points) { (msg) in
            self.hideActivity()
            self.showAlartWith( message: msg) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
        }  aFailed: { (error) in
            self.hideActivity()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
extension RewardDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.aRewardProductListModel.thumbnail.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCell", for: indexPath) as! ProductDetailsCell
        collCell.constraintWidth.constant = collectionView.bounds.size.width
        collCell.setUpCellImage(aThumbnail: self.aRewardProductListModel.thumbnail[indexPath.row])
        return collCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 400
        let width: CGFloat = collectionView.bounds.size.width
        self.cellsize = CGSize(width: width, height: height)
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let  aImageZoomViewController = ImageZoomViewController.getController(story: "Dashboard")  as? ImageZoomViewController {
            aImageZoomViewController.aImages =  self.aRewardProductListModel.thumbnail.map { $0.image }
            self.navigationController?.pushViewController(aImageZoomViewController, animated: true)
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = self.cellsize.width
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        let index = IndexPath(item: Int(round(itemIndex)), section: 0)
        self.pagger.currentPage = index.row
    }
}
