//
//  ViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 10/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Hello world!"
    }
    
}

