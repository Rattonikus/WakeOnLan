//
//  WakeOnClient.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 3/25/24.
//

import Foundation

struct WakeOnClient
{

    public func testComp(computerItem: ComputerItem) -> String
    {
        print(computerItem.computerName)
        return(computerItem.computerName)
    }
    
    public mutating func buildRequest(ip: String, port: Int)
    {
        var stringPort: String = String(port)
        guard
            let url = URL(string: "http://" + ip + ":" + stringPort + "/WoL")
        else
        {
           //errorText = "Invalid server!"
           return
        }
    }
    

    
}
