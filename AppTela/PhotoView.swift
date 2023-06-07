import PhotosUI
import SwiftUI

struct PhotoView: View {
	@Binding var photoCount: Int
	@Binding var level: ProgressLevel
	@Binding var isShowingPhotoView: Bool
	@State var selectedItems: [PhotosPickerItem] = []
	@State var data: Data?
	
	var body: some View {
		VStack {
			Text("Photos")
				.font(.largeTitle)
				.foregroundColor(.black)
				.bold()
			
			if let data = data, let uiimage = UIImage(data: data) {
				Image(uiImage: uiimage)
					.resizable()
				
				
			}
			Spacer()
			PhotosPicker(selection: $selectedItems) { selectedItems in
				handleSelectedItems(selectedItems)
			}
		}
		.padding()
		.background(Color.white)
		.cornerRadius(10)
		.frame(height: 750)
		.padding(4)
	}
	
	private func handleSelectedItems(_ selectedItems: [PhotosPickerItem]) {
		self.selectedItems = selectedItems
		photoCount += selectedItems.count
		
		if photoCount <= 25 {
			level = .insuficiente
		} else if photoCount <= 55 {
			level = .bom
		} else if photoCount <= 90 {
			level = .otimo
		}
	}
}

struct PhotoView_Previews: PreviewProvider {
	static var previews: some View {
		PhotoView(photoCount: .constant(0), level: .constant(.insuficiente), isShowingPhotoView: .constant(true))
	}
}

struct PhotosPicker: UIViewControllerRepresentable {
	typealias UIViewControllerType = PHPickerViewController
	typealias SelectionHandler = ([PhotosPickerItem]) -> Void
	
	@Environment(\.presentationMode) private var presentationMode
	@Binding var selection: [PhotosPickerItem]
	let selectionHandler: SelectionHandler
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIViewController(context: Context) -> PHPickerViewController {
		var configuration = PHPickerConfiguration()
		configuration.filter = .images
		configuration.selectionLimit = 10 - selection.count
		
		let picker = PHPickerViewController(configuration: configuration)
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
	
	class Coordinator: PHPickerViewControllerDelegate {
		private let parent: PhotosPicker
		
		init(_ parent: PhotosPicker) {
			self.parent = parent
		}
		
		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
			parent.presentationMode.wrappedValue.dismiss()
			
			var selectedItems: [PhotosPickerItem] = []
			for result in results where result.itemProvider.canLoadObject(ofClass: UIImage.self) {
				selectedItems.append(PhotosPickerItem(itemProvider: result.itemProvider))
			}
			
			parent.selectionHandler(selectedItems)
		}
	}
}

struct PhotosPickerItem: Identifiable {
	let id = UUID()
	let itemProvider: NSItemProvider
	
	init(itemProvider: NSItemProvider) {
		self.itemProvider = itemProvider
	}
}
