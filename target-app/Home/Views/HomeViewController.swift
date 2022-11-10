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

protocol BottomSheetManager {
    var bottomSheet: BottomSheet { get }
    
    func presentBottomSheet()
    func dismissBottomSheet()
    func setControllerIntoBottomSheet(_ viewController: UIViewController)
}

extension BottomSheetManager where Self: UIViewController {
    func presentBottomSheet() {
        bottomSheet.present()
    }
    
    func dismissBottomSheet() {
        bottomSheet.dismiss()
    }
    
    func setControllerIntoBottomSheet(_ viewController: UIViewController) {
        view.addSubview(bottomSheet)
        
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheet.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomSheet.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        addChild(viewController)
        viewController.didMove(toParent: self)
        bottomSheet.setView(viewController.view)
    }
}

protocol MatchPopUpPresenter: AnyObject {
    var matchPopUpView: MatchPopUpView { get }
    
    func startChattingButtonTapped()
    func skipButtonTapped()
    func displayPopUpMatch(match: MatchedUser)
}

extension MatchPopUpPresenter where Self: UIViewController {
    func displayPopUpMatch(match: MatchedUser) {
        view.addSubview(matchPopUpView)
        view.bringSubviewToFront(matchPopUpView)
    
        matchPopUpView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            matchPopUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            matchPopUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            matchPopUpView.widthAnchor.constraint(equalToConstant: 250),
            matchPopUpView.heightAnchor.constraint(equalToConstant: 450),
        ])
    }
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
    
    var matchPopUpView = MatchPopUpView()
    
    var bottomSheet = BottomSheet()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Events

    override func viewDidLoad() {
        super.viewDidLoad()

        applyDefaultUIConfigs()
        configureViews()

        setupBinders()
        viewModel.getTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.delegate = self
        
        if let coordinates = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coordinates, animated: true)
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
        viewModel.locationManager
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
        
        viewModel.userMatched
            .sink { [weak self] userMatched in
                self?.displayPopUpMatch(match: userMatched)
            }.store(in: &cancellables)
    }
    
    // MARK: - Actions

    @objc
    func tapOnChatBarButton(_ sender: Any) {
        AppNavigator.shared.navigate(to: HomeRoutes.chats, with: .changeRoot)
    }
    
}

extension HomeViewController {
    func configureViews() {
        
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_home_profile"),
            style: .plain,
            target: self,
            action: nil
        )
        
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_home_chat"),
            style: .plain,
            target: self,
            action: #selector(tapOnChatBarButton)
        )
        
        setupNavigationBar(
            title: "home_title".localized,
            leftButton: leftBarButtonItem,
            rightButton: rightBarButtonItem
        )
        setupMapConstraints()
    }
}

// MARK: BottomSheetPresenter

extension HomeViewController: BottomSheetPresenter {
    func createTargetButtonTapped() {
        
        let saveTargetViewController = SaveTargetViewController(viewModel: viewModel.createSaveTargetViewModel())
        setControllerIntoBottomSheet(saveTargetViewController)
        presentBottomSheet()
    }
}

extension HomeViewController: MatchPopUpPresenter {
    
    func startChattingButtonTapped() {
        //TODO: add action
    }
    
    func skipButtonTapped() {
        //TODO: add action
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

extension HomeViewController: BottomSheetManager { }


