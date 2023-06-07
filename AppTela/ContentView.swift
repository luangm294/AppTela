
//  ContentView.swift
//  GettingStartedAR
//
//  Created by projeto smart on 12/04/23.
//

import SwiftUI

struct ContentView: View {
	@State private var showingAddFolder = false
	@State private var folderName = ""
	@State private var folders = [Folder]()
	
	var body: some View {
		VStack {
			TabView {
				HomeView()
				//					.tabItem {
				//						Label("Home", systemImage: "house")
			}
			//				CreateFolderView(showingAddFolder: $showingAddFolder, folderName: $folderName)
			//					.tabItem {
			//						NavigationLink(destination: CreateFolderView(showingAddFolder: $showingAddFolder, folderName: $folderName)) {
			//							Label("Create", systemImage: "plus.viewfinder")
			//						}
			//					}
			
			//				CreateFolderView(showingAddFolder: $showingAddFolder, folderName: $folderName)
			//					.tabItem {
			//						Label("Create", systemImage: "person.crop.circle")
			//					}
			//
			//
			//				LoginView()
			//					.tabItem {
			//						Label("Account", systemImage: "person.crop.circle")
			//					}
			
			
		}
	}
}
//}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
#endif
