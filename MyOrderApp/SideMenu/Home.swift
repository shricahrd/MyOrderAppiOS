//  ViewController.swift
//  DemoSlider
//  Created by RAKESH KUSHWAHA on 09/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import SideMenu
class Home: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var menu: SideMenuNavigationController?
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var imageDetailBg: UIImageView!
    @IBOutlet var hostButton: UIButton!
    @IBOutlet var verticlehight: NSLayoutConstraint!
    @IBOutlet var viewButtonBG: UIView!
    @IBOutlet var hightconstraint: NSLayoutConstraint!
    @IBOutlet var quizButton: UIButton!
    @IBOutlet var imagequiz: UIImageView!
    @IBOutlet var joinButton: UIButton!
    @IBOutlet var imagejoin: UIImageView!
    @IBOutlet var titleName: UIBarButtonItem!
    
    var quizSelect = false
    var scrollView = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var pageControl : UIPageControl!
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var tableViewList = UITableView()
    var arraysection = [String]()
    
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    enum TableSection {
        static let hotDeal = 0
        static let newCollection = 1
        static let count = 2
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       menu = SideMenuNavigationController(rootViewController: MenuListController())
       menu?.leftSide = true
       menu?.setNavigationBarHidden(true, animated: true)
       SideMenuManager.default.leftMenuNavigationController = menu
       SideMenuManager.default.addPanGestureToPresent(toView: self.view)
       arraysection = ["Hot Deal","New Collection"]
       addNavBarImage()
       scrollView = UIScrollView(frame: CGRect(x:0, y:80, width:self.view.frame.width,height: 220))
       pageControl = UIPageControl(frame: CGRect(x:0,y: 300, width:self.view.frame.width, height:50))
       configurePageControl()
       scrollView.delegate = self
       scrollView.isPagingEnabled = true
       scrollView .showsHorizontalScrollIndicator = false
       self.view.addSubview(scrollView)

       for index in 0..<4 {
           frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
           frame.size = self.scrollView.frame.size
           let subView = UIView(frame: frame)
           subView.backgroundColor = colors[index]
           self.scrollView .addSubview(subView)
        }
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        registerNibs()
    }

    func registerNibs() {
        tableViewList = UITableView()
        tableViewList.frame = CGRect(x:0,y: pageControl.frame.maxY + 2, width:self.view.frame.width, height:self.view.frame.height - (pageControl.frame.maxY + 4))
        tableViewList.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.separatorStyle = .none
        tableViewList.keyboardDismissMode = .interactive
        tableViewList.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
        self.view.addSubview(tableViewList)
     }
    
     func configurePageControl() {
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(pageControl)
     }

     // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
     @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
     }

     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
         pageControl.currentPage = Int(pageNumber)
     }

    
    func addNavBarImage() {
          let navController = navigationController!
          let image = UIImage(named: "logo")
          let imageView = UIImageView(image: image)
          let bannerWidth = navController.navigationBar.frame.size.width
          let bannerHeight = navController.navigationBar.frame.size.height
          let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
          let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
          imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
          imageView.contentMode = .scaleAspectFit
          //imageView.backgroundColor = .yellow
          navigationItem.titleView = imageView
      }

    @IBAction func quizAction(_ sender: Any) {
        if quizSelect == false {
           quizSelect = true
           quizButton.isHidden = true
           //imagequiz.isHidden = true
           UIView.animate(withDuration: 2, delay: 2, options: .curveEaseIn, animations: {
               self.viewButtonBG.isHidden = false
               self.hightconstraint.constant = 150
           }) { _ in
                print("complete animation")
           }
        } else {
            quizSelect = false
            UIView.animate(withDuration: 2, delay: 2, options: .curveEaseIn, animations: {
                self.viewButtonBG.isHidden = true
                self.hightconstraint.constant = 0
            }) { _ in
                print("complete animation")
            }
        }
    }
    
    
    @IBAction func didTapMenu(){
        present(menu!,animated: true)
    }
    
    // MARK: - Tableview Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return arraysection.count
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == TableSection.hotDeal {
//            return 1
//        } else if section == TableSection.newCollection {
//            return 5
//        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50
    }
      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
      
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if section == TableSection.hotDeal {
             return 50
          } else if section == TableSection.newCollection {
             return 50
          }
          return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 35)
        sectionHeader.backgroundColor = .white
        let heading = UILabel()
        heading.frame = CGRect(x: 10, y: 5, width: tableView.frame.size.width-20, height: 25)
        heading.text = arraysection[section]
        heading.font = UIFont.boldSystemFont(ofSize: 20)
        heading.textColor = .black
        heading.backgroundColor = .white
        sectionHeader.addSubview(heading)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
        cell.viewBG.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
      
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(cell.viewBG.frame.width), height: CGFloat(cell.viewBG.frame.height)), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.bounces = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cell.viewBG.addSubview(collectionView)
        
        if indexPath.row == indexPath.section {
        }
        
         return cell
      }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)

      }
    
      // MARK: - Collection View Data Source and Delegate Methods
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 5
      }
      
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
          return CGSize(width: 0, height: 0)
      }
      

      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
          for view: UIView in (cell?.contentView.subviews)! {
              view.removeFromSuperview()
          }
          let viewBG: UIView! = UIView()
          viewBG.frame = CGRect(x: 4, y: 5, width: (cell?.frame.size.width)!-8, height: (cell?.frame.size.height)!-8)
          viewBG.backgroundColor = .white
          viewBG.layer.cornerRadius = 8
          viewBG.clipsToBounds = true
          cell?.contentView.addSubview(viewBG)
          
          let imageProduct: UIImageView! = UIImageView()
          imageProduct.frame = CGRect(x: 10, y: 10, width: viewBG.frame.size.width - 20, height: viewBG.frame.size.height - 100)
          imageProduct.image = UIImage(named: "imagegrid")
          imageProduct.contentMode = .scaleAspectFit
          imageProduct.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
          imageProduct.layer.cornerRadius = 6
          imageProduct.clipsToBounds = true;
          viewBG.addSubview(imageProduct)

          let nameProduct: UILabel! = UILabel()
          nameProduct.frame = CGRect(x: 2, y: imageProduct.frame.maxY+1, width: imageProduct.frame.size.width-4, height: 20)
          nameProduct.text = "Provogue"
          nameProduct.numberOfLines = 1
          nameProduct.backgroundColor = .clear
          nameProduct.textAlignment = .left
        nameProduct.textColor = .lightGray
          nameProduct.font = UIFont(name: nameProduct.font.fontName, size: 14)
          viewBG.addSubview(nameProduct)
        
          let productType: UILabel! = UILabel()
          productType.frame = CGRect(x: 2, y: nameProduct.frame.maxY+1, width: nameProduct.frame.size.width-4, height: 30)
          productType.text = "T-shirt"
          productType.numberOfLines = 1
          productType.backgroundColor = .clear
          productType.textAlignment = .left
          productType.textColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
          productType.font = UIFont(name: productType.font.fontName, size: 18)
          viewBG.addSubview(productType)
        
          let rupee: UILabel! = UILabel()
          rupee.frame = CGRect(x: 2, y: productType.frame.maxY, width: nameProduct.frame.size.width/2, height: 30)
          rupee.text = "\u{20B9}850"
          rupee.numberOfLines = 1
          rupee.backgroundColor = .clear
          rupee.textAlignment = .left
          rupee.textColor = .darkText
          rupee.font = UIFont(name: rupee.font.fontName, size: 16)
          viewBG.addSubview(rupee)
        
          let discount: UILabel! = UILabel()
          discount.frame = CGRect(x: rupee.frame.maxX+2, y: productType.frame.maxY, width: nameProduct.frame.size.width/2, height: 30)
          discount.text = "\u{20B9}1050"
          discount.numberOfLines = 1
          discount.backgroundColor = .clear
          discount.textAlignment = .left
          discount.textColor = .gray
          discount.font = UIFont(name: discount.font.fontName, size: 16)
          viewBG.addSubview(discount)
        
          let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "  \(discount.text!)  " )
          attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 3, range: NSMakeRange(0, attributeString.length))
          discount.attributedText = attributeString

          return cell!
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  CGFloat((self.view.frame.size.width) / 2.1), height: 305)
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 1
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 1
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 7, right: 2)
      }
      
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

      }

}


