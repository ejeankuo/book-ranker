//
//  AuthView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//
import SwiftUI

struct AuthView: View {
    @State var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height:300)
                    .padding(.top, 60)
                .clipped()
                
                Spacer()
                
                Text("Welcome to Ranklit")
                    .font(.title)
                
                Text("Create an account to rank books \n and find new ones.")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink {
                    EmailView()
                        .environment(viewModel)
                } label: {
                    Text("Get Started")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color(.kPrimary))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding(.horizontal, 45)
                }
                
                NavigationLink {
                    LogInView()
                        .environment(viewModel)
                } label: {
                    Text("Already have an account? Log in")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.gray)

                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .preferredColorScheme(.light)
        }
    }
}
#Preview {
    NavigationStack { AuthView() }
}
