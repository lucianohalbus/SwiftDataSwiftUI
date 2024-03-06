//

import Foundation
import SwiftData

@Model
final class Book {
    let title: String
    let author: String
    let publishedYear: Int
    
    init(title: String, author: String, publishedYear: Int) {
        self.title = title
        self.author = author
        self.publishedYear = publishedYear
    }
}
