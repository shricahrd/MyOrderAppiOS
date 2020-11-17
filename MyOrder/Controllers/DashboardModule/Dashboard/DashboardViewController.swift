//
//  DashboardViewController.swift
//  MyOrder
//
//  Created by gwl on 10/10/20.
//

import UIKit
import Kingfisher


class DashboardTopCell:UICollectionViewCell {
    @IBOutlet weak var constraintBannerWidth: NSLayoutConstraint!
    @IBOutlet weak var imageVIewBanner: UIImageView!
    func setBannerImage(url:String){
        let url = URL(string: url)
        self.imageVIewBanner.kf.indicatorType = .activity
        self.imageVIewBanner.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderBanner"))
    }
}
class DashboardBottomCell:UICollectionViewCell {
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelBrandName: UILabel!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOldPrice: UILabel!
    func setCellData(aProduct: DashboardProduct) {
        let url = URL(string: aProduct.default_image)
        self.imageViewProduct.kf.indicatorType = .activity
        self.imageViewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderCell"))
        self.labelDiscount.text = "  " + aProduct.prd_discount + "  "
        self.labelBrandName.text = aProduct.fld_brand_name
        self.labelProductName.text = aProduct.name
        self.labelPrice.text = "₹" + aProduct.spcl_price.description
        self.labelOldPrice.text = "₹" + aProduct.price.description
    }
}
class DashboardViewController: BaseViewController {
    @IBOutlet weak var collectionViewTop: UICollectionView!
    @IBOutlet weak var pagger: UIPageControl!
    @IBOutlet weak var collectionViewMiddel: UICollectionView!
    @IBOutlet weak var labelHot: UILabel!
    @IBOutlet weak var labelNew: UILabel!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var cellsize = CGSize(width: 0, height: 0)
    var aDashboardViewModel = DashboardViewModel()
    var aDashboardModel : DashboardModel = DashboardModel()
    var aDashboardBanners : [DashboardBanner] = []
    var aDashboardHotProduct : [DashboardProduct] = []
    var aDashboardNewProduct : [DashboardProduct] = []
    
