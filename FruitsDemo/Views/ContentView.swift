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
        NavigationView {
            List {
                ForEach(store.fruits) { fruit in
                    NavigationLink(destination: DetailFruitView(fruit: fruit)) {
                        FruitRowView(fruit: fruit)
                    }
                }
                .onDelete(perform: deleteFruit)
            }
            .navigationTitle("Fruits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        newFruit = FruitStore.defaultFruit
                        showingAddFruit = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddFruit) {
                NavigationView {
                    AddFruitView(newFruit: $newFruit)
                        .navigationTitle("Add Fruit")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showingAddFruit = false
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    saveFruit()
                                }
                                .disabled(newFruit.name.trimmingCharacters(in: .whitespaces).isEmpty)
                            }
                        }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(alertMessage),
                        dismissButton: .cancel(Text("OK"))
                    )
                }
            }
        }
    }
    
    private func deleteFruit(at offsets: IndexSet) {
        store.fruits.remove(atOffsets: offsets)
    }
    
    private func saveFruit() {
        // Validar que el nombre no esté vacío
        let trimmedName = newFruit.name.trimmingCharacters(in: .whitespaces)
        
        // Nom buit
        guard !trimmedName.isEmpty else {
            alertMessage = "The fruit must have a name"
            showingAlert = true
            return
        }
        
        // Validar que no exista una fruta con el mismo nombre 
        let nameExists = store.fruits.contains { fruit in
            fruit.name.lowercased() == trimmedName.lowercased()
        }
        
        if nameExists {
            alertMessage = "A fruit with the name '\(trimmedName)' already exists"
            showingAlert = true
            return
        }
            
        // Si tot està correcte afegim nova fruita
        let fruitToAdd = Fruit(
            name: trimmedName,
            emoji: newFruit.emoji,
            description: newFruit.description
        )
        store.fruits.append(fruitToAdd)
        showingAddFruit = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FruitStore())
    }
}
