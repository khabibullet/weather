//
//  ViewController.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

class ViewController: UIViewController {

    let baseLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        setupLabel()
    }

    func setupLabel() {
        baseLabel.translatesAutoresizingMaskIntoConstraints = false
        baseLabel.text = NSLocalizedString("Language", comment: "")
        view.addSubview(baseLabel)
        baseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        baseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

