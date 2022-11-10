//
//  BottomSheet.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 09/11/2022.
//

import Foundation
import UIKit

final class BottomSheet: UIView {
    
    private let viewHeight = UIScreen.main.bounds.height / 2
    private let draggingViewHeight = 20.0

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var draggingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let dragAction = UIPanGestureRecognizer(target: self, action: #selector(onDraggingGesture))
        view.addGestureRecognizer(dragAction)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    @objc func onDraggingGesture(_ sender: UIPanGestureRecognizer) {
        guard sender.translation(in: self).y > 0 else { return }
        dismiss()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubviews(subviews: [
            draggingView,
            containerView
        ])
    }
    
    private func setConstraints() {
        
        [draggingView,
         containerView
        ].forEach {
            $0.attachHorizontally(
                to: self,
                leadingMargin: 0,
                trailingMargin: 0
            )
        }
        
        NSLayoutConstraint.activate([
            draggingView.topAnchor.constraint(equalTo: topAnchor),
            draggingView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            draggingView.heightAnchor.constraint(equalToConstant: draggingViewHeight),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: viewHeight)
        ])
    }
    
    private func setUp() {
        dismiss(animate: false)
    }
    
    func present() {
        UIView.animate(withDuration: 0.5) {
            self.transform = .identity
        }
    }
    
    func dismiss(animate: Bool = true) {
        if animate {
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(translationX: .zero, y: self.viewHeight)
            }
        } else {
            self.transform = CGAffineTransform(translationX: .zero, y: self.viewHeight)
        }
    }
    
    private func configureViews() {
        backgroundColor = .white
        
        addViews()
        setConstraints()
        setUp()
    }
    
    func setView(_ view: UIView) {
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
}
