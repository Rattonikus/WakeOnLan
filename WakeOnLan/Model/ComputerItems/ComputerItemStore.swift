//
//  ComputerItemStore.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import Foundation
import Combine
class ComputerItemStore: ObservableObject
{
    @Published var computers: [ComputerItem]
    {
        didSet
        {
            let encoder = JSONEncoder()
            if let encodedComputers = try? encoder.encode(computers)
            {
                UserDefaults.standard.set(encodedComputers, forKey: "Saved Computers")
            }
        }
    }
    init(computers: [ComputerItem] = [])
    {
        if let storedOnDevice = UserDefaults.standard.data(forKey: "Saved Computers")
        {
            let decoder = JSONDecoder()
            if let savedComputers = try? decoder.decode([ComputerItem].self, from: storedOnDevice)
            {
                if (computers.count < 20)
                {
                    self.computers = savedComputers
                    return
                }
            }
        }
  
        self.computers = computers
    }
}

