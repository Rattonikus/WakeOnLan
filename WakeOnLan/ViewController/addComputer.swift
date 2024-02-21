//
//  AddCarListItemView.swift
//  MorningData
//
//  Created by Elkins, Cameron on 11/9/23.
//

import SwiftUI

struct addComputer: View
{
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storedComputers : ComputerItemStore
    @State private var name : String = ""
    @State private var ipAddy : String = ""
    @State private var macAddy: String = ""
    @State private var port : String = ""
    
    init (with make: String, having item : String)
    {
        _name = State(initialValue: make)
        _ipAddy = State(initialValue: item)
    }
    
    var body: some View
    {
        Form
        {
            Section("Add a computer")
            {
                InputField(hint: "Name", result: $name)
                InputField(hint: "Ip", result: $ipAddy)
                    .keyboardType(.numberPad)
                InputField(hint: "Mac Address", result: $macAddy)
                InputField(hint: "Port", result: $port)
                    .keyboardType(.numberPad)


            }
            if(!name.isEmpty && !ipAddy.isEmpty)
            {
                Button("Add me to list", action: storeComputers)
            }
        }
    }
    private func storeComputers() -> Void
    {
        let portInt = Int(port)
        let newComputerItem = ComputerItem(computerName: name, ipAddress: ipAddy, macAddress: macAddy, port: portInt!)
        storedComputers.computers.insert(newComputerItem, at: 0)
        dismiss()
    }
    
    
    
}

#Preview ("Add a car")
{
    addComputer(with: "", having: "")
}
