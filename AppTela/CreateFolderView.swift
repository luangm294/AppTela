//
//  CreateFolderView.swift
//  CriarPasta
//
//  Created by projeto smart on 05/05/23.
//

import SwiftUI

struct CreateFolderView: View {
	@Binding var showingAddFolder: Bool
	@Binding var folderName: String
	@Binding var folders: [Folder]
	
	var body: some View {
		VStack(spacing: 32) {
			VStack(spacing: 16) {
				Image(systemName: "folder.badge.plus")
					.font(.system(size: 96))
					.foregroundColor(.black)
					.shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
				
				Text("Create New Folder")
					.font(.largeTitle)
					.fontWeight(.bold)
					.foregroundColor(.black)
					.shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
			}
			
			TextField("Nome da pasta", text: $folderName)
				.padding()
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(Color.white)
						.shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
				)
			
			HStack(spacing: 16) {
				Button(action: {
					showingAddFolder = false
					folderName = ""
				}) {
					Text("Cancel")
						.font(.headline)
						.foregroundColor(.white)
						.padding()
						.frame(maxWidth: .infinity)
						.background(
							RoundedRectangle(cornerRadius: 10)
								.fill(Color.blue)
								.shadow(color: Color.blue.opacity(0.3), radius: 4, x: 0, y: 4)
						)
				}
				
				Button(action: {
					addFolder()
				}) {
					Text("Create")
						.font(.headline)
						.foregroundColor(.white)
						.padding()
						.frame(maxWidth: .infinity)
						.background(
							RoundedRectangle(cornerRadius: 10)
								.fill(isCreateButtonEnabled() ? Color.blue : Color.gray)
								.shadow(color: Color.blue.opacity(0.3), radius: 4, x: 0, y: 4)
						)
				}
				.disabled(!isCreateButtonEnabled())
			}
			
			Spacer()
		}
		.padding()
		.background(
			LinearGradient(
				gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.7)]),
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
		)
		.navigationBarTitle("Criar Pasta", displayMode: .inline)
		.navigationBarBackButtonHidden(true)
		.navigationBarItems(
			leading: Button(action: {
				showingAddFolder = false
				folderName = ""
			}) {
				Image(systemName: "chevron.left")
					.font(.title)
					.foregroundColor(.white)
			}
		)
	}
	
	private func isFolderNameValid() -> Bool {
		let nameRegex = "^[a-zA-Z][a-zA-Z0-9 ]{0,14}$"
		let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
		let trimmedName = folderName.trimmingCharacters(in: .whitespaces)
		return namePredicate.evaluate(with: trimmedName)
	}
	
	private func isFolderNameUnique() -> Bool {
		!folders.contains(where: { $0.name == folderName })
	}
	
	private func isCreateButtonEnabled() -> Bool {
		return !folderName.isEmpty && isFolderNameValid() && isFolderNameUnique()
	}
	
	private func addFolder() {
		let newFolder = Folder(name: folderName, createdAt: Date())
		folders.append(newFolder)
		folderName = ""
		showingAddFolder = false
	}
}

struct CreateFolderView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
