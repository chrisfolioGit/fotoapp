import Foundation

struct PixabayAPI {
    private static let apiKey = "12860656-ac77502b1a14d35a2c44a554d"
    
    static func searchImages(for query: String, completion: @escaping ([ImageResult]?) -> Void) {
        guard let url = URL(string: "https://pixabay.com/api/?key=\(apiKey)&q=\(query.replacingOccurrences(of: " ", with: "+"))&image_type=photo") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ImageResults.self, from: data)
                completion(result.hits)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
