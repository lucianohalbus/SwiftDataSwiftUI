//Created by Halbus Development

import SwiftUI
import SwiftData

struct GenreListSubView: View {
    
    @Query private var genres: [Genre]
    @Environment(\.modelContext) private var context
    
    init(sortOrder: GenreSortOrder = .forward) {
        _genres = Query(FetchDescriptor<Genre>(sortBy: [sortOrder.sortOption]), animation: .snappy)
    }
    
    var body: some View {
        Group {
            if !genres.isEmpty {
                List {
                    ForEach(genres) { genre in
                        NavigationLink(value: genre) {
                            Text(genre.name)
                        }
                    }
                    .onDelete(perform: deleteGenre(indexSet:))
                }
                .navigationDestination(for: Genre.self, destination: { genre in
                    GenreDetailView(genre: genre)
                })
            } else {
                ContentUnavailableView("Time to add a new Genre!", systemImage: "square.3.layers.ed.down.left.slash")
            }
        }
    }
    
    private func deleteGenre(indexSet: IndexSet) {
        indexSet.forEach { index in
            let genreToDelete = genres[index]
            context.delete(genreToDelete)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

