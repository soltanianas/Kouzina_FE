//
//  OrdersVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit
import FittedSheets

class OrdersVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    var sheetController: SheetViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
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
    
    @IBAction func btnCheckOutClicked(_ sender: Any) {

    }
}

extension OrdersVC: UITableViewDelegate,UITableViewDataSource {
    
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
        let cell: OrdersCell = self.tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as! OrdersCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        
        let imageText = (indexPath.row == 0 || indexPath.row == 1) ? "ic_process" : "ic_reorder"
        cell.btnProcess.setImage(UIImage(named: imageText), for: .normal)
        
        let textcolor = (indexPath.row == 0 || indexPath.row == 1) ? "53E88B" : "BEBEBE"
        cell.lblPrice.textColor = UIColor(hexString: textcolor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "DetailsMenuVC") as! DetailsMenuVC
        
        let imageName = "ic_menu_photo.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.tag = 1387
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: getHeight(width: self.view.bounds.width))
        self.view.addSubview(imageView)
        
        
        let options = SheetOptions(
            // The full height of the pull bar. The presented view controller will treat this area as a safearea inset on the top
            pullBarHeight: 24,
            
            // The corner radius of the shrunken presenting view controller
            presentingViewCornerRadius: 20,
            
            // Extends the background behind the pull bar or not
            shouldExtendBackground: true,
            
            // Attempts to use intrinsic heights on navigation controllers. This does not work well in combination with keyboards without your code handling it.
            setIntrinsicHeightOnNavigationControllers: true,
            
            // Pulls the view controller behind the safe area top, especially useful when embedding navigation controllers
            useFullScreenMode: true,
            
            // Shrinks the presenting view controller, similar to the native modal
            shrinkPresentingViewController: false,
            
            // Determines if using inline mode or not
            useInlineMode: false,
            
            // Adds a padding on the left and right of the sheet with this amount. Defaults to zero (no padding)
            horizontalPadding: 0,
            
            // Sets the maximum width allowed for the sheet. This defaults to nil and doesn't limit the width.
            maxWidth: nil
        )
        
        sheetController = SheetViewController(
            controller: obj,
            sizes: [.percent(0.50), .fullscreen], options: options)
        
        sheetController?.didDismiss = { _ in
            if let viewWithTag = self.view.viewWithTag(1387) {
                viewWithTag.removeFromSuperview()
            }
        }
        sheetController?.shouldDismiss = { _ in
            if let viewWithTag = self.view.viewWithTag(1387) {
                viewWithTag.removeFromSuperview()
            }
            return true
        }
        sheetController?.cornerRadius = 25
        self.present(sheetController!, animated: true, completion:  nil)
    }
    
    func getHeight(width: CGFloat) -> CGFloat{
        return (width * 442) / 375
    }
}

