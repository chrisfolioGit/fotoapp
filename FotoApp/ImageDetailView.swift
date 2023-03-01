import SwiftUI

struct ImageDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageURL: URL?
    
    var body: some View {
        if let imageURL = imageURL {
            VStack {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Text("Failed to load image")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } else {
            Text("No image selected")
        }
    }
}
