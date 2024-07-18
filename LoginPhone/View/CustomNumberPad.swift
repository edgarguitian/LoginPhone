//
//  CustomNumberPad.swift
//  LoginPhone
//
//  Created by Edgar Guitian Rey on 17/7/24.
//

import SwiftUI

struct CustomNumberPad: View {
    @Binding var value: String
    var isVerify: Bool
    var rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "delete.left"]

    var body: some View {
        GeometryReader { reader in
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 15) {
                    ForEach(rows, id: \.self) { value in
                        Button(action: {
                            buttonAction(value: value)
                        }, label: {
                            ZStack {
                                if value == "delete.left" {
                                    Image(systemName: value)
                                        .font(.title)
                                        .foregroundStyle(.black)
                                } else {
                                    Text(value)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .frame(width: getWidth(frame: reader.frame(in: .global)), height: getHeight(frame: reader.frame(in: .global)))
                            .background(.white)
                            .cornerRadius(10)
                        })
                        .disabled(value == "" ? true : false)
                    }
                }
            }
        }
        .padding()
    }
    
    func getWidth(frame: CGRect) -> CGFloat {
        let width = frame.width
        
        let actualWidth = width - 40
        
        return actualWidth / 3
    }
    
    func getHeight(frame: CGRect) -> CGFloat {
        let height = frame.height
        
        let actualHeight = height - 30
        
        return actualHeight / 4
    }
    
    func buttonAction(value: String) {
        if value == "delete.left" && self.value != "" {
            self.value.removeLast()
        }
        
        if value != "delete.left" {
            if isVerify {
                if self.value.count < 6 {
                    self.value.append(value)
                }
            } else {
                self.value.append(value)
            }
        }
    }
}

#Preview {
    CustomNumberPad(value: .constant("111"), isVerify: false)
}
