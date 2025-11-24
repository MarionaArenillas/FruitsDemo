
import SwiftUI

//TODO: Create a list
//TODO: Create the navigation
struct ContentView: View {
    @EnvironmentObject private var store:FruitStore
    @State private var newFruit = FruitStore.defaultFruit
    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FruitStore())
    }
}



