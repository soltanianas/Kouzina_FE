//
//  TrackOrderVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit
import GoogleMaps

class TrackOrderVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: appDelegate.latitude, longitude: appDelegate.longitude, zoom: 18)
        let mapView = GMSMapView.map(withFrame: self.mainView.frame, camera: camera)
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        self.mainView.addSubview(mapView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
