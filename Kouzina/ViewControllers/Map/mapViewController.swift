//

//  Created by Apple Esprit on 16/12/2021.
//

import UIKit
import MapKit

class mapViewController: UIViewController , UISearchBarDelegate{

    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    
    let centerMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
       // button.setImage(UIImage(systemName: "search"), for: .normal)
        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()
    
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal), for: .normal)
       // button.setImage(UIImage(systemName: "search"), for: .normal)
        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        if reachability.connection == .unavailable {
            print("jawek mesh behy")
            //self.showAlert(title: "Connectivity Problem", message: "Please check your internet connection ")
        }else
      {  let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        configureLocationManager()
        configureMapView()
        enableLocationServices()
        createAnnotation(locations: annotationsLocation)}
    }
    
    // MARK: - Selectors
    
    @objc func handleCenterLocation() {
        centerMapOnUserLocation()
        centerMapButton.alpha = 0
    }
    
    // MARK: - Helper Functions
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        view.addSubview(centerMapButton)
        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true
        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.layer.cornerRadius = 50 / 2
        centerMapButton.alpha = 1
        
       
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
    let annotationsLocation = [
        ["title": "Damascino", "latitude": 36.85510241281418, "longitude": 10.172657852397252],
        ["title": "Tapas'ta", "latitude": 36.85283601031776 ,  "longitude":  10.182785872743514],
        ["title": "The Zink", "latitude": 36.8386179528496, "longitude": 10.177121047804077],
        ["title": "Harmlek", "latitude":  36.86850870220714, "longitude": 10.171625155142339],
        ["title": "Picanha Grill", "latitude": 36.86259487069567, "longitude": 10.165975018353809],
        ["title": "Chili's American grill", "latitude":  36.837548200240676, "longitude": 10.163014396695988],
        ["title": "The Bamboo", "latitude": 36.86000104374797, "longitude": 10.164131144843276],
        ["title": "Mama Time", "latitude": 36.90155268231556, "longitude": 10.125986405621882],
        ["title": "O'bar à crepes", "latitude": 36.86011573110303, "longitude": 10.178236846655786]


    ]
    func createAnnotation(locations: [[String : Any]]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"]as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)

            
        mapView.addAnnotation(annotations)
        }
    }
    @IBAction func userLocationTapped(_ sender: Any) {
        centerMapOnUserLocation()
    }
}

extension mapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.centerMapButton.alpha = 1
        }
    }
    
 
    }
    


// MARK: - CLLocationManagerDelegate

extension mapViewController: CLLocationManagerDelegate {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location auth status is RESTRICTED")
        case .denied:
            print("Location auth status is DENIED")
        case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard locationManager.location != nil else { return }
        centerMapOnUserLocation()
    }
}

extension mapViewController {
    @objc func swipeAction(swipe:UISwipeGestureRecognizer){
        switch swipe.direction.rawValue {
        case 2:
            performSegue(withIdentifier: "mapToHomeSegue", sender: self)
        default:
            break
        }
    }
}


    
  




