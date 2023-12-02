//
//  StrokeBarCircularView.swift
//  ProgressView
//
//  Created by Amais Sheikh	 on 08/08/2022.
//

import Foundation
import UIKit
import SwiftUI

//MARK: - UIKit View
class StrokeBarCircularView: UIView {
    
    //MARK: - Section Name
    private var title: String?
    private var barColor: UIColor
    private var gradientColors: [UIColor]?
    private var lineWidth: CGFloat
    private var circleRadius: CGFloat
    
    private lazy var barView = CircularBarLoaderView(title: title,
                                                     barColor: Color(barColor),
                                                     gradientColors: gradientColors,
                                                     lineWidth: lineWidth,
                                                     circleRadius: circleRadius)
    
    private lazy var strokeBarViewHostingController: UIHostingController = UIHostingController(rootView: barView)
    
    //MARK: - Section Name
    init(title: String? = nil,
         barColor: UIColor = .blue,
         gradientColors: [UIColor]? = nil,
         lineWidth: CGFloat = 8,
         circleRadius: CGFloat = 28) {
        
        self.title = title
        self.barColor = barColor
        self.gradientColors = gradientColors
        self.lineWidth = lineWidth
        self.circleRadius = circleRadius
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Section Name
    private func configureUI() {
        
        //properties
        translatesAutoresizingMaskIntoConstraints = false
        strokeBarViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        //subviews
        addSubview(strokeBarViewHostingController.view)
        
        //constraints
        NSLayoutConstraint.activate([
            
            strokeBarViewHostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            strokeBarViewHostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            strokeBarViewHostingController.view.topAnchor.constraint(equalTo: topAnchor),
            strokeBarViewHostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - SwiftUI View
struct CircularBarLoaderView: View {
    
    //MARK: - Section Name
    private var animationDuration: CGFloat = 1
    private var title: String?
    private var barColor: Color
    private var gradientColors: [Color]?
    private var lineWidth: CGFloat
    private var circleRadius: CGFloat
    
    @State private var circularPathStartPointTrimmedValue: CGFloat = 0
    @State private var circularPathEndPointTrimmedValue: CGFloat = 0
    @State private var triggerAnimation = false
    
    //MARK: - Init
    init(title: String? = nil,
         barColor: Color = .black,
         gradientColors: [UIColor]? = nil,
         lineWidth: CGFloat = 8,
         circleRadius: CGFloat = 28) {
        
        self.title = title
        self.barColor = barColor
        self.gradientColors = gradientColors?.compactMap { color in
            return Color(color)
        }
        
        self.lineWidth = lineWidth
        self.circleRadius = circleRadius
    }
    
    //MARK: - Section Name
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ZStack {
                    let path = Path { path in
                        path.addArc(center: CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2),
                                    radius: circleRadius,
                                    startAngle: .degrees(-90),
                                    endAngle: .degrees(270),
                                    clockwise: false)
                    }
                        .trim(from: circularPathStartPointTrimmedValue, to: circularPathEndPointTrimmedValue)
                        .stroke(style: .init(lineWidth: lineWidth, lineCap: .round))
                    
                    if let colors = gradientColors {
                        path
                            .fill(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                            .animation(.easeInOut(duration: animationDuration), value: triggerAnimation)
                            .onAppear {
                                configureAnimation()
                            }
                    } else {
                        path
                            .fill(barColor)
                            .animation(.easeInOut(duration: animationDuration), value: triggerAnimation)
                            .onAppear {
                                configureAnimation()
                            }
                    }
                    
                    if let title = title {
                        Text(title)
                            .font(.system(size: 14))
                            .offset(x: 0, y: circleRadius + lineWidth + 12)
                    }
                }
            }
        }
    }
    
    private func configureAnimation() {
        
        //calculate weather both ends were completed
        let delay = (circularPathEndPointTrimmedValue + circularPathStartPointTrimmedValue) == 2 ? 0 : animationDuration
        
        //decide on basis to complete the stroke position
        if circularPathEndPointTrimmedValue != 1 {
            triggerAnimation.toggle()
            circularPathEndPointTrimmedValue = 1
        } else if circularPathStartPointTrimmedValue != 1 {
            triggerAnimation.toggle()
            circularPathStartPointTrimmedValue = 1
        } else {
            circularPathEndPointTrimmedValue = 0
            circularPathStartPointTrimmedValue = 0
        }
        
        //perform the next call
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.configureAnimation()
        }
    }
}

struct CircularBarLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        CircularBarLoaderView(title: "Loading", barColor: .blue, gradientColors: [.red, .blue])
    }
}
