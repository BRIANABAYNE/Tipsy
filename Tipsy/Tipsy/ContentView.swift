//
//  ContentView.swift
//  Tipsy
//
//  Created by Briana Bayne on 12/15/23.
//

import SwiftUI

struct ContentView: View {
    // @State - property wrapper - will automatically look for state changes
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
   
    // computed property
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
            Form {
                Section { // TextField inside of Form - Parameter 1. Place Holder text 2. Two way binding that update the property 3. Controls how the text looks on the screen (format)
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    // Will show the keypad but only the numbers, To make it easier on the user
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
                // header - title
                Section("How much do you want to tip?") {
        
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section { // ?? Nil Coal if there isn't a current currency
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            // title
            .navigationTitle("We Split")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
