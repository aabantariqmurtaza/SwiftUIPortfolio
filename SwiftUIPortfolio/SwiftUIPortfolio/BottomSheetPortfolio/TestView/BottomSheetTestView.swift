//
//  BottomSheetTestView.swift
//  SwiftUIPortfolio
//
//  Created by Aaban Tariq Murtaza on 09/09/2023.
//

import SwiftUI

struct BottomSheetTestView: View {
    @State var showSheet = false
    var body: some View {
        Button("Show Bottom Sheet") {
            showSheet = true
        }
        .showCustomSheet(isSheetPresented: $showSheet,
                         sheetContent: getSheetContent(),
                         height: 300,
                         topDraggingViewColor: .black)
    }
    
    @ViewBuilder
    func getSheetContent() -> some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 32)
            HStack {
                Text("Sheet Contents \nSheet Contents\nSheet Contents\nSheet Contents\nSheet Contents\nSheet Contents\nSheet Contents\nSheet Contents\nSheet Contents")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .padding(.horizontal, 32)
                    .padding(.trailing, 32)
            }
            Spacer()
        }
    }
}

struct BottomSheetTestView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTestView()
    }
}
