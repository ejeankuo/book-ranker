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
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height:300)
                .clipped()
                
                Spacer()
                
                Text("welcome to ranklit")
                    .font(.title)
                
                Text("create an account to rank books \n and find new ones")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink {
                    EmailView()
                        .environment(viewModel)
                } label: {
                    Text("get started")
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
                    Text("already have an account? log in")
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
