// Projecte creat per Evelyn Aguayo i Mariona Arenillas

import SwiftUI

@main
struct FruitsDemoApp: App {
    @StateObject var store = FruitStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
