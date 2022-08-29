//
//  TestViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 23/08/2022.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()

        var titleLabel: UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "UIStackView inside UIScrollView."
            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            label.textColor = .white
            label.textAlignment = .center
            return label
        }

        for _ in 0...15 {
            stackView.addArrangedSubview(titleLabel)
        }
    }
    
    private func setupViews() {
        scrollView.backgroundColor = .lightGray
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

    }
    
    private func setupLayout() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
