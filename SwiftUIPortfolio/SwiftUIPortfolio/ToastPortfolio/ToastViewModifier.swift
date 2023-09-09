//
//  ToastView.swift
//  SwiftUI Portfolio
//
//  Created by Aaban Tariq Murtaza on 10/08/2023.
//

import Foundation
import SwiftUI

struct ToastViewModifier: ViewModifier {
    @State var showToastData = ToastData(showToast: false, text: "", type: .success)
    @State var showToastOverlay = false
    @State var task: Task<Void, Never>? = nil
    func body(content: Content) -> some View {
        withAnimation {
            content
                .onChange(of: showToastData, perform: { newValue in
                    showToastData.isDisplayed = true
                    showToastOverlay = true
                    startToastHidingTask()
                })
                .environment(\.showToastKey, $showToastData)
                .overlay(overlayView: ToastView(show: $showToastData.showToast,
                                                text: showToastData.text,
                                                type: showToastData.type),
                         show: $showToastOverlay)
        }
    }
    
    private func toastHidingTask() -> Task<Void, Never> {
        Task {
            do {
                try await Task.sleep(nanoseconds: 30_000_000_00)
                DispatchQueue.main.async {
                    showToastOverlay = false
                }
            } catch is CancellationError {
                print("Task was cancelled")
            } catch {
            }
        }
    }
    
    private func startToastHidingTask(){
        if let task {
            task.cancel()
            self.task = toastHidingTask()
        } else {
            self.task = toastHidingTask()
        }
    }
}


extension View {
    func addToast() -> some View {
        modifier(ToastViewModifier())
    }
}
