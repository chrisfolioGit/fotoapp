import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var images: [ImageResult] = []
    @State private var isShowingDetail = false
    @State private var selectedImageURL: URL?
    @State private var isLoading = false
    
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack { // 3
                VStack {
                    SearchBarView(searchText: $searchText, onSearch: search)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 8) {
                            ForEach(images) { image in
                                Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: image.previewURL)!))!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        self.selectedImageURL = URL(string: image.largeImageURL)
                                        self.isShowingDetail.toggle()
                                    }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.leading, 8) // left padding
                        .padding(.trailing, 8) // right padding
                        .frame(maxWidth: .infinity)
                        .sheet(isPresented: $isShowingDetail) {
                            ImageDetailView(imageURL: $selectedImageURL)
                        }
                        .frame(maxWidth: .infinity) // hier die Änderung

                    }
                }
                .navigationTitle("ShutterSeek")
                
                if isLoading { // 2
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 3
                }
            }
        }
    }
    
    func search() {
        isLoading = true
        
        PixabayAPI.searchImages(for: searchText) { results in
            DispatchQueue.main.async {
                self.images = results ?? []
                self.isLoading = false
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
