//
//  LoginView.swift
//  Teste (Luan)
//
//  Created by projeto smart on 11/04/23.
//

import SwiftUI

struct LoginView: View {
	var body: some View {
		VStack {
			Text("Login to your account")
				.font(.title)
				.fontWeight(.bold)
				.padding()
			
			Spacer()
			
			Button(action: {
			}, label: {
				HStack {
					Image(systemName: "applelogo")
						.foregroundColor(.white)
					Text("Continue with Apple")
						.foregroundColor(.white)
						.fontWeight(.semibold)
				}
				.frame(maxWidth: .infinity)
				.padding()
				.background(Color.black)
				.cornerRadius(10)
				.padding(.horizontal)
			})
			
			Spacer()
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
