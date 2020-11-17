//
//  FavoriteViewController.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOldPrice: UILabel!
    @IBOutlet weak var buttonRemove: UIButton!
    @IBOutlet weak var buttonAddToCart: BorderButton!
    func setUpCellData(aWishlistModel: WishlistModel) {
        let url = URL(string: aWishlistModel.default_image)
        self.imageViewProduct.kf.indicatorType = .activity
        self.imageViewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
       // self.labelDiscount.text = "  " + aProduct.prd_discount + "  "
       // self.labelBrand.text = aWishlistModel.fld_brand_name
        self.labelTitle.text = aWishlistModel.fld_product_name
        self.labelPrice.text = "₹" + aWishlistModel.spcl_price.description
        self.labelOldPrice.text = "₹" + aWishlistModel.price.description
    }
}
class FavoriteViewController: BaseViewController {
    @IBOutlet weak var collectionViewFav: UICollectionView!
    var aFavoriteViewModel = FavoriteViewModel()
    var aProductListViewModel = ProductListViewModel()
    var aFavoriteModel = FavoriteModel()
    var aCartViewModel = CartViewModel()
    var tableArray : [WishlistModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.wishlistServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
}
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tableArray.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        collCell.constraintWidth.constant = collectionView.bounds.size.width/2 - 30
        collCell.setUpCellData(aWishlistModel: tableArray[indexPath.row])
        collCell.buttonRemove.tag = indexPath.row
        collCell.buttonRemove.addTarget(self, action: #selector(self.actionOnRemove), for: UIControl.Event.touchUpInside)
        collCell.buttonAddToCart.tag = indexPath.row
        collCell.buttonAddToCart.addTarget(self, action: #selector(self.actionOnAddToCart), for: UIControl.Event.touchUpInside)
        return collCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 360
        let width: CGFloat = collectionView.bounds.size.width/2 - 30
        let cellsize = CGSize(width: width, height: height)
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let aProductDetailsViewController = ProductDetailsViewController.getController(story: "Dashboard")  as? ProductDetailsViewController {
            aProductDetailsViewController.aWishlistModel = tableArray[indexPath.row]
            self.navigationController?.pushViewController(aProductDetailsViewController, animated: true)
        }
    }
    @objc func actionOnRemove(sender: UIButton) {
        self.wishListUpdateServiceCall(index: sender.tag)
    }
    @objc func actionOnAddToCart(sender: UIButton) {
       // self.addToCartServiceCall(aWishlistModel: tableArray[sender.tag])
    }
}
extension FavoriteViewController {
    func wishlistServiceCall(){
        self.showActivity()
        self.aFavoriteViewModel.getWishList { (model) in
            self.hideActivity()
            self.updateUi(aFavoriteModel: model)
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func updateUi(aFavoriteModel: FavoriteModel) {
        self.aFavoriteModel = aFavoriteModel
        self.tableArray = aFavoriteModel.aWishlistModels
        self.collectionViewFav.reloadData()
    }
    func wishListUpdateServiceCall(index:Int){
        self.showActivity()
        self.aProductListViewModel.wishlistServiceCall(aProductId: tableArray[index].fld_product_id, aWishListAdd: true) { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg)
            self.tableArray.remove(at: index)
            self.collectionViewFav.reloadData()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func addToCartServiceCall(aWishlistModel: WishlistModel){
        self.showActivity()
        self.aCartViewModel.addToCartServiceCall(aAddCardModel: [AddCart(aProductId: aWishlistModel.fld_product_id,
                                                                         aManufactureId: nil,
                                                                         aSizeId: aWishlistModel.fld_size_id,
                                                                         aColorId: aWishlistModel.fld_color_id,
                                                                         aProductQty: 1)]) { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg)
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
