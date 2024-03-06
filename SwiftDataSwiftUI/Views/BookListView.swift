//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Query private var books: [Book]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    Text(book.title)
                }
            }
            .navigationTitle("Reading Logs")
        }
    }
}

#Preview {
    BookListView()
}
