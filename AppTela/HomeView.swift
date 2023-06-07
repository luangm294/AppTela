import SwiftUI

struct Folder: Identifiable {
	let id = UUID()
	let name: String
	let createdAt: Date
}

struct HomeView: View {
	@State private var showingAddFolder = false
	@State private var folderName = ""
	@State private var folders = [Folder]()
	
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd/yyyy"
		return formatter
	}
	
	var timeFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "hh:mm a"
		return formatter
	}
	
	var body: some View {
		NavigationView {
			VStack {
				HStack(spacing: 114) {
					Text("WearCalculus")
						.font(.largeTitle)
						.bold()
					
					Menu {
						Button(action: {}, label: {
							Label("Tutorial", systemImage: "info.circle")
						})
						Button(action: {}, label: {
							Label("Privacy Policy", systemImage: "shield.lefthalf.fill")
						})
						Button(action: {}, label: {
							Label("Logout", systemImage: "power")
						})
					} label: {
						Image(systemName: "line.horizontal.3")
							.foregroundColor(.primary)
							.font(.title2)
					}
				}
				.padding(.horizontal)
				
				HStack {
					Text("Created Models")
						.font(.title2)
						.foregroundColor(.secondary)
					
					Spacer()
					
					Button(action: {
						showingAddFolder = true
					}, label: {
						Image(systemName: "plus.circle.fill")
							.foregroundColor(.blue)
							.font(.title2)
							.padding(.horizontal, 8)
							.padding(.vertical, 4)
							.background(Color.blue.opacity(0.1))
							.cornerRadius(12)
					})
					.disabled(showingAddFolder)
					.sheet(isPresented: $showingAddFolder, content: {
						CreateFolderView(showingAddFolder: $showingAddFolder, folderName: $folderName, folders: $folders)
					})
					
					Menu {
						Button(action: {}, label: {
							Label("Rename", systemImage: "square.and.pencil")
						})
						Button(action: {}, label: {
							Label("Delete", systemImage: "trash")
						})
					} label: {
						Image(systemName: "ellipsis.circle")
							.foregroundColor(.primary)
							.font(.title2)
							.padding(.horizontal, 8)
							.padding(.vertical, 4)
							.background(Color.gray.opacity(0.1))
							.cornerRadius(12)
					}
				}
				.padding(.horizontal)
				
				List(folders) { folder in
					NavigationLink(destination: FolderDetailView(folder: folder)) {
						VStack(alignment: .leading) {
							HStack {
								Text(folder.name)
									.font(.headline)
								Spacer()
							}
							HStack {
								Text("\(dateFormatter.string(from: folder.createdAt)) \(timeFormatter.string(from: folder.createdAt))")
									.font(.subheadline)
									.foregroundColor(.secondary)
								Spacer()
							}
						}
						.padding(.vertical, 8)
					}
				}
				
				
				Spacer()
			}
//			.navigationBarHidden(true)
		}
	}
	
	private func addFolder() {
		let newFolder = Folder(name: folderName, createdAt: Date())
		folders.append(newFolder)
		folderName = ""
		showingAddFolder = false
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
