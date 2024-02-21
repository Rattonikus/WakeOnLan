//
//  WakeOnLanApp.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import SwiftUI

@main
struct WakeOnLanApp: App 
{
    var body: some Scene
    {
        @StateObject var storedComputers = ComputerItemStore(computers: loadJSON(from: "computer") )

        WindowGroup
        {
            ContentView()
                .environmentObject(storedComputers)

        }
    }
}
