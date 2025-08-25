//
//  RanklitTextField.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import SwiftUI

struct RanklitTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeHolder, text: $text)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal,25)
            .padding(.top, 15)
            .font(.body.italic())
            .padding(.bottom, 6)
            .overlay(alignment: .bottom) {
                Rectangle()
                //.fill(Color.secondary.opacity(0.3))
                    .frame(height: 0.8)
                    .padding(.horizontal,20)
            }
    }
}

#Preview {
    RanklitTextField(placeHolder: "email", text: .constant(""))
}
