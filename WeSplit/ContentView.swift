//
//  ContentView.swift
//  WeSplit
//
//  Created by Baptiste Cadoux on 31/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        guard let peopleCount = Double(numberOfPeople) else {
            return 0
        }

        let grandTotal = getGrandTotal()
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var totalAmount: Double {
        guard let peopleCount = Double(numberOfPeople),
              peopleCount > 0 else {
            return 0
        }
        return getGrandTotal()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .primary)
                }

                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .primary)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }

    private func getGrandTotal() -> Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
