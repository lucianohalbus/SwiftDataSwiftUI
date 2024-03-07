//Created by Halbus Development

import SwiftUI
import PhotosUI

struct BookDetailview: View {
    let book: Book

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var publishedYear: Int?
    
    @State private var showAddNewNote: Bool = false
    @State private var selectedGenres = Set<Genre>()
    
    @State private var selectedCover: PhotosPickerItem?
    @State private var selectedCoverData: Data?
    
    init(book: Book) {
        self.book = book
        self._title = State.init(initialValue: book.title)
        self._author = State.init(initialValue: book.author)
        self._publishedYear = State.init(initialValue: book.publishedYear)
        
        self._selectedGenres = State.init(initialValue: Set(book.genres))
    }
    
    private var bookCoverUI: some View {
        HStack {
            PhotosPicker(
                selection: $selectedCover,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Label("Add Cover", systemImage: "book.closed")
            }
            .padding(.vertical)
           
            Spacer()
            
            if let selectedCoverData, let image = UIImage(data: selectedCoverData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 5))
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "photo")
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
    }
    
    var body: some View {
        Form {
            if isEditing {
                Group {
                    TextField("Book title", text: $title)
                    TextField("Book author", text: $author)
                    TextField("Book published year", value: $publishedYear, format: .number.grouping(.never))
                        .keyboardType(.numberPad)
                    
                    // book cover
                    bookCoverUI
                    
                    // genres
                    GenreSelectionView(selectedGenres: $selectedGenres)
                        .frame(height: 300)
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Save") {
                    guard let publishedYear = publishedYear else { return }
                    
                    book.title = title
                    book.author = author
                    book.publishedYear = publishedYear
                    
                    // genre
                    book.genres = []
                    book.genres = Array(selectedGenres)
                    
                    selectedGenres.forEach { genre in
                        if !genre.books.contains(where: { b in
                            b.title == book.title
                        }) {
                            genre.books.append(book)
                        }
                    }
                    
                    // save book cover
                    if let selectedCoverData {
                        book.cover = selectedCoverData
                    }
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }
                
            } else {
                Text(book.title)
                Text(book.author)
                Text(book.publishedYear.description)
                
                if !book.genres.isEmpty {
                    HStack {
                        ForEach(book.genres) { genre in
                            Text(genre.name)
                                .font(.caption)
                                .padding(.horizontal)
                                .background(.green.opacity(0.3), in: .capsule)
                        }
                    }
                }
                
                if let cover = book.cover, let image = UIImage(data: cover) {
                    HStack {
                        Text("Book Cover")
                        Spacer()
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 5))
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            
            if !isEditing {
                Section("Notes") {
                    Button("Add new note") {
                        showAddNewNote.toggle()
                    }
                    .sheet(isPresented: $showAddNewNote) {
                        NavigationStack {
                            AddNewNote(book: book)
                        }
                        .presentationDetents([.fraction(0.3)])
                        .interactiveDismissDisabled()
                    }
                    
                    if book.notes.isEmpty {
                        ContentUnavailableView("No notes!", systemImage: "note")
                    } else {
                        NotesListView(book: book)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
                .hidden(isEnabled: isEditing)
            }
        }
        .task(id: selectedCover) {
            if let data = try? await selectedCover?.loadTransferable(type: Data.self) {
                selectedCoverData = data
            }
        }
        .navigationTitle("Book detail")
    }
}
