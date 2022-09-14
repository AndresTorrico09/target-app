//
//  TargetBottomSheetViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 12/09/2022.
//

import UIKit

enum BottomSheetState {
    case initial
    case full
}

class BottomSheetContainerViewController<Content: UIViewController, BottomSheet: UIViewController> : UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Initialization
    public init(contentViewController: Content,
                bottomSheetViewController: BottomSheet,
                bottomSheetConfiguration: BottomSheetConfiguration) {
        
        self.contentViewController = contentViewController
        self.bottomSheetViewController = bottomSheetViewController
        configuration = bottomSheetConfiguration
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - Bottom Sheet Actions
    public func showBottomSheet(animated: Bool = true) {
        topConstraint.constant = -configuration.height
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .full
            })
        } else {
            view.layoutIfNeeded()
            state = .full
        }
    }
    
    public func hideBottomSheet(animated: Bool = true) {
        topConstraint.constant = -configuration.initialOffset
        
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: [.curveEaseOut],
                           animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .initial
            })
        } else {
            view.layoutIfNeeded()
            state = .initial
        }
    }
    
    // MARK: - Pan Action
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetViewController.view)
        let velocity = sender.velocity(in: bottomSheetViewController.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        
        switch sender.state {
        case .began, .changed:
            if state == .full {
                guard translation.y > 0 else { return }
                
                topConstraint.constant = -(configuration.height - yTranslationMagnitude)
                
                view.layoutIfNeeded()
            } else {
                let newConstant = -(configuration.initialOffset + yTranslationMagnitude)
                
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configuration.height else {
                    showBottomSheet()
                    return
                }
                
                topConstraint.constant = newConstant
                
                view.layoutIfNeeded()
            }
        case .ended:
            if state == .full {
                
                if velocity.y < 0 {
                    // Bottom Sheet was full initially and the user tried to move it to the top
                    showBottomSheet()
                } else if yTranslationMagnitude >= configuration.height / 2 || velocity.y > 1000 {
                    hideBottomSheet()
                } else {
                    showBottomSheet()
                }
            } else {
                
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y < -1000 {
                    
                    showBottomSheet()
                    
                } else {
                    hideBottomSheet()
                }
            }
        case .failed:
            if state == .full {
                showBottomSheet()
            } else {
                hideBottomSheet()
            }
        default: break
        }
    }
    
    // MARK: - Configuration
    public struct BottomSheetConfiguration {
        let height: CGFloat
        let initialOffset: CGFloat
    }
    
    private let configuration: BottomSheetConfiguration
    
    var state: BottomSheetState = .initial
    
    // MARK: - Children
    let contentViewController: Content
    let bottomSheetViewController: BottomSheet
    
    // MARK: - Top Constraint
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - Pan Gesture
    lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        return pan
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        addChild(contentViewController)
        addChild(bottomSheetViewController)
        
        view.addSubview(contentViewController.view)
        view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.view.addGestureRecognizer(panGesture)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentViewController.didMove(toParent: self)
        
        topConstraint = bottomSheetViewController.view.topAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -configuration.initialOffset
        )
        
        NSLayoutConstraint.activate([
            bottomSheetViewController.view.heightAnchor.constraint(equalToConstant: configuration.height),
            bottomSheetViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomSheetViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            topConstraint
        ])
        
        bottomSheetViewController.didMove(toParent: self)
    }
    
    // MARK: - UIGestureRecognizer Delegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
