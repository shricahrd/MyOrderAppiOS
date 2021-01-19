//
//  ProductDetailsViewController.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
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
    @IBOutlet weak var buttonUpdate: UIButton!
    func setUpCellData(aSizes: Sizes, shouldRefresh: Bool) {
        self.labelSize.backgroundColor = .clear
        self.labelSize.text = aSizes.fld_size_name
        self.labelPrice.text = aSizes.fld_size_price.description
        self.textFieldQty.placeholder = ""//aSizes.fld_size_moq.description
        if shouldRefresh == true { self.textFieldQty.text = "" }
        if UserModel.shared.aSelectedUserType == .manufacture {
            self.buttonAddRemove.isHidden = true
        }
    }
    func setUpCellData(aColor: Colors, shouldRefresh: Bool) {
        self.labelSize.text = ""
        self.labelSize.backgroundColor = UIColor(hex: aColor.fld_color_code)
        self.labelPrice.text = aColor.fld_color_price
        self.textFieldQty.placeholder = ""//aSizes.fld_size_moq.description
        if shouldRefresh == true { self.textFieldQty.text = "" }
        if UserModel.shared.aSelectedUserType == .manufacture {
            self.buttonAddRemove.isHidden = true
        }
    }
    func setUpCellData(aSizes: Sizelist) {
        self.labelSize.backgroundColor = .clear
        self.labelSize.text = aSizes.size_name
        self.labelPrice.text = aSizes.price.description
        self.textFieldQty.text = aSizes.qty.description
        self.textFieldQty.isUserInteractionEnabled = true
    }
    func setUpCellData(aAdditionalColor: AdditionalColor) {
        self.labelSize.text = ""
        self.labelSize.backgroundColor = UIColor(hex: aAdditionalColor.color_code)
        self.labelPrice.text = aAdditionalColor.price.description
        self.textFieldQty.text = aAdditionalColor.qty.description
        self.textFieldQty.isUserInteractionEnabled = true
    }
    func setUpCellData(aAdditionalSize: AdditionalSize) {
        self.labelSize.backgroundColor = .clear
        self.labelSize.text = aAdditionalSize.size_name
        self.labelPrice.text = aAdditionalSize.price.description
        self.textFieldQty.text = aAdditionalSize.qty.description
        self.textFieldQty.isUserInteractionEnabled = true
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
    @IBOutlet weak var labelSizeTitle: UILabel!
    @IBOutlet weak var labelSingleQty: UILabel!
    @IBOutlet weak var textFieldQtySingle: UITextField!
    
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
        self.labelSingleQty.isHidden = true
        self.textFieldQtySingle.isHidden = true
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
            if self.aProductType == .normal {
                if textFieldQtySingle.text?.isEmpty == true {
                    self.showAlartWith(message: "Please enter quantity." )
                }else {
                    let qty = Int(textFieldQtySingle.text!) ?? 0
                    if qty == 0 {
                        self.showAlartWith(message: "Qty can't be zero." )
                    }else {
                        self.addToCartServiceCall(aProductId: aProductDetail.fld_product_id, aManufactureId: aProductDetail.fld_manufacture_id, aQty: qty)
                    }
                }
                
//                if self.aProductType == .unconfigurable {
//                    var flag = false
//                    var colorIndex = -1
//                    tagViewColor.tagViews.forEach { tags in
//                        if tags.isSelected == true {
//                            flag = true
//                            colorIndex = tags.tag
//                        }
//                    }
//                    self.addToCartServiceCall(aProductId: aProductDetail.fld_product_id, aManufactureId: aProductDetail.fld_manufacture_id, aQty: 1, asizeId: nil, aColorId: flag == true ? self.aProductDetail.attribute.aColors[colorIndex].fld_color_id: nil)
//                }else {
//                    
//                }
                
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let  aImageZoomViewController = ImageZoomViewController.getController(story: "Dashboard")  as? ImageZoomViewController {
            aImageZoomViewController.aImages =  self.aProductDetail.thumbnail.map { $0.image }
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
extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.aProductType != .unconfigurable {
            let cellCount = self.aProductDetail.attribute.aSizes.count
            self.constraintHeightSize.constant =  cellCount > 0 ?  35 + CGFloat(60 * cellCount) : 0
            return cellCount
        }else {
            var cellCount = self.aProductDetail.attribute.aSizes.count
            if cellCount == 0 {
                cellCount = self.aProductDetail.attribute.aColors.count
            }
            self.constraintHeightSize.constant =  cellCount > 0 ?  35 + CGFloat(60 * cellCount) : 0
            return cellCount
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSizeCell") as! ProductSizeCell
        cell.selectionStyle = .none
        
        if self.aProductType == .unconfigurable {
            if self.aProductDetail.attribute.aSizes.count > 0 {
                self.labelSizeTitle.text = "Size"
                cell.setUpCellData(aSizes: self.aProductDetail.attribute.aSizes[indexPath.row], shouldRefresh: refreshQty)
            }else if self.aProductDetail.attribute.aColors.count > 0 {
                self.labelSizeTitle.text = "Color"
                cell.setUpCellData(aColor: self.aProductDetail.attribute.aColors[indexPath.row], shouldRefresh: refreshQty)
            }
        }else {
            self.labelSizeTitle.text = "Size"
            cell.setUpCellData(aSizes: self.aProductDetail.attribute.aSizes[indexPath.row], shouldRefresh: refreshQty)
        }
        
        cell.buttonAddRemove.tag = indexPath.row
        cell.buttonAddRemove.addTarget(self, action: #selector(self.actionOnAddToCart), for: UIControl.Event.touchUpInside)
      
        return cell
    }
    @objc func actionOnAddToCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableViewSize.cellForRow(at: indexPath) as! ProductSizeCell
        if self.aProductType != .unconfigurable {
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
                if qty == 0 {
                    self.showAlartWith(message: "Qty can't be zero." )
                }else {
                    self.addToCard(color: colors, size: size, qty: qty)
                }
            }else {
                self.showAlartWith(message: SelectColor)
            }
        } else {
            if self.aProductDetail.attribute.aColors.count > 0 {
                let colors = self.aProductDetail.attribute.aColors[indexPath.row]
                let qty = Int(cell.textFieldQty.text!) ?? 0
                self.addToCard(color: colors, qty: qty)
            } else {
                let size = self.aProductDetail.attribute.aSizes[indexPath.row]
                let qty = Int(cell.textFieldQty.text!) ?? 0
                self.addToCard(size: size, qty: qty)
            }
        }
    }
    
    func addToCard(color: Colors? = nil, size: Sizes? = nil, qty:Int) {
        self.addToCartServiceCall(aProductId: aProductDetail.fld_product_id, aManufactureId: aProductDetail.fld_manufacture_id, aQty: qty, asizeId: size?.fld_size_id, aColorId: color?.fld_color_id)
    }
}
