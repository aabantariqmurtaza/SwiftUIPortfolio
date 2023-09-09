//
//  BottomSheet.swift
//  myBusiness
//
//  Created by Nauman Saleem on 07/08/2023.
//

import Foundation
import SwiftUI

struct BottomSheetViewModifier: ViewModifier {
    @Binding var isSheetPresented: Bool
    var sheetContent: any View
    var maxHeight: CGFloat? = 202
    var topDraggingViewColor: SwiftUI.Color = .gray
    func body(content: Content) -> some View {
        ZStack {
            content
            BottomSheet(content: { sheetContent.eraseToAnyView() },
                        isShowing: $isSheetPresented,
                        maxHeight: maxHeight,
                        topDraggingViewColor: topDraggingViewColor)
        }
    }
}

extension View {
    func showCustomSheet(isSheetPresented: Binding<Bool>, sheetContent: any View, height: CGFloat = 202, topDraggingViewColor: SwiftUI.Color = .gray) -> some View {
        modifier(BottomSheetViewModifier(isSheetPresented: isSheetPresented, sheetContent: sheetContent, maxHeight: height, topDraggingViewColor: topDraggingViewColor))
    }
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}


struct BottomSheet<Content: View>: View {
    @Binding var isShowing: Bool
    let content: Content
    
    var maxHeight: CGFloat? = 202
    var topLeftCornerRadius: CGFloat = 16
    var topRightCornerRadius: CGFloat = 16
    var backgroundTransparentColor: SwiftUI.Color = Color(red: 0.11, green: 0.15, blue: 0.18)
    var topDraggingViewColor: SwiftUI.Color = .gray
    
    init(@ViewBuilder content: () -> Content,
         isShowing: Binding<Bool>,
         maxHeight: CGFloat? = 202,
         topLeftCornerRadius: CGFloat = 16,
         topRightCornerRadius: CGFloat = 16,
         topDraggingViewColor: SwiftUI.Color = .gray) {
        self.content = content()
        _isShowing = isShowing
        self.maxHeight = maxHeight
        self.topLeftCornerRadius = topLeftCornerRadius
        self.topRightCornerRadius = topRightCornerRadius
        self.topDraggingViewColor = topDraggingViewColor
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                backgroundTransparentColor
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 8)
                    HStack {
                        Spacer()
                        Rectangle()
                            .foregroundColor(topDraggingViewColor)
                            .frame(width: 46, height: 5)
                            .cornerRadius(2, corners: .allCorners)
                        Spacer()
                    }
                    content
                }
                .background(Color(red: 0.11, green: 0.15, blue: 0.18).opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: maxHeight)
                .cornerRadius(topLeftCornerRadius, corners: .topLeft)
                .cornerRadius(topRightCornerRadius, corners: .topRight)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

