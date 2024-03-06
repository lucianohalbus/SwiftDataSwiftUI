
import SwiftUI

struct ContentView: View {
    @State private var launchAddNew: Bool = false
    var body: some View {
        VStack {
            BookListView()
            
            Button("Add new book") {
                launchAddNew.toggle()
            }
            .sheet(isPresented: $launchAddNew, content: {
                AddNewBookView()
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
