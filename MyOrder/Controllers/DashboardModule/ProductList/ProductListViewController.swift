//
//  ProductListViewController.swift
//  MyOrder
//
//  Created by sourabh on 11/10/20.
//

import UIKit

enum ProductListType : String {
    case hot = "hot_deals"
    case new = "new_collection"
    case unknown = ""
}

class ProductList: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOldPrice: UILabel!
    @IBOutlet weak var buttonWishList: UIButton!
    func setUpCellData(aProduct: Product) {
        let url = URL(string: aProduct.default_image)
        self.imageViewProduct.kf.indicatorType = .activity
        self.imageViewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.labelBrand.text = aProduct.fld_brand_name
        self.labelTitle.text = aProduct.name
        self.labelPrice.text = "₹" + aProduct.spcl_price.description
        self.labelOldPrice.text = "₹" + aProduct.price.description
        self.buttonWishList.setImage(aProduct.isInWishlist == true ? UIImage(imageLiteralResourceName: "fav") : UIImage(imageLiteralResourceName: "unfav"), for: [])
    }
    func setUpCellDataHotNew(aDashboardProduct: DashboardProduct) {
        let url = URL(string: aDashboardProduct.default_image)
        self.imageViewProduct.kf.indicatorType = .activity
        self.imageViewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.labelBrand.text = aDashboardProduct.fld_brand_name
        self.labelTitle.text = aDashboardProduct.name
        self.labelPrice.text = "₹" + aDashboardProduct.spcl_price.description
        self.labelOldPrice.text = "₹" + aDashboardProduct.price.description
        self.buttonWishList.setImage(aDashboardProduct.isInWishlist == true ? UIImage(imageLiteralResourceName: "fav") : UIImage(imageLiteralResourceName: "unfav"), for: [])
    }
    func setUpCellData(aRewardProduct: RewardProductListModel) {
        let url = URL(string: aRewardProduct.images)
        self.imageViewProduct.kf.indicatorType = .activity
        self.imageViewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.labelBrand.text = ""
        self.labelTitle.text = aRewardProduct.name
        self.labelPrice.text = "Points: " + aRewardProduct.points.description
        self.labelOldPrice.text = ""
       // self.buttonWishList.setImage(aProduct.isInWishlist == true ? UIImage(imageLiteralResourceName: "fav") : UIImage(imageLiteralResourceName: "unfav"), for: [])
    }
}
class ProductListViewController: BaseViewController {
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableViewProduct: UITableView!
    @IBOutlet weak var constraintFilterHeight: NSLayoutConstraint!

    var aProductListModel = ProductListModel()
    var aProductListViewModel = ProductListViewModel()
    var aFilterModel: FilterModel? = nil
    var aTableArray : [Product] = []
    var aTableArrayHotNew : [DashboardProduct] = []

