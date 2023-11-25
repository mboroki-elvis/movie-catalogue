import SwiftData
import SwiftUI

@main
struct MovieCatalogueApp: App {
    @State private var router = AppRouter(.landing)
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([Movie.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .environment(router)
        }
        .modelContainer(sharedModelContainer)
    }
}
