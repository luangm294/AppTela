import SwiftUI
import RealityKit

	struct AddView: View {
		@State private var photoCount = 0
		@State private var level = ProgressLevel.insuficiente
		@State private var isShowingPhotoView = false
		
		var body: some View {
			NavigationView {
				ZStack {
					ARViewContainer()
					
					VStack {
						ProgressView(level: level, progress: calculateProgress())
							.frame(height: 20)
							.padding(.top, 20)
						
						Spacer()
						
						HStack {
							Button(action: {
								isShowingPhotoView = true
							}) {
								Image(systemName: "arrow.up.circle.fill")
									.resizable()
									.frame(width: 60, height: 60)
									.foregroundColor(.white)
									.padding(20)
									.background(Color.white.opacity(0.3))
									.clipShape(Circle())
							}
							.disabled(level == .otimo)
							
							Circle()
								.frame(width: 80, height: 80)
								.foregroundColor(.white)
								.onTapGesture {
									takePhoto()
								}
							
							NavigationLink(destination: SelectionView()) {
								Image(systemName: "landscape")
									.imageScale(.large)
									.foregroundColor(.white)
									.padding(20)
									.background(Color.white.opacity(0.3))
									.clipShape(Circle())
							}
							.disabled(level != .bom)
						}
						.padding(.bottom, 20)
					}
					.padding()
					.sheet(isPresented: $isShowingPhotoView) {
						PhotoView(photoCount: $photoCount, level: $level, isShowingPhotoView: $isShowingPhotoView)
					}
				}
				.navigationBarHidden(true)
			}
		}
		
		private func takePhoto() {
			photoCount += 1
			
			if photoCount <= 25 {
				level = .insuficiente
			} else if photoCount <= 55 {
				level = .bom
			} else if photoCount <= 90 {
				level = .otimo
			}
		}
		
		private func calculateProgress() -> Float {
			if photoCount <= 25 {
				return Float(photoCount) / 25
			} else if photoCount <= 55 {
				return Float(photoCount - 25) / 30
			} else if photoCount <= 90 {
				return Float(photoCount - 55) / 35
			} else {
				return 1.0
			}
		}
	}

	enum ProgressLevel {
		case insuficiente
		case bom
		case otimo
		
		var description: String {
			switch self {
				case .insuficiente:
					return "Insuficiente"
				case .bom:
					return "Bom"
				case .otimo:
					return "Ótimo"
			}
		}
	}

	struct ProgressView: View {
		var level: ProgressLevel
		var progress: Float
		
		var body: some View {
			ZStack(alignment: .leading) {
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(Color.gray.opacity(0.3))
				
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(level.color)
					.frame(width: calculateProgressWidth(), height: 20)
					.animation(.linear)
				
				Text(level.description)
					.font(.headline)
					.foregroundColor(.white)
					.padding(.leading, 10)
					.padding(.top, -7)
					.opacity(progress >= 1.0 ? 1.0 : 0.0)
			}
		}
		
		private func calculateProgressWidth() -> CGFloat {
			return CGFloat(progress) * UIScreen.main.bounds.width
		}
	}

	extension ProgressLevel {
		var color: Color {
			switch self {
				case .insuficiente:
					return Color.red
				case .bom:
					return Color.yellow
				case .otimo:
					return Color.green
			}
		}
	}

	struct ARViewContainer: UIViewRepresentable {
		func makeUIView(context: Context) -> ARView {
			let arView = ARView(frame: .zero)
			return arView
		}
		
		func updateUIView(_ uiView: ARView, context: Context) {}
	}

	struct AddView_Previews: PreviewProvider {
		static var previews: some View {
			AddView()
		}
	}
