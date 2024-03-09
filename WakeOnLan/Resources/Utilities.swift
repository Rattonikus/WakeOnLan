//
//  Utilities.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import Foundation

let demoComputer : ComputerItem = ComputerItem(computerName: "Example Name", ipAddress: "127.0.0.1", macAddress: "00:B0:D0:63:C2:26", port: 26)

func loadJSON (from file : String) -> [ComputerItem]
{
    do
    {
        if let dataSourceURL = Bundle.main.url(forResource: file, withExtension: "json")
        {
            let data = try! Data(contentsOf: dataSourceURL)
            let decoder = JSONDecoder()
            
            let results = try decoder.decode([ComputerItem].self, from: data)
            return results
        }
    }
    catch
    {
        print(error.localizedDescription)
    }
    return [] //badbadbad
    
}

