//
//  SplashScreenView.swift
//  CriarPasta
//
//  Created by projeto smart on 08/05/23.
//

import SwiftUI

struct SplashScreenView: View {
	@State private var isActive = false
	
	var body: some View {
		VStack {
			Image("Logo")
				.resizable()
				.frame(width: 200, height: 200)
		}
		.background(Color.white)
		.edgesIgnoringSafeArea(.all)
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
				isActive = true
			}
		}
		.fullScreenCover(isPresented: $isActive, content: {
			ContentView()
		})
	}
}

struct SplashScreenView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
