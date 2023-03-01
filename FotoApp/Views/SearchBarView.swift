import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                if isEditing {
                    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                }
            }, onCommit: onSearch)
                .padding(.horizontal)
                .frame(height: 40)
                .background(Color(.systemGray5))
                .cornerRadius(8)
            
            HStack {
                Spacer()
                
                if !searchText.isEmpty {
                    Button(action: clearSearchText) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }
    
    func clearSearchText() {
        searchText = ""
    }
}
