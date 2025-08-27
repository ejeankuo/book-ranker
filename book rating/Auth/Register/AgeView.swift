//
//  AgeView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import SwiftUI

struct AgeView: View {
    @Environment(\.authViewModel) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("And, how old are you?")
                .font(.title)
                .bold()
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            Text("Date of Birth")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,25)
                    
            Button {
                
            } label: {
                Text(viewModel.registerDOB, style: .date)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 15)
            }
            
            Button {
                viewModel.createAccount()
            } label: {
                Text("Create an account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color(.kPrimary))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
            }
            Spacer()
            
            DatePicker("", selection: $viewModel.registerDOB, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .padding()

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.light)
    }

}

#Preview {
    AgeView()
}
