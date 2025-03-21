//
//  SplashView.swift
//  iOS Chanllenge
//
//  Created by ahmed maher on 07/01/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
           ZStack {
               if isActive {
                   MainView(viewModel: DependencyManager.shared.resolveMainViewModel())
               } else {
                   SplashContentView()
                       .transition(.opacity)
                       .onAppear {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                               withAnimation {
                                   isActive = true
                               }
                           }
                       }
               }
           }
       }
}

// MARK: - Splash Content
struct SplashContentView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
    }
}
#Preview {
    SplashView()
}
