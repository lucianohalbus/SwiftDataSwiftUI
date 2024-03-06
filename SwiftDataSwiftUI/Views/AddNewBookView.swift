//

import SwiftUI
import SwiftData

struct AddNewBookView: View {
    @State var title: String = ""
    @State var author: String = ""
    @State var publishedYear: Int?
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    private var isValid: Bool {
        !title.isEmpty && !author.isEmpty && publishedYear != nil
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Book Title")
                TextField("Enter book title: ", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                Text("Book Author: ")
                TextField("Enter author", text: $author)
                    .textFieldStyle(.roundedBorder)
                
                Text("Published Year: ")
                TextField("Enter published year", value: $publishedYear, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                HStack {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let publishedYear else { return }
                        let book: Book = Book(
                            title: title,
                            author: author,
                            publishedYear: publishedYear
                        )
                        
                        context.insert(book)
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isValid)
                }
            }
            .padding()
            .navigationTitle("Add New Book")
            
            Spacer()
        }
    }
}

#Preview {
    AddNewBookView()
}