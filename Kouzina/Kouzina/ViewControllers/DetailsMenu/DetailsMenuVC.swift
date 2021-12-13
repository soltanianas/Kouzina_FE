//
//  DetailsMenuVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit

class DetailsMenuVC: UIViewController {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDescription.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 2)
        
        self.tableView.register(UINib(nibName: "DetailsMenuCell", bundle: nil), forCellReuseIdentifier: "DetailsMenuCell")
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
    
    
    @IBAction func btnAddToChartClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension DetailsMenuVC: UITableViewDelegate,UITableViewDataSource {
    
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsMenuCell = self.tableView.dequeueReusableCell(withIdentifier: "DetailsMenuCell", for: indexPath) as! DetailsMenuCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        
//        let imageText = (indexPath.row == 0 || indexPath.row == 1) ? "ic_process" : "ic_reorder"
//        cell.btnProcess.setImage(UIImage(named: imageText), for: .normal)
//        
//        let textcolor = (indexPath.row == 0 || indexPath.row == 1) ? "53E88B" : "BEBEBE"
//        cell.lblPrice.textColor = UIColor(hexString: textcolor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
