//
//  ContentView.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 17/7/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false

    var body: some View {
        ZStack {
            if status {
                VStack(spacing: 15) {
                    Home()
                }
            } else {
                NavigationView {
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
