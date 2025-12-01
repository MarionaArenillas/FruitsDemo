
import SwiftUI

//TODO: Create a list
//TODO: Create the navigation
struct ContentView: View {
    @EnvironmentObject private var store: FruitStore
    @State private var newFruit = FruitStore.defaultFruit
    @State private var showingAddFruit = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView{
            List {
                ForEach(store.fruits) {
                    fruit in NavigationLink(destination: DetailFruitView(fruit: fruit)) {
                        FruitRowView(fruit: fruit)
                    }
                }
                .onDelete(perform: deleteFruit)

            }
        }
    }
    
    private func deleteFruit(at offsets: IndexSet) {
        store.fruits.remove(atOffsets: offsets)
    }

    private func saveFruit() {
        // Validar que el nombre no esté vacío
        let trimmedName = newFruit.name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else {
            alertMessage = "The fruit must have a name"
            showingAlert = true
            return
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FruitStore())
    }
}



