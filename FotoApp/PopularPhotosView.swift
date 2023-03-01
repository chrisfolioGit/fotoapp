import SwiftUI

struct PopularPhotosView: View {
    @State private var popularImages: [ImageResult] = []
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Photos")
                .font(.headline)
                .padding(.leading)
            
            if isLoading {
                ProgressView()
                    .padding()
            } else {
                HorizontalScrollView {
                    ForEach(popularImages, id: \.id) { image in
                        VStack(alignment: .leading) {
                            RemoteImage(url: URL(string: image.previewURL)) {
                                Image(systemName: "photo")
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1))
                            .onTapGesture {
                                self.selectedImageURL = URL(string: image.largeImageURL)
                                self.isShowingDetail.toggle()
                            }
                            
                            Text(image.user)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                        }
                    }
                }
                .sheet(isPresented: $isShowingDetail) {
                    ImageDetailView(imageURL: $selectedImageURL)
                }
                .padding(.bottom)
                .onAppear {
                    fetchPopularImages()
                }
            }
        }
    }
    
    private func fetchPopularImages() {
        isLoading = true
        PixabayAPI.getPopularImages { result in
            switch result {
            case .success(let images):
                popularImages = images
            case .failure(let error):
                print(error)
            }
            isLoading = false
        }
    }
}

struct PopularPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PopularPhotosView()
    }
}
