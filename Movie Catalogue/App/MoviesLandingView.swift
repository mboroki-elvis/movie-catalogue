import SwiftData
import SwiftUI

struct MoviesLandingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var movies: [Movie]
    @Bindable var viewModel = MovieViewModel()
    var body: some View {
        NavigationSplitView {
            VStack {
                if !movies.isEmpty {
                    HStack {
                        ForEach(movies) { item in
                            Text(item.originalTitle ?? "failed")
                        }
                        .onDelete(perform: deleteItems)
                    }
                }

                List {
                    ForEach($viewModel.movies) { item in
                        Text(item.originalTitle.wrappedValue ?? "failed")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }

    private func addItem() {
        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
        }
    }
}

#Preview {
    MoviesLandingView()
        .modelContainer(for: Movie.self, inMemory: true)
}
