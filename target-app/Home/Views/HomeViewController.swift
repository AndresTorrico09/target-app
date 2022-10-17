//
//  HomeViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 02/09/2022.
//

import UIKit
import MapKit
import Combine

protocol BottomSheetPresenter: AnyObject {
    func createTargetButtonTapped()
}

class HomeViewController: UIViewController {
    
    // MARK: - VIEWMODELS
    
    private let viewModel: HomeViewModel
    
    // MARK: - Outlets
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .dark
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    private lazy var createTargetView: UIView = {
        let target = CreateTargetView()
        target.translatesAutoresizingMaskIntoConstraints = false
        target.delegate = self
        return target
    }()
    
    private let locationManager: LocationManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager, viewModel: HomeViewModel) {
        self.locationManager = locationManager
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        applyDefaultUIConfigs()
        setupMapConstraints()
        setupBinders()
        
        viewModel.getTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.delegate = self
        
        if let coordinates = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coordinates, animated: true)
        }
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
    }
    
    // MARK: - ACTIONS
    
    @objc func longTap(sender: UIGestureRecognizer){
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: locationOnMap.latitude, longitude: locationOnMap.longitude)
            
            mapView.removeAnnotations([mapView.annotations].last!)
            viewModel.setLocationTapped(withLocation: location)
            createAnotation(withLocation: location)
        }
    }
    
    func setupMapConstraints() {
        view.addSubview(mapView)
        view.addSubview(createTargetView)
        
        createTargetView.attachHorizontally(to: view, leadingMargin: 0, trailingMargin: 0)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createTargetView.heightAnchor.constraint(equalToConstant: 100),
            createTargetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - BINDERS
    
    func setupBinders() {
        locationManager
            .$locationWasUpdated
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.createAnotation(withLocation: location)
            }.store(in: &cancellables)
        
        viewModel.$targets
            .sink{ [weak self] targets in
                targets.forEach { target in
                    let location = CLLocation(latitude: target.latitude, longitude: target.longitude)
                    self?.createAnotation(withLocation: location)
                }
            }.store(in: &cancellables)
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
    func createTargetButtonTapped() {
        let saveTargetViewController = SaveTargetViewController(
            viewModel: SaveTargetViewModel(
                location: viewModel.locationTapped!,
                targetServices: TargetServices()
            )
        )
        let navigationController = UINavigationController(rootViewController: saveTargetViewController)
        navigationController.modalPresentationStyle = .pageSheet
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(navigationController, animated: true, completion: nil)
    }
}

extension HomeViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
            pinView!.pinTintColor = UIColor.black
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //TODO: tapped on pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if (view.annotation?.title!) != nil {
                //TODO: add tap action
            }
        }
    }
    
    func createAnotation(withLocation location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "You are Here"
        mapView.addAnnotation(annotation)
    }
}
