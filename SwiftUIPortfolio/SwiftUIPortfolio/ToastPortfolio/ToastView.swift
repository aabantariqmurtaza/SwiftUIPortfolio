//
//  ToastView.swift
//  SwiftUI Portfolio
//
//  Created by Aaban Tariq Murtaza on 11/07/2023.
//

import Foundation
import SwiftUI

enum ToastType {
    case success, error, info
}

struct ToastView: View {
    @Binding var show: Bool
    let text: String
    let type: ToastType
    
    var image: Image {
        return self.getConfigs(forType: type).1
    }
    
    var backgroundColor: Color {
        return self.getConfigs(forType: type).0
    }
    
    func getConfigs(forType: ToastType) -> (Color, Image) {
        switch type {
        case .success:
            return (Color.green, Image("tickAlert"))
        case .error:
            return (Color.red, Image("alert"))
        case .info:
            return (Color.gray, Image("alert")) /// In future if there's any design
        }
    }
    
    var body: some View {
        VStack {
            HStack() {
                image
                Text(text)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, minHeight: 51)
        .background(backgroundColor)
        .cornerRadius(4)
        .transition(.slide)
        .padding(16)
    }
}

struct Overlay<T: View>: ViewModifier {
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if show {
                overlayView
            }
        }
        .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: show)
    }
}

extension View {
    func overlay<T: View>(overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay.init(show: show, overlayView: overlayView))
    }
}
