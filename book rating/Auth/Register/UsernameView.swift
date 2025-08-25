//
//  UsernameView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import SwiftUI

struct UsernameView: View {
    @Environment(\.authViewModel) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("next, create an account")
                .font(.title)
                .bold()
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            RanklitTextField(placeHolder: "username", text: $viewModel.registerUsername)
            
            SecureField("password", text: $viewModel.registerPassword)
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
            
            NavigationLink {
                AgeView()
                    .environment(viewModel)
            } label: {
                Text("next")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color(.kPrimary))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
            }
            .disabled(viewModel.registerPassword.isEmpty || viewModel.registerUsername.isEmpty)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.light)
    }
}

#Preview {
    UsernameView()
}
