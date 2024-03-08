//

import SwiftUI

struct BookCellView: View {
    let book: Book
    
    var body: some View {
        NavigationLink(value: book) {
            HStack(alignment: .top){
                if let cover = book.cover, let image = UIImage(data: cover) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 5))
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
                VStack(alignment: .leading) {
                    Text(book.title)
                        .bold()
                    
                    Group {
                        Text("Author: \(book.author)")
                        Text("Published on: \(book.publishedYear.description)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
            }
        }
    }
}
