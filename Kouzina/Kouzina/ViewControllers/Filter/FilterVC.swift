//
//  FilterVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit

class FilterVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    var titleArray:  [String] = ["Type", "Emplacement", "Type de repas"]
    var tagsArray:  [[String]] = [["Restaurant", "Menu"], ["1 Km", ">10 Km", "<10 Km"], ["Cake", "Soupe", "Course de produits", "Appetizer", "Dessert"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ResturantTagCell", bundle: nil), forCellReuseIdentifier: "ResturantTagCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSearchClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadData() {
        self.tableView.reloadData {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(self.tableView.contentSize.height)
                self.heightTableView.constant = self.tableView.contentSize.height
            }
        }
    }
}

extension FilterVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.heightTableView.constant = self.tableView.contentSize.height
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ResturantTagCell", for: indexPath) as! ResturantTagCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        DispatchQueue.main.async {
            self.heightTableView.constant = self.tableView.contentSize.height
        }
        cell.lblTitle.text = self.titleArray[indexPath.row]
        cell.addTagView(tags: self.tagsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

