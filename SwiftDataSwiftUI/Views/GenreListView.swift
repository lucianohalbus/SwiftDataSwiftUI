//Created by Halbus Development

import SwiftUI
import SwiftData

struct GenreListView: View {
    @Query(sort: \Genre.name)
    private var genres: [Genre]
    
    @State private var presenteAddNew = false
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(genres) { genre in
                    Text(genre.name)
                }
                .onDelete(perform: deleteGenre(indexSet:))
            }
            .navigationTitle("Literary Genre")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presenteAddNew.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $presenteAddNew) {
                        AddNewGenre()
                            .presentationDetents([.fraction(0.3)])
                            .interactiveDismissDisabled()
                    }
                }
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
