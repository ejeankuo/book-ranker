//
//  EmailView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import SwiftUI

struct EmailView: View {
    @Environment(\.authViewModel) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("Enter an email:")
                .font(.title)
                .bold()
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            RanklitTextField(placeHolder: "Email address", text: $viewModel.registerEmail)
            
            NavigationLink {
                NameView()
                    .environment(viewModel)
            } label: {
                Text("Next")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color(.kPrimary))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
            }
            .disabled(viewModel.registerEmail.isEmpty)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.light)
    }
}

#Preview {
    NavigationStack {
        EmailView()
    }
}
