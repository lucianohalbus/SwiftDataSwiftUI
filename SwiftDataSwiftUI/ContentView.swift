//

import SwiftUI

struct ContentView: View {
    @State private var launchAddNew: Bool = false
    var body: some View {
        VStack {
//            Button("Add new book") {
//                launchAddNew.toggle()
//            }
//            .sheet(isPresented: $launchAddNew, content: {
//                AddNewBookView()
//            })
            
            BookListView()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
