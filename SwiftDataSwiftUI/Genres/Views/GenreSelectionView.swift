//Created by Halbus Development

import SwiftUI
import SwiftData

struct GenreSelectionView: View {
    @Query(sort: \Genre.name) private var genres: [Genre]
    @Binding var selectedGenres: Set<Genre>
    
    var body: some View {
        List {
            Section("Literary Genres") {
                ForEach(genres) { genre in
                    HStack {
                        Text(genre.name)
                        Spacer()
                        Image(systemName: selectedGenres.contains(genre) ? "checkmark.circle.fill" : "circle")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !selectedGenres.contains(genre) {
                            selectedGenres.insert(genre)
                        } else {
                            selectedGenres.remove(genre)
                        }
                    }
                    
                }
            }
        }
        .listStyle(.plain)
    }
}
