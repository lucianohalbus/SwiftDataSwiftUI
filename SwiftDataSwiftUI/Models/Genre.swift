//Created by Halbus Development

import Foundation
import SwiftData

@Model
final class Genre {
    let name: String
    let books: [Book] = []
    
    init(name: String) {
        self.name = name
    }
}
