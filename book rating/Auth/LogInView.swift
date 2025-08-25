//
//  LogInView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import SwiftUI

struct LogInView: View {
    @Environment(\.authViewModel) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("welcome back!")
                .font(.title)
                .bold()
                .padding(.top, 55)
            
            Text("we're so excited to see you again.")
                .foregroundStyle(.gray)
                .padding(.bottom, 15)
            
            VStack(alignment: .leading) {
                RanklitTextField(placeHolder: "email address", text: $viewModel.logInEmail)
                
                SecureField("password", text: $viewModel.logInPassword)
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
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                viewModel.logIn()
            } label: {
                Text("log in")
                    .padding()
                    .frame(maxWidth: 300)
                    .foregroundStyle(.white)
                    .background(Color(.kPrimary))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.top, 50)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.light)
        
    }
}
#Preview {
    LogInView()
}
