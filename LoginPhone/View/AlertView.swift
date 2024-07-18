//
//  AlertView.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 17/7/24.
//

import SwiftUI

struct AlertView: View {
    var msg: String
    @Binding var show: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            
            Text(msg)
                .foregroundColor(.gray)
            
            Button(action: {
                show.toggle()
            }, label: {
                Text("Close")
                    .foregroundStyle(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(.yellow)
                    .cornerRadius(15)
            })
            .frame(alignment: .center)
        }
        .padding()
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.black.opacity(0.3))
    }
}

#Preview {
    AlertView(msg: "Error", show: .constant(true))
}
