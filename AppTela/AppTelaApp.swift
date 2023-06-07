//
//  CriarPastaApp.swift
//  CriarPasta
//
//  Created by projeto smart on 04/05/23.
//

import SwiftUI

@main
struct AppTelaApp: App {
	var body: some Scene {
		WindowGroup {
			SplashScreenView()
				.onAppear {
					// Aqui eu posso adicionar lógica para preparar o app para ser exibido
					// Por exemplo, carregar dados iniciais ou executar uma animação
				}
		}
	}
}