class MenuListController: UITableViewController {//Comming soon:
    var items = ["", "Search by Category", "Men", "Women", "Kids", "My Orders", "Wishlist", "Cart", "Invoice", "Ledger", "Issues", "About", "Help & Support"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    func registerNibs() {
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MenuUserNameCell", bundle: nil), forCellReuseIdentifier: "MenuUserNameCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else {
            return 50
        }
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      

        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier:"MenuUserNameCell", for: indexPath as IndexPath) as! MenuUserNameCell
            cell.viewBG.backgroundColor = .white
            cell.contentView.backgroundColor = .white
            //cell.imagemenuBag.image = items[indexPath.row]
            cell.userName.text = "Hello, Rakesh Kumar"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"CategoryCell", for: indexPath as IndexPath) as! CategoryCell
            cell.name.text = items[indexPath.row]
            cell.name.textColor = .darkText
            cell.contentView.backgroundColor = .white
            
            if indexPath.row == 1 {
                cell.contentView.backgroundColor = .lightGray
                cell.imageArrow.isHidden = true
            } else {
                
            }
            return cell
        }
        return UITableViewCell()
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "ChangeLanguageViewController") as? ChangeLanguageViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 3 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "SignOutViewController") as? SignOutViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 4 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "FriendListViewController") as? FriendListViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        
        if indexPath.row > 4 {
            if indexPath.row == 5 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "DownloadViewController") as? DownloadViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 6 {
               let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
               if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "InvitesViewController") as? InvitesViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 7 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "MywalletViewController") as? MywalletViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 8 {
               let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
               if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as? MessageViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
               }
            }
            if indexPath.row == 9 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizMarketViewController") as? QuizMarketViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 10 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizhistoryViewController") as? QuizhistoryViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 11 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizbattelViewController") as? QuizbattelViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 12 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizbattelViewController") as? QuizbattelViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 13 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizLeagueViewController") as? QuizLeagueViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }

        }

    }
    
}
