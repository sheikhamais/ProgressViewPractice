//
//  ExtensionUIView.swift
//  ProgressView
//
//  Created by Amais Sheikh	 on 02/08/2022.
//

import Foundation
import UIKit

extension UIView {
    func showProgressView(style: ASHProgressView.ProgressViewStyle = .fourCircles(nil, .black.withAlphaComponent(0.4), [.white])) {
        
        //disable interaction
        isUserInteractionEnabled = false
        
        //logic to show view
        if let existingViewInfo = ASHProgressViewCounter.views[self],
           existingViewInfo.0 > 0 {
            //already progress view is displayed, increase counter
                ASHProgressViewCounter.views[self] = (existingViewInfo.0 + 1, existingViewInfo.1)
        } else {
            //show progress view
            let progressView = ASHProgressView(progressViewStyle: style)
            self.addSubview(progressView)
            NSLayoutConstraint.activate([
                progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
                progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
                progressView.topAnchor.constraint(equalTo: topAnchor),
                progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            print("added progress view")
            //set value in dictionary
            ASHProgressViewCounter.views[self] = (1, progressView)
        }
    }
    
    func hideProgressView() {
        if let existingViewInfo = ASHProgressViewCounter.views[self],
           existingViewInfo.0 > 0 {
            
            if existingViewInfo.0 == 1 {
                existingViewInfo.1.removeFromSuperview()
                isUserInteractionEnabled = true
                print("removed progress view")
            }
            
            ASHProgressViewCounter.views[self] = (existingViewInfo.0 - 1, existingViewInfo.1)
        }
    }
}

class ASHProgressViewCounter {
    static var views = [UIView: (Int, UIView)]() //[parent reference view: (times show view called, progress view reference)]
}

extension UIView {
    func makeRepeatingRotations(duration: TimeInterval = 1, delay: TimeInterval = 0, animatingOptions: UIView.AnimationOptions = [.repeat, .curveEaseInOut]) {
        var transformAngle: CGFloat = .pi
        UIView.animate(withDuration: duration, delay: delay, options: animatingOptions) {
            self.transform = CGAffineTransform(rotationAngle: transformAngle)
            transformAngle = transformAngle == .pi ? 0 : .pi
        }
    }
}
