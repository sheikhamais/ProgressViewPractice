//
//  FourDotsCircularView.swift
//  ProgressView
//
//  Created by Amais Sheikh	 on 04/08/2022.
//

import Foundation
import UIKit

class FourDotsCircularView: UIView {
    
    //MARK: - Section Name
    private var title: String?
    private var circularViewBackgroundColor: UIColor
    private var dotColorsArray: [UIColor]
    
    var circularContainerView: CircularView =
    {
        let obj = CircularView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    var allDots = [CircularView]()
    
    lazy var titleLabel: UILabel =
    {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: 14)
        obj.textAlignment = .center
        obj.text = title
        return obj
    }()
    
    //MARK: - Section Name
    init(title: String?, backgroundColor: UIColor, dotColorsArray: [UIColor]) {
        self.title = title
        self.circularViewBackgroundColor = backgroundColor
        self.dotColorsArray = dotColorsArray
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Section Name
    private func configureUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //creation of views
        circularContainerView.backgroundColor = circularViewBackgroundColor

        let dotsPlacementContainerView = UIView()
        dotsPlacementContainerView.translatesAutoresizingMaskIntoConstraints = false
        dotsPlacementContainerView.backgroundColor = .clear

        var colorIndexToIterate = 0
        let colorsArray = dotColorsArray.isNotEmpty ? dotColorsArray : [.white]
        for _ in 0...3 {
            let dot = CircularView()
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.backgroundColor = colorsArray[colorIndexToIterate]
            
            colorIndexToIterate += 1
            if colorIndexToIterate > dotColorsArray.endIndex - 1 {
                colorIndexToIterate = 0
            }
            
            allDots.append(dot)
        }

        //dots configuration
        var cornerToPlaceDotIn: UIRectCorner = .topLeft
        for dot in allDots {
            //subview
            dotsPlacementContainerView.addSubview(dot)
            
            //constraints
            dot.heightAnchor.constraint(equalToConstant: 18).isActive = true
            dot.widthAnchor.constraint(equalToConstant: 18).isActive = true
            
            switch cornerToPlaceDotIn {
            case .topLeft:
                dot.centerXAnchor.constraint(equalTo: dotsPlacementContainerView.leadingAnchor).isActive = true
                dot.centerYAnchor.constraint(equalTo: dotsPlacementContainerView.topAnchor).isActive = true
                cornerToPlaceDotIn = .topRight
                
            case .topRight:
                dot.centerXAnchor.constraint(equalTo: dotsPlacementContainerView.trailingAnchor).isActive = true
                dot.centerYAnchor.constraint(equalTo: dotsPlacementContainerView.topAnchor).isActive = true
                cornerToPlaceDotIn = .bottomRight
                
            case .bottomRight:
                dot.centerXAnchor.constraint(equalTo: dotsPlacementContainerView.trailingAnchor).isActive = true
                dot.centerYAnchor.constraint(equalTo: dotsPlacementContainerView.bottomAnchor).isActive = true
                cornerToPlaceDotIn = .bottomLeft
                
            case .bottomLeft:
                dot.centerXAnchor.constraint(equalTo: dotsPlacementContainerView.leadingAnchor).isActive = true
                dot.centerYAnchor.constraint(equalTo: dotsPlacementContainerView.bottomAnchor).isActive = true
                cornerToPlaceDotIn = .topLeft
                
            default:
                debugPrint("Function: \(#function): handle default case")
            }
        }
        
        //subviews
        addSubview(circularContainerView)
        circularContainerView.addSubview(dotsPlacementContainerView)
        
        //constraints
        NSLayoutConstraint.activate([
            dotsPlacementContainerView.widthAnchor.constraint(equalToConstant: 23),
            dotsPlacementContainerView.heightAnchor.constraint(equalToConstant: 23),
            dotsPlacementContainerView.leadingAnchor.constraint(equalTo: circularContainerView.leadingAnchor, constant: 20),
            dotsPlacementContainerView.trailingAnchor.constraint(equalTo: circularContainerView.trailingAnchor, constant: -20),
            dotsPlacementContainerView.topAnchor.constraint(equalTo: circularContainerView.topAnchor, constant: 20),
            dotsPlacementContainerView.bottomAnchor.constraint(equalTo: circularContainerView.bottomAnchor, constant: -20),
            
            circularContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circularContainerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            circularContainerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            circularContainerView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        //title configuration
        if let _ = title {
            addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                titleLabel.topAnchor.constraint(equalTo: circularContainerView.bottomAnchor, constant: 4),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            circularContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        //animations
        dotsPlacementContainerView.makeRepeatingRotations()
    }
}
