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
    @State var showAddComputer : Bool = false

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
                $0.macAddress.lowercased().contains(searchedText.lowercased())
                ||
                String($0.port) == searchedText
            }
        }
    }
    
    
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                Section("", isExpanded: $canShow)
                {
                    ForEach(filteredComputerListResult.indices, id: \.self)
                    {
                        row in
                        ComputerView(rowComputer: filteredComputerListResult[row])
                    }
                    .onDelete(perform: removeComputerItems)
                    .swipeActions(edge: .leading, allowsFullSwipe: false)
                    {
                        Button("", systemImage: "edit", action: {print("hi")})
                    }
                }
            }
            .navigationTitle("Computers")
            .listStyle(GroupedListStyle())
            .background(Color.blue)
            .toolbar
            {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button (action: {self.showAddComputer.toggle()})
                    {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddComputer)
            {
                addComputer(with: "", having: "")
        
            }
        }
    }
    
    private func removeComputerItems(at offsets : IndexSet) -> Void
    {
        computerData.computers.remove(atOffsets: offsets)
    }
       
}

#Preview {
    ContentView()
        .environmentObject(ComputerItemStore(computers: loadJSON(from: "computer") as! [ComputerItem]))
}
