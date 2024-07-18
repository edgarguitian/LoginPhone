//
//  Home.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 18/7/24.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_Status") var status = false

    var body: some View {
        // Home View
        Text("Logged In Successfully")
            .font(.title)
            .fontWeight(.heavy)
            .foregroundStyle(.black)
        
        Button(action: {
            do {
                try Auth.auth().signOut()
                withAnimation {
                    status = false
                }
            } catch {
                
            }
        }, label: {
            Text("LogOut")
                .fontWeight(.heavy)
        })
    }
}

#Preview {
    Home()
}
