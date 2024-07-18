//
//  Login.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 17/7/24.
//

import SwiftUI

struct Login: View {
    @StateObject var loginData = LoginViewModel()
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Continue With Phone")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding(.top, 60)
                        .padding()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("You'll receive a 4 digit code\n to verify next.")
                        .font(.title2)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    // Mobile Number Field
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Enter Your Number")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Text("+ \(loginData.getCountryCode())  \(loginData.phoneNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(destination: Verification(loginData: loginData), isActive: $loginData.goToVerify) {
                            Text("")
                                .hidden()
                        }
                        
                        Button(action: {
                            loginData.sendCode()
                        }, label: {
                            Text("Continue")
                                .foregroundStyle(.black)
                                .padding(.vertical, 18)
                                .padding(.horizontal, 38)
                                .background(.yellow)
                                .cornerRadius(20)
                        })
                        .disabled(loginData.phoneNumber.isEmpty)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(.white)
                .cornerRadius(20)
                
                CustomNumberPad(value: $loginData.phoneNumber,
                                isVerify: false)
                
            }
            .ignoresSafeArea(.all, edges: .top)
            .background(.gray.opacity(0.3))
            
            if loginData.error {
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
        
    }
    
}

#Preview {
    Login()
}

