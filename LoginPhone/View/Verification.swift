//
//  Verification.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 17/7/24.
//

import SwiftUI

struct Verification: View {
    @ObservedObject var loginData: LoginViewModel
    @Environment(\.presentationMode) var present
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button(action: {
                            present.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundStyle(.black)
                        })
                        
                        Spacer()
                        
                        Text("Verify Phone")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        if loginData.loading {
                            ProgressView()
                        }
                    }
                    .padding()
                    
                    Text("Code sent to \(loginData.phoneNumber)")
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 15) {
                        ForEach(0..<6, id: \.self) { index in
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6) {
                        Text("Didn't receive code?")
                            .foregroundStyle(.gray)
                        
                        Button(action: {
                            loginData.requestCode()
                        }, label: {
                            Text("Request Again")
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        })
                    }
                    .padding()
                    
                    Button(action: {
                        loginData.verifyCode()
                    }, label: {
                        Text("Verify and Create Account")
                            .foregroundStyle(.black)
                            .padding(.vertical)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(.yellow)
                            .cornerRadius(15)
                    })
                    .padding()
                }
                .padding(.top, 60)
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(.white)
                .cornerRadius(20)
                
                CustomNumberPad(value: $loginData.code,
                                isVerify: true)
                
                
            }
            
            if loginData.error {
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(.gray.opacity(0.3))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func getCodeAtIndex(index: Int) -> String {
        if loginData.code.count > index {
            let start = loginData.code.startIndex
            let current = loginData.code.index(start, offsetBy: index)
            
            return String(loginData.code[current])
        }
        
        return ""
    }
}

#Preview {
    Verification(loginData: LoginViewModel())
}

struct CodeView: View {
    var code: String
    var body: some View {
        VStack(spacing: 10) {
            Text(code)
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .font(.title)
                .frame(height: 45)
            
            Capsule()
                .fill(.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
