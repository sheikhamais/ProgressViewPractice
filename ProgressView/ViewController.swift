//
//  ViewController.swift
//  ProgressView
//
//  Created by Amais Sheikh	 on 02/08/2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
//        let hostingController = UIHostingController(rootView: CircularBarLoaderView(title: "Hello, please wait", barColor: .blue))
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let firstView = UIView()
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.backgroundColor = .white
        
//        let secondView = UIView()
//        secondView.translatesAutoresizingMaskIntoConstraints = false
//        secondView.backgroundColor = .white
//        secondView.layer.cornerRadius = 40
//
//        let thirdView = UIView()
//        thirdView.translatesAutoresizingMaskIntoConstraints = false
//        thirdView.backgroundColor = .white
        
        view.addSubview(firstView)
//        view.addSubview(secondView)
//        view.addSubview(thirdView)
        
//        addChild(hostingController)
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
//            secondView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            secondView.heightAnchor.constraint(equalToConstant: 280),
//            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
//
            firstView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            firstView.heightAnchor.constraint(equalToConstant: 580),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
//            hostingController.view.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 8),
//            hostingController.view.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -8),
//            hostingController.view.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 8),
//            hostingController.view.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -8)
            
//            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 20),
//            thirdView.heightAnchor.constraint(equalToConstant: 80),
//            thirdView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            thirdView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            firstView.showProgressView(style: .threeCircles("Hello, Wait", .blue, [.lightGray]))
        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            thirdView.showProgressView()
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            secondView.showProgressView()
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            secondView.hideProgressView()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            thirdView.hideProgressView()
//        }
    }
}

