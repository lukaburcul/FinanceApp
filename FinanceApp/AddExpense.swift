//
//  AddExpense.swift
//  FinanceApp
//
//  Created by user on 23.01.2023..
//

import SwiftUI


struct AddExpense: View {
    @ObservedObject var expenses : Expenses
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = ""
    @State private var amount = 0.0
    
    let types = ["Drinking","Eating Out", "Fuel" ,"Groceries","Health", "Transport", "Phone", "Other"]
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    TextField("Name the expense", text: $name)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            
                    Section{
                            Picker("Type of expense:", selection: $type){
                                ForEach(types, id: \.self){
                                    Text($0)
                                }
                            
                            }.pickerStyle(.automatic)
                            .cornerRadius(5)

                        
                    }
                    Section{
                        TextField("Amount", value: $amount, format: .currency(code: "EUR"))
                            .foregroundColor(.teal)
                            .textFieldStyle(.plain)
                            .keyboardType(.decimalPad)
                            
                    }
                }
                .navigationBarTitle("Add your expense", displayMode: .inline)
                .toolbar{
                    Button("Save"){
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()   
                    }
                }
            }
        }
    }
}
    
    struct AddExpense_Previews: PreviewProvider {
        static var previews: some View {
            AddExpense(expenses: Expenses())
        }
    }

