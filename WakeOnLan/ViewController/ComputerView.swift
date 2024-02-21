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
            Image("computerPlace")
            VStack
            {
                Text(rowComputer.computerName)
                    .bold()
                Text(rowComputer.ipAddress)
                    .font(.subheadline)
            }
            
                
                
        }
        
    }
}

#Preview {
    ComputerView(rowComputer: demoComputer)
}
