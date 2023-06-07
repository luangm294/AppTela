//
//  FolderDetailView.swift
//  CriarPasta
//
//  Created by projeto smart on 16/05/23.
//


import SwiftUI
import RealityKit

struct Model: Identifiable {
	let id = UUID()
	let name: String
	let createdAt: Date
}

struct FolderDetailView: View {
	let folder: Folder
	@State private var models = [Model]()
	@State private var isSelectMenuOpen = false
	@State private var isCameraMenuOpen = false
	
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					Text(folder.name)
						.font(.largeTitle)
						.bold()
					Spacer()
					Menu {
						Button(action: {
							// Share model
						}) {
							Label("Share", systemImage: "square.and.arrow.up")
						}
						Button(action: {
							// Remove model
						}) {
							Label("Remove", systemImage: "trash")
						}
						Button(action: {
							// Compare models
						}) {
							Label("Compare", systemImage: "rectangle.stack")
						}
					} label: {
						Text("Select")
							.foregroundColor(.white)
							.font(.headline)
							.padding(.vertical, 10)
							.padding(.horizontal, 20)
							.background(Color.blue)
							.cornerRadius(20)
					}
					.menuStyle(BorderlessButtonMenuStyle())
				}
				.padding()
				
				Spacer()
				
				HStack {
					Button(action: {
						// See comparisons
					}, label: {
						Image(systemName: "rectangle.stack")
							.foregroundColor(.white)
							.font(.title2)
							.padding(.vertical, 12)
							.padding(.horizontal, 24)
							.background(Color.blue)
							.cornerRadius(16)
					})
					
					Spacer()
					
					NavigationLink(destination: AddView(), isActive: $isCameraMenuOpen) {
						Button(action: {
							isCameraMenuOpen = true
						}, label: {
							Image(systemName: "camera")
								.foregroundColor(.white)
								.font(.title2)
								.padding(.vertical, 12)
								.padding(.horizontal, 24)
								.background(Color.blue)
								.cornerRadius(16)
						})
					}
				}
				.padding()
				.background(Color.gray.opacity(0.1))
			}
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

#if DEBUG
struct FolderDetailView_Previews: PreviewProvider {
	static var previews: some View {
		FolderDetailView(folder: Folder(name: "My Models", createdAt: Date()))
	}
}
#endif
