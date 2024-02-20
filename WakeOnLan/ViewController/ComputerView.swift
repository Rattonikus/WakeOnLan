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
        VStack
        {
            Image("computerPlace")
            HStack
            {
                Text(rowComputer.ComputerName)
                    .bold()
            }
            Text(rowComputer.ipAddress)
                .font(.subheadline)
                
                
        }
        
    }
}

#Preview {
    ComputerView(rowComputer: demoComputer)
}
