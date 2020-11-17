//
//  ProductDetailsViewController.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit

enum ProductType : String {
    case configurable
    case unconfigurable
    case normal
    case unknow
}

class ProductSizeCell: UITableViewCell{
    @IBOutlet weak var labelSize: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonAddRemove: UIButton!
    @IBOutlet weak var textFieldQty: UITextField!
    func setUpCellData(aSizes: Sizes, shouldRefresh: Bool) {
        self.labelSize.text = aSizes.fld_size_name
        self.labelPrice.text = aSizes.fld_size_price.description
        self.textFieldQty.placeholder = aSizes.fld_size_moq.description
        if shouldRefresh == true { self.textFieldQty.text = "" }
    }
    func setUpCellData(aSizes: Sizelist) {
        self.labelSize.text = aSizes.size_name
        self.labelPrice.text = aSizes.price.description
        self.textFieldQty.text = aSizes.qty.description
        self.textFieldQty.isUserInteractionEnabled = false
//        if shouldRefresh == true { self.textFieldQty.text = "" }
    }
}
class ProductDetailsCell: UICollectionViewCell{
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewProduct: UIImageView!
    func setUpCellImage(aThumbnail: Thumbnail) {
        let url = URL(string: aThumbnail.image)
        self.imageViewProduct.kf.indicatorType = .activity
        self.imageViewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
    }
}
class ProductDetailsViewController: BaseViewController {
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var pagger: UIPageControl!
    @IBOutlet weak var tagViewColor: TagListView!
    @IBOutlet weak var tableViewSize: UITableView!
    @IBOutlet weak var constraintHeightSize: NSLayoutConstraint!
    @IBOutlet weak var buttonWishList: UIButton!
    @IBOutlet weak var labelBrandName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOldPrice: UILabel!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelMinOrder: UILabel!
    @IBOutlet weak var labelSupplierName: UILabel!
    @IBOutlet weak var labelDiscription: UILabel!
    @IBOutlet weak var buttonAddUpdateCart: BorderButton!
    
    var cellsize = CGSize(width: 0, height: 0)
    var aProductDetailsViewModel = ProductDetailsViewModel()
    var aProductListViewModel = ProductListViewModel()
    var aProductDetailModel = ProductDetailModel()
    var aProductDetail = ProductDetail()
    var aProduct: Product? = nil
    var aDashboardProduct: DashboardProduct? = nil
    var aWishlistModel: WishlistModel? = nil
    var aProductType : ProductType = .unknow
    var aCartViewModel = CartViewModel()
    var refreshQty = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.updateUi()
        self.getProductDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUi()
        self.addRightBarButton()
    }
    override func actionOnLeftIcon(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnButtonWishList(_ sender: Any) {
        self.wishListUpdateServiceCall()
    }
    @IBAction func actionOnAddUpdateCart(_ sender: Any) {
        if self.aProductDetail.isInCart == true {
            if let  aCartViewController = CartViewController.getController(story: "Dashboard")  as? CartViewController {
                self.navigationController?.pushViewController(aCartViewController, animated: true)
            }
        }else {
            if self.aProductType != .configurable {
                self.addToCartServiceCall(aProductId: aProductDetail.fld_product_id, aManufactureId: aProductDetail.fld_manufacture_id, aQty: 1)
            }else {
                if let  aCartViewController = CartViewController.getController(story: "Dashboard")  as? CartViewController {
                    self.navigationController?.pushViewController(aCartViewController, animated: true)
                }
            }
        }
    }
}
extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.aProductDetail.thumbnail.count
        }
        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCell", for: indexPath) as! ProductDetailsCell
            collCell.constraintWidth.constant = collectionView.bounds.size.width
            collCell.setUpCellImage(aThumbnail: self.aProductDetail.thumbnail[indexPath.row])
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
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                       targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let pageWidth = self.cellsize.width
            let itemIndex = (targetContentOffset.pointee.x) / pageWidth
            let index = IndexPath(item: Int(round(itemIndex)), section: 0)
            self.pagger.currentPage = index.row
        }
}
extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.constraintHeightSize.constant =  self.aProductDetail.attribute.aSizes.count > 0 ?  35 + CGFloat(60 * self.aProductDetail.attribute.aSizes.count) : 0
        return self.aProductDetail.attribute.aSizes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSizeCell") as! ProductSizeCell
        cell.selectionStyle = .none
        cell.setUpCellData(aSizes: self.aProductDetail.attribute.aSizes[indexPath.row], shouldRefresh: refreshQty)
        cell.buttonAddRemove.tag = indexPath.row
        cell.buttonAddRemove.addTarget(self, action: #selector(self.actionOnAddToCart), for: UIControl.Event.touchUpInside)
        return cell
    }
    @objc func actionOnAddToCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableViewSize.cellForRow(at: indexPath) as! ProductSizeCell
        let size = self.aProductDetail.attribute.aSizes[indexPath.row]
        var flag = false
        var colorIndex = -1
        tagViewColor.tagViews.forEach { tags in
            if tags.isSelected == true {
                flag = true
                colorIndex = tags.tag
            }
        }
        if flag == true {
            let colors = self.aProductDetail.attribute.aColors[colorIndex]
            let qty = Int(cell.textFieldQty.text!) ?? 0
            if size.fld_size_moq > qty {
                self.showAlartWith(message: SelectSize + size.fld_size_name + " and for color " + colors.fld_color_name.lowercased() + " is " + size.fld_size_moq.description + "." )
            }else {
                self.addToCard(color: colors, size: size, qty: qty)
            }
            
        }else {
            self.showAlartWith(message: SelectColor)
        }
    }
    func addToCard(color:Colors, size:Sizes, qty:Int) {
        self.addToCartServiceCall(aProductId: aProductDetail.fld_product_id, aManufactureId: aProductDetail.fld_manufacture_id, aQty: qty, asizeId: size.fld_size_id, aColorId: color.fld_color_id)
    }
}