    var isHotLoading: Bool = false
    var isNewLoading: Bool = false
    var currentHotPageNo = 0
    var currentNewPageNo = 0
    var scrollingTimeInterval = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.getSideMenuCatagorys()
    }
    @IBAction func actionOnHotDeals(_ sender: Any) {
        if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
            aProductListViewController.aProductListType = .hot
            self.navigationController?.pushViewController(aProductListViewController, animated: true)
        }
    }
    @IBAction func actionOnNewCollection(_ sender: Any) {
        if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
            aProductListViewController.aProductListType = .new
            self.navigationController?.pushViewController(aProductListViewController, animated: true)
        }
    }
    @IBOutlet weak var collectionViewBottom: UICollectionView!
}
extension DashboardViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.textFieldSearch.text!.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
                    aProductListViewController.searchText = self.textFieldSearch.text!
                    self.navigationController?.pushViewController(aProductListViewController, animated: true)
                }
            }
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewTop {
            return self.aDashboardBanners.count
        }else if collectionView == collectionViewMiddel{
            return self.aDashboardHotProduct.count
        }else {
            return self.aDashboardNewProduct.count
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewTop {
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardTopCell", for: indexPath) as! DashboardTopCell
            collCell.constraintBannerWidth.constant = collectionView.bounds.size.width
            collCell.setBannerImage(url: self.aDashboardBanners[indexPath.row].fld_slider_image)
            return collCell
        }else if collectionView == collectionViewMiddel{
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardBottomCell", for: indexPath) as! DashboardBottomCell
            collCell.setCellData(aProduct: aDashboardHotProduct[indexPath.row])
            return collCell
        }else {
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardBottomCell", for: indexPath) as! DashboardBottomCell
            collCell.setCellData(aProduct: aDashboardNewProduct[indexPath.row])
           // collCell.labelDiscount.isHidden = true
            return collCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewTop {
            let height: CGFloat = collectionView.bounds.size.height
            let width: CGFloat = collectionView.bounds.size.width
            self.cellsize = CGSize(width: width, height: height)
            return cellsize
        }else {
            let height: CGFloat = collectionView.bounds.size.height
            let width: CGFloat = 150.0
            let cellsize = CGSize(width: width, height: height)
            return cellsize
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionViewTop {
            return 0
        }else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewTop {
            
        }else {
            if let aProductDetailsViewController = ProductDetailsViewController.getController(story: "Dashboard")  as? ProductDetailsViewController {
                if collectionView == collectionViewMiddel{
                    aProductDetailsViewController.aDashboardProduct = aDashboardHotProduct[indexPath.row]
                }else {
                    aProductDetailsViewController.aDashboardProduct = aDashboardNewProduct[indexPath.row]
                }
                self.navigationController?.pushViewController(aProductDetailsViewController, animated: true)
            }
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = self.cellsize.width
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        let index = IndexPath(item: Int(round(itemIndex)), section: 0)
        self.pagger.currentPage = index.row
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentOffsetX = scrollView.contentOffset.x
//        if contentOffsetX >= (scrollView.contentSize.width - scrollView.bounds.width) - 20 /* Needed offset */ {
//            if let collectionview  = scrollView as? UICollectionView {
//                if collectionview == self.collectionViewMiddel {
//                    guard !self.isHotLoading else { return }
//                    self.isHotLoading = true
//                    self.currentHotPageNo += 1
//                    self.getMoreProduct(aProductListType: .hot, page: self.currentHotPageNo)
//                }else if collectionview == self.collectionViewBottom {
//                    guard !self.isNewLoading else { return }
//                    self.isNewLoading = true
//                    self.currentNewPageNo += 1
//                    self.getMoreProduct(aProductListType: .new, page: self.currentNewPageNo)
//                }
//            }
//        }
    }
    
    @objc func scrollCollectionView(interval: Float) {
        self.perform(#selector(autoScroll), with: nil, afterDelay: TimeInterval(interval))
    }
    @objc func autoScroll() {
        if self.self.aDashboardBanners.count > 0 {
            let visibleRect = CGRect(origin: collectionViewTop.contentOffset, size: collectionViewTop.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = collectionViewTop.indexPathForItem(at: visiblePoint) {
                self.scrollFormIndex(nextIndex: visibleIndexPath.row + 1)
            }
        }
    }
    func scrollFormIndex(nextIndex: Int) {
        if nextIndex == self.aDashboardBanners.count {
            self.collectionViewTop.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.pagger.currentPage = 0
        } else {
            self.collectionViewTop.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.pagger.currentPage = nextIndex
        }
        if nextIndex + 1 == self.aDashboardBanners.count {
            scrollCollectionView(interval: Float(scrollingTimeInterval * 2))
        } else {
            scrollCollectionView(interval: Float(scrollingTimeInterval))
        }
    }
}


extension DashboardViewController{
    func productServiceCall(){
        self.showActivity()
        self.aDashboardViewModel.dasshboardProductServiceCall(afld_page_no: 0) { (model) in
            self.hideActivity()
            self.aDashboardModel = model
            self.updateUi()
            self.addRightBarButton()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func updateUi() {
        self.aDashboardBanners = self.aDashboardModel.aDashboardBanners
        self.pagger.numberOfPages = self.aDashboardBanners.count
        self.collectionViewTop.reloadData()
        self.aDashboardHotProduct = self.aDashboardModel.aDashboardHotDeals.aDashboardProduct
        self.aDashboardNewProduct = self.aDashboardModel.aDashboardNewCollection.aDashboardProduct
        self.labelHot.text = self.aDashboardModel.aDashboardHotDeals.title
        self.labelNew.text = self.aDashboardModel.aDashboardNewCollection.title
        self.collectionViewMiddel.reloadData()
        self.collectionViewBottom.reloadData()
        self.pagger.isUserInteractionEnabled = false
        self.collectionViewTop.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.autoScroll), object: nil)
        self.scrollCollectionView(interval: Float(self.scrollingTimeInterval))
    }
    func getSideMenuCatagorys() {
        self.showActivity()
        self.aDashboardViewModel.getSideMenuCatagorys { (model) in
            self.hideActivity()
            self.productServiceCall()
        } aFailed: { (error) in
            self.hideActivity()
            self.productServiceCall()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
//    func getMoreProduct(aProductListType:ProductListType, page: Int) {
//        self.showActivity()
//        self.aDashboardViewModel.featchMoreProductsServiceCall(productListType: aProductListType, afld_page_no: page) { (models) in
//            self.hideActivity()
//            if aProductListType == .hot {
//                for model in models {
//                    self.isHotLoading = false
//                    self.aDashboardHotProduct.append(model)
//                }
//                self.collectionViewMiddel.reloadData()
//            }else {
//                for model in models {
//                    self.isNewLoading = false
//                    self.aDashboardNewProduct.append(model)
//                }
//                self.collectionViewBottom.reloadData()
//            }
//        } aFailed: { (error) in
//            self.hideActivity()
//            self.showAlartWith(message: error!.localizedDescription)
//        }
//    }
}
