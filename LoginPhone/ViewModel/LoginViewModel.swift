//
//  LoginViewModel.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 17/7/24.
//

import Foundation
import FirebaseAuth
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var code = ""
    
    // Data Model For Error View
    @Published var errorMsg = ""
    @Published var error = false

    // storing CODE for verification
    @Published var CODE = ""
    
    @Published var goToVerify = false

    // User Logged Status
    @AppStorage("log_Status") var status = false

    // Loading View
    @Published var loading = false

    func getCountryCode() -> String {
        let regionCode = Locale.current.region?.identifier ?? ""
        
        return countries[regionCode] ?? ""
    }

    func sendCode() {
        let number = "+\(getCountryCode())\(phoneNumber))"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            if let code = CODE {
                self.CODE = code
                self.goToVerify = true
            } else {
                self.errorMsg = "Not Code Received"
                withAnimation {
                    self.error.toggle()
                }
                return
            }
        }
    }
    
    func verifyCode() {
        loading = true
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (result, err) in
            self.loading = false
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            withAnimation {
                self.status = true
            }
            
        }
    }
    
    func requestCode() {
        sendCode()
        withAnimation {
            self.errorMsg = "Code Sent Successfully !!!"
            self.error.toggle()
        }
    }
}
