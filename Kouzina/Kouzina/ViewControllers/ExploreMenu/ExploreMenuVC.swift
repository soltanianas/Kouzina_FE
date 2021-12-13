//
//  ExploreMenuVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit

class ExploreMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "ResturantMenuCell", bundle: nil), forCellReuseIdentifier: "ResturantMenuCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.reloadData()
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

extension ExploreMenuVC: UITableViewDelegate,UITableViewDataSource {
    
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
        let cell: ResturantMenuCell = self.tableView.dequeueReusableCell(withIdentifier: "ResturantMenuCell", for: indexPath) as! ResturantMenuCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
//        cell.imgView.sd_setImage(with: URL(string: TEST_IMAGE_URL), completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

