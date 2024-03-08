//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    @State private var presentAddNew: Bool = false
    @State private var searchTerm: String = ""
    var filteredBooks: [Book] {
        guard !searchTerm.isEmpty else { return books }
        return books.filter {
            $0.title.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBooks) { book in
                   BookCellView(book: book)
                }
                .onDelete(perform: delete(indexSet: ))
                .searchable(text: $searchTerm, prompt: "Search book title")
            }
            .navigationTitle("Reading Logs")
            .navigationDestination(for: Book.self) { book in
                BookDetailview(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentAddNew.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .sheet(isPresented: $presentAddNew, content: {
                        AddNewBookView()
                    })
                }
            }
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
