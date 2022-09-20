//
//  HomeViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 02/09/2022.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    private let locationManager = CLLocationManager()
    
    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation]
    ) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are Here"
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultUIConfigs()
        setupNavigationBar()
        setupMapConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LocationManager.shared.requestLocationAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.title = "home_title".localized
        
        let barLeftButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_home_profile"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.leftBarButtonItem = barLeftButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let barRightButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_home_chat"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = barRightButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func setupMapConstraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
