//
//  ContentView.swift
//  SwiftUIPortfolio
//
//  Created by Aaban Tariq Murtaza on 09/09/2023.
//

import SwiftUI

struct GenericStrokeCard: View {
    
    var title: String = "Title"
    var subtitlePreFix: String = "Sub Title PreFix"
    var subtitlePostFix: String = "Sub Title PostFix"
    var titleFont = Font.system(size: 18, weight: .bold)
    var subtitlePreFixFont = Font.system(size: 18, weight: .regular)
    var subtitlePostFixFont = Font.system(size: 12, weight: .light)
    var backgroundColor: UIColor
    var cardHeight: CGFloat = 213
    var barTopColor: Color = Color.gray
    var barBottomColor: Color = Color.white
    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.15, blue: 0.18)
            CardLayout(bgGradient: [Gradient.Stop(color: Color(uiColor: backgroundColor).opacity(0), location: 0.0),
                                    Gradient.Stop(color: Color(uiColor: backgroundColor).opacity(0.27), location: 1.0)])
            .overlay {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(alignment: .top) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 31, height: 74)
                                .background(
                                    LinearGradient(
                                        stops: [Gradient.Stop(color: .white.opacity(0), location: 0.0),
                                                Gradient.Stop(color: .white.opacity(0.3), location: 1.0)],
                                        startPoint: UnitPoint(x: 1.42, y: 2.62),
                                        endPoint: UnitPoint(x: -0.47, y: -1.07)
                                    )
                                )
                            Rectangle()
                                .frame(width: 31, height: 31)
                                .foregroundColor(barBottomColor)
                        }
                        .padding(.leading, 50.0)
                        Spacer()
                        Image("stc_cxp_logo")
                            .padding(.top, 30)
                            .padding(.trailing, 10.0)
                    }
                    .padding(.trailing)
                    Spacer()
                    Text(title)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(titleFont)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 20))
                    HStack(alignment: .bottom){
                        Text(subtitlePreFix)
                            .font(subtitlePreFixFont)
                        Text(subtitlePostFix)
                            .font(subtitlePostFixFont)
                            .padding(.bottom, 2)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 50, bottom: 40, trailing: 20))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .frame(height: cardHeight)
            }
            .frame(height: cardHeight)
        }
    }
}

struct CardLayout: View {
    
    let bgGradient: [Gradient.Stop]
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack (alignment: .topLeading) {
                Rectangle()
                    .fill(Color.clear)
                    .addStroke()
                    .frame(height: 213)
                    .background(
                        LinearGradient(
                            stops: bgGradient,
                            startPoint: UnitPoint(x: 0, y: 1),
                            endPoint: UnitPoint(x: 1, y: 0)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GenericStrokeCard(backgroundColor: UIColor(red: 0, green: 0.77, blue: 0.55, alpha: 1))
    }
}
