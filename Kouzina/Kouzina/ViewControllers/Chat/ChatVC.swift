//
//  ChatVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtMessage: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TextLeftCell", bundle: nil), forCellReuseIdentifier: "TextLeftCell")
        self.tableView.register(UINib(nibName: "TextRightCell", bundle: nil), forCellReuseIdentifier: "TextRightCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSendClicked(_ sender: Any) {
        self.txtMessage.text = ""
    }
}


extension ChatVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 2 {
            let cell: TextLeftCell = self.tableView.dequeueReusableCell(withIdentifier: "TextLeftCell", for: indexPath) as! TextLeftCell
            cell.selectionStyle = .none
            cell.tag = indexPath.row
            cell.lblTitle.text = indexPath.row == 0 ? "Just to order" : "Attendez une minute"
            return cell
        }
        else {
            let cell: TextRightCell = self.tableView.dequeueReusableCell(withIdentifier: "TextRightCell", for: indexPath) as! TextRightCell
            cell.selectionStyle = .none
            cell.tag = indexPath.row
            cell.lblTitle.text = indexPath.row == 1 ? "Ok !      piquant ou pas  Monsieur?" : "Ok je vous attends  👍"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
