//
//  ContentView.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import SwiftUI

struct MainView: View 
{
    
    @EnvironmentObject var computerData : ComputerItemStore
    @State private var searchedText : String = ""
    @State var canShow : Bool = true
    @State var showAddComputer : Bool = false
    @State var showEditComputer : Bool = false
    @State var editIndex : Int = 0
    var webSocks = WebSockets()

    

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
        if (filteredComputerListResult.isEmpty)
        {
            VStack
            {
                Text("No computers added")
                NavigationLink ("Add one now?", destination: SocketTests())
                    .sheet(isPresented: $showAddComputer)
                    {
                        addComputer(computer: demoComputer, maxIndex: filteredComputerListResult.count)
                    }
                
                Button(action: conn, label: {
                    Text("Connect")})
                Button(action: sendText, label: {
                    Text("Send")})
                Button(action: endIt, label: {
                    Text("End")})
            }
        }
        else
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
                                .swipeActions(edge: .leading, allowsFullSwipe: false)
                                {
                                    Button("", systemImage: "pencil", action: {editIndex = row; showEditComputer.toggle()})
                                }
                                
                        }
                        .onDelete(perform: removeComputerItems)
                        
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
                    addComputer(computer: demoComputer, maxIndex: filteredComputerListResult.count)
                }
                .sheet(isPresented: $showEditComputer) {
                    editComputer(computer: filteredComputerListResult[editIndex], index: editIndex)
                }
            }
        }
    }
    
    private func removeComputerItems(at offsets : IndexSet) -> Void
    {
        computerData.computers.remove(atOffsets: offsets)
    }
    func conn()
     {
         webSocks.startSocks()
     }
     
     func sendText()
     {
         webSocks.writeText()
     }
     
     func endIt()
     {
         webSocks.disconnect()
     }
       
}

#Preview {
    MainView()
        .environmentObject(ComputerItemStore(computers: loadJSON(from: "computer") as! [ComputerItem]))
}
