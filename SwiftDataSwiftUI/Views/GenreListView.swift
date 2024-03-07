//Created by Halbus Development

import SwiftUI
import SwiftData

struct GenreListView: View {
    @Query(sort: \Genre.name)
    private var genres: [Genre]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(genres) { genre in
                    Text(genre.name)}
            }
        }
        .navigationTitle("Literary Genre")
    }
}
