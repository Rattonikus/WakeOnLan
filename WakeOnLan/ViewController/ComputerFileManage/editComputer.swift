//
//  AddCarListItemView.swift
//  MorningData
//
//  Created by Elkins, Cameron on 11/9/23.
//

import SwiftUI

struct editComputer: View
{
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storedComputers : ComputerItemStore
    @State private var name : String = ""
    @State private var ipAddy : String = ""
    @State private var macAddy: String = ""
    @State private var port : String = ""
    @State private var appPort : String = ""
    @State private var editIndex : Int = 0
    
    init (computer: ComputerItem? = nil, index: Int) {
        _name = State(initialValue: computer?.computerName ?? "")
        _ipAddy = State(initialValue: computer?.ipAddress ?? "")
        _macAddy = State(initialValue: computer?.macAddress ?? "")
        _port = State(initialValue: computer != nil ? String(computer!.port) : "")
        _appPort = State(initialValue: computer != nil ? String(computer!.appPort) : "")
        _editIndex = State(initialValue: index)
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
                InputField(hint: "AppPort", result: $appPort)
                    .keyboardType(.numberPad)


            }
            if(!name.isEmpty && !ipAddy.isEmpty)
            {
                Button("Add me to list", action: storeComputers)
            }
        }
    }
    
    private func storeComputers() {
        let portInt = Int(port) ?? 0
        let appPort = Int(appPort) ?? 0
        let newComputerItem = ComputerItem(computerName: name, ipAddress: ipAddy, macAddress: macAddy, port: portInt, appPort: appPort)
        if editIndex >= 0 && editIndex < storedComputers.computers.count {
            storedComputers.computers[editIndex] = newComputerItem
        } else {
            storedComputers.computers.insert(newComputerItem, at: editIndex)
        }
        dismiss()
    }
    
    
    
    
    
}

#Preview ("Add a car")
{
    editComputer(computer: demoComputer, index: 0)
}
