//
//  ShowToastKey.swift
//  SwiftUI Portfolio
//
//  Created by Aaban Tariq Murtaza on 09/08/2023.
//

import Foundation
import SwiftUI

struct ToastData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        if (lhs.showToast != rhs.showToast) || (lhs.text != rhs.text) || (lhs.type != rhs.type) || (lhs.isDisplayed != rhs.isDisplayed) {
            return false
        }
        return true
    }
    var showToast: Bool
    var text: String
    var isDisplayed = false
    var type: ToastType
}

struct ShowToastKey: EnvironmentKey {
    static var defaultValue: Binding<ToastData> = .constant(ToastData(showToast: false, text: "", isDisplayed: false, type: .success))
}

extension EnvironmentValues {
    var showToastKey: Binding<ToastData> {
        get { self[ShowToastKey.self] }
        set { self[ShowToastKey.self] = newValue }
    }
}
