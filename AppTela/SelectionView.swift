import SwiftUI
import PhotosUI

struct Photo: Identifiable {
	let id: String
	let creationDate: Date
	let image: UIImage
	var isSelected: Bool
}

struct PhotoItem: View {
	@Binding var photo: Photo
	@Binding var isTrashEnabled: Bool
//	@Binding var isTrashEnabled: Bool
	
	var body: some View {
		VStack {
			Image(uiImage: photo.image)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 80, height: 80)
				.cornerRadius(8)
				.opacity(photo.isSelected ? 0.5 : 1.0)
				.onLongPressGesture(minimumDuration: 2.0) {
					isTrashEnabled = true
				}
			
			Text(photo.creationDate.description)
				.font(.caption)
				.foregroundColor(.secondary)
		}
	}
}

struct SelectionView: View {
	@State private var photos: [Photo] = []
	
	var body: some View {
		NavigationView {
			VStack {
				List {
					ForEach(photos) { photo in
						Image(uiImage: photo.image)
							.resizable()
							.frame(width: 80, height: 80)
							.cornerRadius(8)
							.onLongPressGesture(minimumDuration: 2) {
								deletePhoto(photo)
							}
					}
					.onDelete(perform: deletePhotos)
				}
				
				Spacer()
				
				Button(action: {
					// Add button action
				}) {
					Image(systemName: "trash")
						.resizable()
						.frame(width: 30, height: 30)
						.foregroundColor(.red)
				}
				.padding()
			}
			.navigationBarTitle("Selection View")
			.onAppear {
				photos = loadPhotos()
			}
		}
	}
	
	private func loadPhotos() -> [Photo] {
		var loadedPhotos: [Photo] = []
		
		let fetchOptions = PHFetchOptions()
		fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
		
		let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
		
		fetchResult.enumerateObjects { (asset, index, _) in
			let options = PHImageRequestOptions()
			options.isSynchronous = true
			
			PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 80, height: 80), contentMode: .aspectFill, options: options) { (image, _) in
				if let image = image {
					let photo = Photo(id: asset.localIdentifier, creationDate: asset.creationDate ?? Date(), image: image, isSelected: false)
					loadedPhotos.append(photo)
				}
			}
		}
		
		return loadedPhotos
	}
	
	private func deletePhoto(_ photo: Photo) {
		// Delete photo logic
	}
	
	private func deletePhotos(at offsets: IndexSet) {
		// Delete multiple photos logic
	}
}

struct SelectionView_Previews: PreviewProvider {
	static var previews: some View {
		SelectionView()
	}
}
