//
//  StrokeViewModifier.swift
//  StrokeModifier
//
//  Created by Aaban Tariq Murtaza on 23/08/2023.
//

import Foundation
import SwiftUI

struct StrokeViewModifier: ViewModifier {
    
    static let cardBorderStrokeLeftLine: [Gradient.Stop] = [Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)) , location: 0.00),
                                                            Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 150/255, green: 130/255, blue: 110/255, alpha: 1)), location: 1.00)]//Theme.getGradientStops(withKey: "cardBorderStrokeLeftLine")
    static let cardBorderStrokeBottomLine: [Gradient.Stop] = [Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 150/255, green: 130/255, blue: 110/255, alpha: 1)), location: 0.00),
                                                              Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)), location: 1.00)]//Theme.getGradientStops(withKey: "cardBorderStrokeBottomLine")
    static let cardBorderStrokeRightLine: [Gradient.Stop] = [Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)), location: 0.00),
                                                             Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 150/255, green: 130/255, blue: 110/255, alpha: 1)), location: 1.00)]//Theme.getGradientStops(withKey: "cardBorderStrokeRightLine")
    
    static let cardBorderStrokeTopLine: [Gradient.Stop] = [Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 150/255, green: 130/255, blue: 110/255, alpha: 1)), location: 0.00),
                                                             Gradient.Stop(color: SwiftUI.Color(uiColor: UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)), location: 1.00)]//Theme.getGradientStops(withKey: "cardBorderStrokeRightLine")
    
    let lineStrokes: [[Gradient.Stop]] = [cardBorderStrokeLeftLine,
                                          cardBorderStrokeBottomLine,
                                          cardBorderStrokeRightLine,
                                          cardBorderStrokeTopLine]
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            GeometryReader{ geometry in
                content
                if lineStrokes.count >= 2 {
                    LeftBorderPath(geometry: geometry, borderGradient: lineStrokes[0], roundCorners: 16, pathWidth: 3)
                    BottomBorderPath(geometry: geometry, borderGradient: lineStrokes[1], roundCorners: 16, pathWidth: 3)
                    RightBorderPath(geometry: geometry, borderGradient: lineStrokes[2], roundCorners: 16, pathWidth: 3)
                    TopBorderPath(geometry: geometry, borderGradient: lineStrokes[3], roundCorners: 16, pathWidth: 3)
                }
            }
        }
    }
}

extension View {
    func addStroke() -> some View {
        modifier(StrokeViewModifier())
    }
}

extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
}

fileprivate struct TopBorderPath: View {
    var geometry: GeometryProxy
    var borderGradient: [Gradient.Stop]
    var roundCorners: CGFloat
    var pathWidth: CGFloat
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: geometry.size.width, y: roundCorners))
            path.addCurve(to: CGPoint(x: geometry.size.width - roundCorners, y: 0),
                          control1: CGPoint(x: geometry.size.width - 1, y: 15),
                          control2: CGPoint(x: geometry.size.width - 1, y: 1))
            path.addLine(to: CGPoint(x: roundCorners, y: 0))
            path.addCurve(to: CGPoint(x: 0, y: roundCorners),
                          control1: CGPoint(x: 3, y: 1),
                          control2: CGPoint(x: 1, y: 15))
        }
        .stroke(LinearGradient(stops: borderGradient,
                               startPoint: .trailing,
                               endPoint: .leading),
                lineWidth: pathWidth)
    }
}

fileprivate struct RightBorderPath: View {
    var geometry: GeometryProxy
    var borderGradient: [Gradient.Stop]
    var roundCorners: CGFloat
    var pathWidth: CGFloat
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: geometry.size.width-roundCorners, y: geometry.size.height))
            path.addCurve(to: CGPoint(x: geometry.size.width, y: geometry.size.height-roundCorners), control1: CGPoint(x: geometry.size.width, y: geometry.size.height), control2: CGPoint(x: geometry.size.width-1, y: geometry.size.height-(14)))
            path.addLine(to: CGPoint(x: geometry.size.width, y: roundCorners))
        }
        .stroke(LinearGradient(stops: borderGradient,
                               startPoint: .bottom,
                               endPoint: .top),
                lineWidth: pathWidth)
    }
}

fileprivate struct LeftBorderPath: View {
    var geometry: GeometryProxy
    var borderGradient: [Gradient.Stop]
    var roundCorners: CGFloat
    var pathWidth: CGFloat
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: roundCorners))
            path.addLine(to: CGPoint(x: 0, y: geometry.size.height-roundCorners))
        }
        .stroke(LinearGradient(stops: borderGradient,
                               startPoint: .topLeading,
                               endPoint: .bottomLeading),
                lineWidth: pathWidth)
    }
}

fileprivate struct BottomBorderPath: View {
    var geometry: GeometryProxy
    var borderGradient: [Gradient.Stop]
    var roundCorners: CGFloat
    var pathWidth: CGFloat
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: geometry.size.height-roundCorners))
            path.addCurve(to: CGPoint(x: roundCorners, y: geometry.size.height), control1: CGPoint(x: 1, y: geometry.size.height), control2: CGPoint(x: roundCorners, y: geometry.size.height))
            path.addLine(to: CGPoint(x: geometry.size.width-roundCorners, y: geometry.size.height))
        }
        .stroke(LinearGradient(stops: borderGradient,
                               startPoint: .leading,
                               endPoint: .trailing),
                lineWidth: pathWidth)
    }
}