    var aProductListType: ProductListType = .unknown
    var sortBy = 0
    var currentPageNo = 0
    var catagoryId = 0
    var aDcatagoryId = 0
    var brandId = 0
    var searchText = ""
    var isLoading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldSearch.text = searchText
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        aDcatagoryId = catagoryId
        if catagoryId == 0 {
            self.constraintFilterHeight.constant = 0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productListServiceCall()
        self.addRightBarButton()
        if catagoryId == 0 {
            self.constraintFilterHeight.constant = 0
        }
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
    }
    @IBAction func actionOnFilter(_ sender: Any) {
        if let aFilterViewController = FilterViewController.getController(story: "Dashboard")  as? FilterViewController {
            aFilterViewController.aCatagoryId = catagoryId
            aFilterViewController.aSearchText = searchText
            aFilterViewController.aFilterModel = self.aFilterModel
            self.navigationController?.pushViewController(aFilterViewController, animated: true)
        }
    }
    @IBAction func actionOnSort(_ sender: Any) {
        self.showSortby { (index) in
            self.aTableArray.removeAll()
            self.aTableArrayHotNew.removeAll()
            self.tableViewProduct.reloadData()
            self.currentPageNo = 0
            self.sortBy = index
            self.productListServiceCall()
        }
    }
    @objc func actionOnFav(sender: UIButton) {
        self.wishListUpdateServiceCall(index: sender.tag)
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.clear
        return 140
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.aProductListType == .unknown ? aTableArray.count : aTableArrayHotNew.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductList") as! ProductList
        cell.selectionStyle = .none
        if self.aProductListType == .unknown {
            cell.setUpCellData(aProduct: aTableArray[indexPath.row])
        } else {
            cell.setUpCellDataHotNew(aDashboardProduct: aTableArrayHotNew[indexPath.row])
        }
        cell.buttonWishList.tag = indexPath.row
        cell.buttonWishList.addTarget(self, action: #selector(self.actionOnFav), for: UIControl.Event.touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let aProductDetailsViewController = ProductDetailsViewController.getController(story: "Dashboard")  as? ProductDetailsViewController {
            if self.aProductListType == .unknown {
                aProductDetailsViewController.aProduct = aTableArray[indexPath.row]
            }else {
                aProductDetailsViewController.aDashboardProduct = aTableArrayHotNew[indexPath.row]
            }
            self.navigationController?.pushViewController(aProductDetailsViewController, animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.y
        if contentOffsetX >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
            guard !self.isLoading else { return }
            self.isLoading = true
            self.currentPageNo += 1
            self.productListServiceCall()
        }
    }
}
extension ProductListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if result.contains("\n") { return true}
        if result.count > 0 {
            if let frame = textField.superview?.convert(textField.frame, to: nil) {
                self.showSearchList(top: frame.maxY + 20, text: result)
            }
        }else {
            self.hideSearchList()
        }
        return true
    }
    func goToSearchResult(text: String){
        if self.searchText != self.textFieldSearch.text {
            self.aTableArray.removeAll()
            self.tableViewProduct.reloadData()
            self.currentPageNo = 0
            self.sortBy = 0
            self.catagoryId = 0
            self.constraintFilterHeight.constant = 0
        }
        self.searchText = self.textFieldSearch.text!
        self.productListServiceCall()
    }
}
extension ProductListViewController {
    func productListServiceCall(){
        self.showActivity()
        if self.aFilterModel != nil {
            if currentPageNo == 0 {
                self.aTableArray = []
                self.tableViewProduct.reloadData()
            }
            self.aProductListViewModel.getFilterProductServiceCall(aFilterModel: self.aFilterModel!,
                                                                   afld_search_txt: searchText,
                                                                   afld_sort_by: sortBy,
                                                                   afld_page_no: currentPageNo,
                                                                   aCatID: self.catagoryId) { (model) in
                self.hideActivity()
                self.updateUi(aProductListModel: model)
            }  aFailed: { (error) in
                self.hideActivity()
               // self.showAlartWith(message: error!.localizedDescription)
            }
        }
        else {
            if self.aProductListType == .unknown {
                if self.searchText == "" {
                    self.catagoryId = self.aDcatagoryId
                }
                self.aProductListViewModel.getProducts(afld_brand_id: brandId,
                                                       afld_cat_id: catagoryId,
                                                       afld_search_txt: searchText,
                                                       afld_page_no: currentPageNo,
                                                       afld_sort_by: sortBy) { (model) in
                    if self.catagoryId == 0 && self.aDcatagoryId != 0 && self.searchText == "" {
                        self.catagoryId = self.aDcatagoryId
                        self.constraintFilterHeight.constant = 40
                    }
                    self.hideActivity()
                    self.updateUi(aProductListModel: model)
                }  aFailed: { (error) in
                    self.hideActivity()
                  //  self.showAlartWith(message: error!.localizedDescription)
                }
            }else {
                self.aProductListViewModel.featchHotNewProductsServiceCall(productListType: self.aProductListType,
                                                                           afld_page_no: currentPageNo) { (models) in
                    self.hideActivity()
                    self.updateUi(aDashboardProducts: models)
                } aFailed: { (error) in
                    self.hideActivity()
                   // self.showAlartWith(message: error!.localizedDescription)
                }
            }
        }
    }
    func updateUi(aProductListModel: ProductListModel) {
        if self.isLoading == true {
            self.aTableArray.append(contentsOf: aProductListModel.products)
            self.isLoading = false
        }else {
            self.aTableArray = aProductListModel.products
        }
        self.tableViewProduct.reloadData()
    }
    func updateUi(aDashboardProducts: [DashboardProduct]) {
        if self.isLoading == true {
            self.aTableArrayHotNew.append(contentsOf: aDashboardProducts)
            self.isLoading = false
        }else {
            self.aTableArrayHotNew = aDashboardProducts
        }
        self.tableViewProduct.reloadData()
    }
    func wishListUpdateServiceCall(index:Int) {
        self.showActivity()
        var productId = 0
        var isInWishlist = false
        if self.aProductListType == .unknown {
            productId = aTableArray[index].id
            isInWishlist = aTableArray[index].isInWishlist
        } else {
            productId = aTableArrayHotNew[index].id
            isInWishlist = aTableArrayHotNew[index].isInWishlist
        }
        self.aProductListViewModel.wishlistServiceCall(aProductId: productId, aWishListAdd: isInWishlist) { (msg) in
            self.hideActivity()
            if self.aProductListType == .unknown {
                self.aTableArray[index].isInWishlist = !self.aTableArray[index].isInWishlist
            }else {
                self.aTableArrayHotNew[index].isInWishlist = !self.aTableArrayHotNew[index].isInWishlist
            }
            self.showAlartWith(message: msg)
            self.tableViewProduct.reloadData()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
