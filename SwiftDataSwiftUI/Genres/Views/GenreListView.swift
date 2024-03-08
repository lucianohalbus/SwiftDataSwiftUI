//Created by Halbus Development

import SwiftUI
import SwiftData

struct GenreListView: View {
    
    @State private var presenteAddNew = false
    @State private var sortOrder: GenreSortOrder = .forward
    
    var body: some View {
        NavigationStack {
            GenreListSubView(sortOrder: sortOrder)
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

                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            sortOrder = sortOrder == GenreSortOrder.forward ? GenreSortOrder.reverse : GenreSortOrder.forward
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
        }
    }
}
