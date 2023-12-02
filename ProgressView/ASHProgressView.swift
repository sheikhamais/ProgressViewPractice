//
//  ASHProgressView.swift
//  ProgressView
//
//  Created by Amais Sheikh	 on 02/08/2022.
//

import Foundation
import UIKit
import SwiftUI

class ASHProgressView: UIView {
    
    //MARK: - Section Name
    enum ProgressViewStyle {
        case fourCircles(String?, UIColor, [UIColor])
        case threeCircles(String?, UIColor, [UIColor])
        case gradientCircle(String?, [UIColor])
        case plainCircle(String?, UIColor)
    }
    
//    static var progressViewStyle: ProgressViewStyle = .fourCircles(nil, .black.withAlphaComponent(0.4), [.white])
//    static var progressViewStyle: ProgressViewStyle = .threeCircles(nil, .black.withAlphaComponent(0.4), [.white])
//    static var progressViewStyle: ProgressViewStyle = .plainCircle("Loading", .red)
//    static var progressViewStyle: ProgressViewStyle = .gradientCircle("Loading", [.red, .systemIndigo])
    private var progressViewStyle: ProgressViewStyle
    
    override var bounds: CGRect {
        didSet {
            if let superview = self.superview {
                layer.cornerRadius = superview.layer.cornerRadius
            }
        }
    }
    
    //MARK: - Section Name
    init(progressViewStyle: ProgressViewStyle) {
        self.progressViewStyle = progressViewStyle
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        self.progressViewStyle = .plainCircle(nil, .blue)
        super.init(frame: .zero)
        configureUI()
    }
    
    //MARK: - Section Name
    private func configureUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black.withAlphaComponent(0.4)
        
        switch progressViewStyle {
        case .fourCircles(let title, let backgroundColor, let dotColors):
            configureFourDotsUI(title: title, backgroundColor: backgroundColor, dotColorsArray: dotColors)
        case .threeCircles(let title,let backgroundColor, let dotColors):
            configureThreeDotsUI(title: title, backgroundColor: backgroundColor, dotColorsArray: dotColors)
        case .gradientCircle(let title, let gradientColorsArray):
            configureGradientCircleUI(title: title, gradientColors: gradientColorsArray)
        case .plainCircle(let title, let barColor):
            configurePlainCircleUI(title: title, circleColor: barColor)
        }
    }
    
    private func configureFourDotsUI(title: String?, backgroundColor: UIColor, dotColorsArray: [UIColor]) {
        let fourDotsView = FourDotsCircularView(title: title, backgroundColor: backgroundColor, dotColorsArray: dotColorsArray)
        addSubview(fourDotsView)
        fourDotsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fourDotsView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func configureThreeDotsUI(title: String?, backgroundColor: UIColor, dotColorsArray: [UIColor]) {
        let threeDotsView = ThreeDotsCircularView(title: title, backgroundColor: backgroundColor, dotColorsArray: dotColorsArray)
        addSubview(threeDotsView)
        threeDotsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        threeDotsView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        NSLayoutConstraint.activate([
//            threeDotsView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            threeDotsView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            threeDotsView.topAnchor.constraint(equalTo: topAnchor),
//            threeDotsView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
    }
    
    private func configureGradientCircleUI(title: String?, gradientColors: [UIColor]) {
        let plainCircleView = StrokeBarCircularView(title: title, barColor: .black, gradientColors: gradientColors)
        addSubview(plainCircleView)
//        plainCircleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        plainCircleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        NSLayoutConstraint.activate([
            plainCircleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            plainCircleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            plainCircleView.topAnchor.constraint(equalTo: topAnchor),
            plainCircleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configurePlainCircleUI(title: String?, circleColor: UIColor) {
        let plainCircleView = StrokeBarCircularView(title: title, barColor: circleColor, gradientColors: nil)
        addSubview(plainCircleView)
//        plainCircleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        plainCircleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        NSLayoutConstraint.activate([
            plainCircleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            plainCircleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            plainCircleView.topAnchor.constraint(equalTo: topAnchor),
            plainCircleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

class CircularView: UIView {
    //MARK: - Section Name
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = bounds.height / 2
        }
    }
}

extension Array {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}
