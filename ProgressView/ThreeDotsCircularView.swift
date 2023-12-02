//
//  ThreeDotsCircularView.swift
//  ProgressView
//
//  Created by Amais Sheikh	 on 05/08/2022.
//

import Foundation
import UIKit
import SwiftUI

class ThreeDotsCircularView: UIView {
    
    //MARK: - Section Name
    private var title: String?
    private var circularViewBackgroundColor: UIColor
    private var dotColorsArray: [UIColor]
    
    private lazy var threeDotsViewHostingController: UIHostingController = UIHostingController(rootView: ThreeDotsCircle(title: title,
                                                                                                                         circleBackgroundColor: Color(circularViewBackgroundColor),
                                                                                                                         circleDotColors: dotColorsArray.compactMap{ Color($0) }))
    
    //MARK: - Section Name
    init(title: String? = nil,
         backgroundColor: UIColor = .white,
         dotColorsArray: [UIColor] = [.white]) {
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
        
        //properties
        translatesAutoresizingMaskIntoConstraints = false
        
        //subviews
        addSubview(threeDotsViewHostingController.view)
        
        //constraints
        NSLayoutConstraint.activate([
            
            threeDotsViewHostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            threeDotsViewHostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            threeDotsViewHostingController.view.topAnchor.constraint(equalTo: topAnchor),
            threeDotsViewHostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - SwiftUI View
struct ThreeDotsCircle: View {
    
    //MARK: - Section Name
    @State private var startRotation: Bool = false
    private var title: String?
    private var circleBackgroundColor: Color
    private var nonEmptyCircleDotsColors: [Color]
    
    private var circularContainerDiameter: CGFloat = 64
    private var placementCircleDiameter: CGFloat = 32
    private var dotCircleDiameter: CGFloat = 24
    
    //MARK: - Init
    init(title: String? = nil,
         circleBackgroundColor: Color = .black.opacity(0.4),
         circleDotColors: [Color] = [.white]) {
        
        self.title = title
        self.circleBackgroundColor = circleBackgroundColor
        self.nonEmptyCircleDotsColors = circleDotColors.isNotEmpty ? circleDotColors : [.white]
    }
    
    //MARK: - Section Name
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: circularContainerDiameter, height: circularContainerDiameter)
                    .foregroundColor(circleBackgroundColor)
                
                ZStack {
                    Circle()
                        .frame(width: placementCircleDiameter, height: placementCircleDiameter)
                        .foregroundColor(Color.clear)
                    
                    ForEach(0...2, id: \.self) { index in
                        
                        let colorIndex = nonEmptyCircleDotsColors[index % nonEmptyCircleDotsColors.endIndex]
                        let pointOnBoundaryForDegree = getPosition(forAngle: CGFloat(index) * 120,
                                                                   radius: placementCircleDiameter/2)
                        
                        Circle()
                            .frame(width: dotCircleDiameter, height: dotCircleDiameter)
                            .offset(x: pointOnBoundaryForDegree.x, y: pointOnBoundaryForDegree.y)
                            .foregroundColor(colorIndex)
                    }
                }
                .rotationEffect(Angle(degrees: startRotation ? 360 : 0))
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false), value: startRotation)
                .onAppear {
                    startRotation.toggle()
                }
            }
            
            if let title = title {
                Text(title)
                    .font(.system(size: 14))
            }
        }
    }
    
    func getPosition(forAngle: CGFloat, radius: CGFloat) -> CGPoint {
        let radians = forAngle * .pi / 180
        let xPos = cos(radians) * radius
        let yPos = sin(radians) * radius * -1
        return CGPoint(x: xPos, y: yPos)
    }
}

struct ThreeDotsCircle_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotsCircle(title: "Loading", circleBackgroundColor: .black, circleDotColors: [.red, .yellow, .green])
    }
}
