//
//  ComputerItem.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/19/24.
//

import Foundation

struct ComputerItem : Codable
{
    var computerName : String
    var ipAddress : String
    var macAddress : String
    var port : Int
    var appPort : Int
}
