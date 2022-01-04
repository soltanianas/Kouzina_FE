//
//  HomeVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit
import AppCenter
import AppCenterCrashes

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // variables
    var plats = [Plat]()
    var platForDetails : Plat?
    
    // iboutlets
    @IBOutlet weak var platsTableView: UITableView!
    
    // protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        plats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let platImage = contentView.viewWithTag(1) as! UIImageView
        let descLabel = contentView.viewWithTag(2) as! UILabel
        let compoLabel = contentView.viewWithTag(3) as! UILabel
        let prixLabel = contentView.viewWithTag(4) as! UILabel
        let buttonLike = contentView.viewWithTag(5) as! UIButton
        
        let plat = plats[indexPath.row]
        
        if UserDefaults.standard.array(forKey: "favoriteFood") != nil {
            
            var favArray = UserDefaults.standard.array(forKey: "favoriteFood") as! [String]
            
            if favArray.contains(plat._id!){
                buttonLike.tintColor = UIColor.red
            } else {
                buttonLike.tintColor = UIColor.label
            }
            
        } else {
            buttonLike.tintColor = UIColor.label
        }
        
        buttonLike.addAction(UIAction(handler: { UIAction in
            
            if UserDefaults.standard.array(forKey: "favoriteFood") != nil {
                
                var newFavArray = UserDefaults.standard.array(forKey: "favoriteFood") as! [String]
                
                if newFavArray.contains(plat._id!){
                    buttonLike.tintColor = UIColor.label
                    newFavArray.removeAll(where: { value in  return value == plat._id! })
                    UserDefaults.standard.set(newFavArray, forKey: "favoriteFood")
                } else {
                    buttonLike.tintColor = UIColor.red
                    newFavArray.append(plat._id!)
                    UserDefaults.standard.set(newFavArray, forKey: "favoriteFood")
                }
                
            } else {
                buttonLike.tintColor = UIColor.red
                UserDefaults.standard.set([plat._id], forKey: "favoriteFood")
            }
            
        }), for: .touchUpInside)
        
        if (plat.image != nil) {
            if plat.image != "" {
                ImageLoader.shared.loadImage(
                    identifier: plat.image!,
                    url: "http://localhost:3000/img/" + plat.image!,
                    completion: { image in
                        platImage.image = image
                    })
            }
        }
        
        descLabel.text = plat.description
        compoLabel.text = plat.composition
        prixLabel.text = String(plat.prix)
        
        return cell
    }
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addOrderSegue" {
            let destination = segue.destination as! AddOrderView
            destination.plat = platForDetails
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppCenter.start(withAppSecret: "335f271d-7266-48fb-9221-b18e484c6457", services:[
          Crashes.self
        ])
    }
    
    var newBool = true
    
    override func viewDidAppear(_ animated: Bool) {
        if reachability.connection == .unavailable {
            showSpinner()
            self.showAlert(title: "Connectivity Problem", message: "Please check your internet connection ")
        }else
        { if (UserDefaults.standard.string(forKey: "isItNew")) == "isNew"{
            self.present(Alert.makeAlert(titre: "Bienvenue", message: "Bienvenu " + UserDefaults.standard.string(forKey: "userNom")!), animated: true, completion: nil)
            UserDefaults.standard.set("", forKey: "isItNew")
        }
            loadPlats()}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        platForDetails = plats[indexPath.row]
        self.performSegue(withIdentifier: "addOrderSegue", sender: platForDetails)
        
    }
    
    // methods
    func loadPlats() {
        PlatViewModel.sharedInstance.getAll { succes, reponse in
            if succes {
                self.plats = reponse!
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load plats"), animated: true)
            }
            self.platsTableView.reloadData()
        }
    }
    
    // actions
    @IBAction func btnFilterClicked(_ sender: Any) {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        obj.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func btnMenuAllClicked(_ sender: Any) {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "ExploreMenuVC") as! ExploreMenuVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    @IBOutlet weak var switcherBtn: UIButton!
    
    @IBAction func modeSwitcher(_ sender: Any) {
        
        let window = UIApplication.shared.keyWindow
        if #available(iOS 13.0, *) {
            if window?.overrideUserInterfaceStyle == .dark {
                switcherBtn.setTitle("Light mode", for: .normal)
                window?.overrideUserInterfaceStyle = .light
                
            } else {
                window?.overrideUserInterfaceStyle = .dark
                switcherBtn.setTitle("Dark mode", for: .normal)
            }
        }
    }
    
    
    
}
