//
//  ImageZoomViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit
class ImageZoomCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        scrollview.delegate = self
        let doubleTapGest = UITapGestureRecognizer(target: self,
             action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollview.addGestureRecognizer(doubleTapGest)
        
    }
    func setUpCellImage(aImageUrl: String) {
        let url = URL(string: aImageUrl)
        self.imageview.kf.indicatorType = .activity
        self.imageview.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
    }
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollview.zoomScale == 1 {
            scrollview.zoom(to: zoomRectForScale(scale: scrollview.maximumZoomScale,
            center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollview.setZoomScale(1, animated: true)
        }
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageview.frame.size.height / scale
        zoomRect.size.width  = imageview.frame.size.width  / scale
        let newCenter = imageview.convert(center, from: scrollview)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageview
    }
}
class ImageZoomViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!
    var cellsize = CGSize(width: 0, height: 0)
    var aImages: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.pager.numberOfPages = aImages.count
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ImageZoomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aImages.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageZoomCell", for: indexPath) as! ImageZoomCell
        collCell.constraintWidth.constant = collectionView.frame.size.width
        collCell.constraintHeight.constant = collectionView.frame.size.height
        collCell.scrollview.minimumZoomScale = 1.0
        collCell.scrollview.maximumZoomScale = 5.0
        collCell.setUpCellImage(aImageUrl: aImages[indexPath.row])
        return collCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellsize = CGSize(width: self.view.frame.width, height: self.collectionView.bounds.height )
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = self.cellsize.width
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        let index = IndexPath(item: Int(round(itemIndex)), section: 0)
        self.pager.currentPage = index.row
    }
}
