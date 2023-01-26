//
//  ContentView.swift
//  FinanceApp
//
//  Created by user on 23.01.2023..
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
}


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}


struct ContentView: View {
    @State private var showAddExpense = false
    @StateObject var expenses = Expenses()
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack{
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "EUR"))
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("Your Expenses")
            .toolbar{
                Button{
                    showAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddExpense){
                AddExpense(expenses: expenses)
            }
        }
    }

    func removeItem (at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}
    
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


