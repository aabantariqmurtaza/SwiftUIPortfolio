//
//  ToastTestView.swift
//  SwiftUIPortfolio
//
//  Created by Aaban Tariq Murtaza on 09/09/2023.
//

import SwiftUI


struct ToastTestView: View {
    @Environment(\.showToastKey) var showToastData
    @State var showToast: Bool = false
    @State var toastType: ToastType = .success
    var body: some View {
        VStack {
            Spacer()
            Button("Press", action: {
                if toastType == .error {
                    toastType = .success
                } else {
                    toastType = .error
                }
                showToast = true
            })
            .onChange(of: showToast, perform: { newValue in
                let toastData = ToastData(showToast: true,
                                          text: "Toast Message",
                                          type: toastType)
                showToastData.wrappedValue = toastData
                showToast = false
            })
        }
    }
}

struct ToastTestView_Previews: PreviewProvider {
    static var previews: some View {
        ToastTestView()
            .addToast()
    }
}
