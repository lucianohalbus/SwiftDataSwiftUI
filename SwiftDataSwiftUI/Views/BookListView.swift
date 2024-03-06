//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                   BookCellView(book: book)
                }
                .onDelete(perform: delete(indexSet: ))
            }
            .navigationTitle("Reading Logs")
        }
    }
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let book = books[index]
            context.delete(book)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    BookListView()
}
