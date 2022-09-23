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

class HomeViewController: UIViewController, MKMapViewDelegate {
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .dark
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    private lazy var targetBottomSheet: UIView = {
        let target = TargetBottomSheetView()
        target.translatesAutoresizingMaskIntoConstraints = false
        target.delegate = self
        return target
    }()
    
    private let locationManager: LocationManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.delegate = self
        
        if let coordinates = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coordinates, animated: true)
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
    
    // MARK: - BINDERS
    
    func setupBinders() {
        locationManager
            .$locationWasUpdated
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.createAnotation(withLocation: location)
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
        let saveTargetViewController = SaveTargetViewController(viewModel: SaveTargetViewModel())
        let navigationController = UINavigationController(rootViewController: saveTargetViewController)
        navigationController.modalPresentationStyle = .pageSheet
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(navigationController, animated: true, completion: nil)
    }
}

extension HomeViewController {
    
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
