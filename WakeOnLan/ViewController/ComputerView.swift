//
//  ComputerView.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import SwiftUI
struct ComputerView: View
{
    var rowComputer : ComputerItem
    
    
    var body: some View
    {
        
        HStack
        {
            Button { doThing() } label: { Image("computerPlace")}
            VStack
            {
                Text(rowComputer.computerName)
                    .bold()
                Text(rowComputer.ipAddress)
                    .font(.subheadline)
            }
            
                
                
        }
        
    }
    
  
    
    private func doThing() 
    {
        Awake.target(device: Awake.Device(MAC: rowComputer.macAddress, BroadcastAddr: rowComputer.ipAddress, Port: UInt16(rowComputer.port)))
       
    }
    
}

#Preview {
    ComputerView(rowComputer: demoComputer)
}
