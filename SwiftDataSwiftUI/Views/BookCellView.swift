//

import SwiftUI

struct BookCellView: View {
    let book: Book
    
    var body: some View {
        NavigationLink(value: book) {
            VStack(alignment: .leading) {
                Text(book.title)
                
                HStack {
                    Text("Author: \(book.author)")

                    Text("Published on: \(book.publishedYear.description)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        }
    }
}
