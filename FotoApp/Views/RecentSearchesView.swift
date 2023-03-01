import SwiftUI

struct RecentSearchesView: View {
    var recentSearches = ["Nature", "Cityscape", "Food", "Sports", "Music"]
    
    var body: some View {
        List(recentSearches, id: \.self) { search in
            Text(search)
        }
        .navigationTitle("Recent Searches")
    }
}

struct RecentSearchesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchesView()
    }
}
