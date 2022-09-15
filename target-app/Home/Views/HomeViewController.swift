//
//  HomeViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 02/09/2022.
//

import UIKit
import MapKit

protocol BottomSheetPresenter: AnyObject {
    func presentBottomSheet()
}

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    lazy var targetBottomSheet: UIView = {
        let target = TargetBottomSheetView()
        target.translatesAutoresizingMaskIntoConstraints = false
        target.delegate = self
        return target
    }()
    
    let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
                         locations: [CLLocation]) {
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
        
        setupNavigationBar()
        applyDefaultUIConfigs()
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
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    
    func setupMapConstraints() {
        view.addSubview(mapView)
        view.addSubview(targetBottomSheet)
        
        targetBottomSheet.attachHorizontally(to: view, leadingMargin: 0, trailingMargin: 0)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            targetBottomSheet.heightAnchor.constraint(equalToConstant: 100),
            targetBottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.titleView = UILabel(style: .secondary(text: "home_title".localized))
        
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
    
}

// MARK: BottomSheetPresenter

extension HomeViewController: BottomSheetPresenter {
    func presentBottomSheet() {
        let saveTargetBottomSheetViewController = SaveTargetBottomSheetViewController()
        let navigationController = UINavigationController(rootViewController: saveTargetBottomSheetViewController)
        navigationController.modalPresentationStyle = .pageSheet
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(navigationController, animated: true, completion: nil)
    }
}
