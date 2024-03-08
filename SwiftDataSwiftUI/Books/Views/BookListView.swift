//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    @State private var presentAddNew: Bool = false
    @State private var searchTerm: String = ""
    @State private var bookSortOption = SortingOption.none
    
    var body: some View {
        NavigationStack {
            BookListSubView(searchTerm: searchTerm, bookSortOption: bookSortOption)
            .searchable(text: $searchTerm, prompt: "Search book title")
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(SortingOption.allCases) { sortOption in
                            Button(sortOption.title) {
                                bookSortOption = sortOption
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    BookListView()
}
