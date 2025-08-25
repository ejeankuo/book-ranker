//
//  NameView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import SwiftUI

struct NameView: View {
    @Environment(\.authViewModel) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("what's your name?")
                .font(.title)
                .bold()
            RanklitTextField(placeHolder: "display name", text: $viewModel.registerDisplayName)
            
            NavigationLink {
                UsernameView()
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
            .disabled(viewModel.registerDisplayName.isEmpty)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.light)
    }
}

#Preview {
    NameView()
}
