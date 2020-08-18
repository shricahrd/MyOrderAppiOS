//
//  SearchByBrandController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 19/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class SearchByBrandController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var textFieldSearch: UITextField!
    @IBOutlet var tableViewList: UITableView!
    @IBOutlet var searchbutton: UIButton!
    
    var arrayData = ["Top wear", "Bottom wear", "Accessories"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var customPopUp: UIView!
    var tableviewPopUp: UITableView!
    var arraySelecteditems = NSMutableArray()
    
    
    // MARK: - Data
       //
       
       struct Section {
           var name: String!
           var items: [String]!
           var collapsed: Bool!
           
           init(name: String, items: [String], collapsed: Bool = false) {
               self.name = name
               self.items = items
               self.collapsed = collapsed
           }
       }
    
    
    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
                   Section(name: "Top Wear", items: ["T-Shirt", "Full-Shirt"]),
                   Section(name: "Bottom Wear", items: ["T-Shirt", "Full-Shirt"]),
                   Section(name: "Accessories", items: ["T-Shirt", "Full-Shirt"])
               ]
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        self.registerNib()
        
        textFieldSearch.layer.borderColor = UIColor.gray.cgColor
        textFieldSearch.layer.borderWidth = 1
        textFieldSearch.layer.cornerRadius = 25
        textFieldSearch.clipsToBounds = true
        
        //popUp()
    }
    
    @IBAction func cartAction(_ sender: Any) {
        callPopUp()
    }
    
    func registerNib() {
        tableViewList.register(UINib(nibName: "searchbybrandCell", bundle: nil), forCellReuseIdentifier: "searchbybrandCell")
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.separatorStyle = .none
    }
    
    func popUp()  {
        customPopUp = UIView()
        customPopUp.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        customPopUp.backgroundColor =  UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
        self.view.addSubview(customPopUp)
        customPopUp.isHidden = true
      
        let viewBg = UIView()
        viewBg.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
        viewBg.backgroundColor = UIColor.white
        viewBg.layer.cornerRadius = 35
        viewBg.clipsToBounds = true
        customPopUp.addSubview(viewBg)
        
        let title: UILabel! = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: viewBg.frame.size.width, height: 50)
        title.text = "Sort by"
        title.numberOfLines = 1
        title.backgroundColor = .clear
        title.textAlignment = .center
        title.textColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 16)
        viewBg.addSubview(title)
        
        tableviewPopUp = UITableView()
        tableviewPopUp.frame = CGRect(x: 0, y: title.frame.maxY, width: viewBg.frame.size.width, height: viewBg.frame.height - (title.frame.maxY))
        tableviewPopUp.backgroundColor = .clear
        tableviewPopUp.delegate = self
        tableviewPopUp.dataSource = self
        tableviewPopUp.separatorStyle = .none
        tableviewPopUp.register(UINib(nibName: "popCell", bundle: nil), forCellReuseIdentifier: "popCell")
        viewBg.addSubview(tableviewPopUp)
  
    }
    
    func callPopUp() {
         UIView.animate(withDuration: Double(0.5),
                                  delay: 0.0,
                                  options: .beginFromCurrentState, animations: { () -> Void in
                                   self.customPopUp.isHidden = false
         }, completion: { (Bool) -> Void in
                   })
    }
    
    
    
      @IBAction func searchAction(_ sender: Any) {
    
      }
    
      // MARK: - TableView Delegate Methods
       func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
       
//       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayData.count
//       }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if section == 0 {
               return 1
           }
           
           // For section 1, the total count is items count plus the number of headers
           var count = sections.count
           
           for section in sections {
               count += section.items.count
           }
           
           return count
       }
    
    
//     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//            case 0:  return "Manufacture"
//            case 1:  return "Products"
//            default: return ""
//        }
//    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.rowHeight
        }
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        // Header has fixed height
        if row == 0 {
            return 50.0
        }
        
        return sections[section].collapsed! ? 0 : 44.0
    }

    
    
    
    
    
    
    
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70
       }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "searchbybrandCell") as! searchbybrandCell?
//            cell?.textLabel?.text = "Apple"
//
//            return  cell!
//           }
           
           // Calculate the real section index and row index
           let section = getSectionIndex(indexPath.row)
           let row = getRowIndex(indexPath.row)
           
           if row == 0 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "searchbybrandCell") as! searchbybrandCell
               cell.title.text = sections[section].name
               cell.addButton.tag = section
               cell.addButton.setTitle(sections[section].collapsed! ? "+" : "-", for: UIControl.State())
               cell.addButton.addTarget(self, action: #selector(SearchByBrandController.toggleCollapse), for: .touchUpInside)
               return cell
           } else {
               let cell = tableView.dequeueReusableCell(withIdentifier: "searchbybrandCell") as! searchbybrandCell?
               cell?.textLabel?.text = sections[section].items[row - 1]
               return cell!
           }
       }
    
    
    
    
    
       
//       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//           return UITableView.automaticDimension
//       }

//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//             if let cell = tableView.dequeueReusableCell(withIdentifier: "searchbybrandCell", for: indexPath) as? searchbybrandCell {
//               cell.selectionStyle = .none
//               cell.title.text = "   \(arrayData[indexPath.row])"
//               cell.backgroundColor = UIColor(red:255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//               cell.title.textColor = UIColor(red:0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//               cell.addButton.addTarget(self, action: #selector(self.addAction), for: UIControl.Event.touchUpInside)
//               return cell
//        }
//           return UITableViewCell()
//       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem

       }
    
    @objc func addAction(_ sender: UIButton) {
        
        
        
    }
    
    
    //
       // MARK: - Event Handlers
       //
       @objc func toggleCollapse(_ sender: UIButton) {
           let section = sender.tag
           let collapsed = sections[section].collapsed
           
           // Toggle collapse
           sections[section].collapsed = !collapsed!
           
           let indices = getHeaderIndices()
           
           let start = indices[section]
           let end = start + sections[section].items.count
           
           tableViewList.beginUpdates()
           for i in start ..< end + 1 {
               tableViewList.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
           }
           tableViewList.endUpdates()
       }
       
    
    
    //
      // MARK: - Helper Functions
      //
      func getSectionIndex(_ row: NSInteger) -> Int {
          let indices = getHeaderIndices()
          
          for i in 0..<indices.count {
              if i == indices.count - 1 || row < indices[i + 1] {
                  return i
              }
          }
          
          return -1
      }
      
      func getRowIndex(_ row: NSInteger) -> Int {
          var index = row
          let indices = getHeaderIndices()
          
          for i in 0..<indices.count {
              if i == indices.count - 1 || row < indices[i + 1] {
                  index -= indices[i]
                  break
              }
          }
          
          return index
      }
      
      func getHeaderIndices() -> [Int] {
          var index = 0
          var indices: [Int] = []
          
          for section in sections {
              indices.append(index)
              index += section.items.count + 1
          }
          
          return indices
      }

}
