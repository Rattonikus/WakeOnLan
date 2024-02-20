//
//  ContentView.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import SwiftUI

struct ContentView: View 
{
    @EnvironmentObject var computerData : ComputerItemStore
    @State private var searchedText : String = ""
    @State var canShow : Bool = true

    private var filteredComputerListResult : [ComputerItem]
    {
        if(searchedText.isEmpty)
        {
            return computerData.computers
        }
        else
        {
            return computerData.computers.filter
            {
                $0.computerName.lowercased().contains(searchedText.lowercased())
                ||
                $0.ipAddress.lowercased().contains(searchedText.lowercased())
                ||
                String($0.port) == searchedText
            }
        }
        
    }
    
    var body: some View
    {
        NavigationStack
        {
            VStack()
            {
                
                
                List
                {
                    
                    Section("Computers", isExpanded: $canShow)
                    {
                        ForEach(filteredComputerListResult.indices, id: \.self)
                        {
                            row in
                            
                            ComputerView(rowComputer: filteredComputerListResult[row])
                        }
                    }
                }
            }
        .padding()
        .navigationTitle("Computers")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ComputerItemStore(computers: loadJSON(from: "savedComputers") as! [ComputerItem]))
}
