//Created by Halbus Development

import Foundation
import SwiftData

@Model
final class Genre {
    var name: String
    var books: [Book] = []
    
    init(name: String) {
        self.name = name
    }
}
