//
//  ManageComputer.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 4/16/24.
//

import SwiftUI

struct ManageComputer: View 
{
    @State private var name: String
    
    init (computer: ComputerItem? = nil)
    {
        _name = State(initialValue: computer?.computerName ?? "")
    }
    
    var body: some View
    {
        VStack
        {
            HStack(alignment: .top)
            {
                Text(name)
                    .bold()
                    .font(.largeTitle)
                    .padding()
                Image("computerPlace")
                    .padding()
            }
            Spacer()
            Form
            {
                Text("Turn off")
                Text("Turn on")
                Text("Sleep")
            }
            Spacer()
        }
    }
    
    
}

#Preview 
{
    ManageComputer(computer: demoComputer)
}
