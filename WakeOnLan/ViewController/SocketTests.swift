//
//  SocketTests.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 3/12/24.
//

import SwiftUI

struct SocketTests: View 
{
    var webSocks = WebSockets()
    var body: some View
    {
        Text("send a web socket")
        
        Button(action: conn, label: {
            Text("Connect")})
        Button(action: sendText, label: {
            Text("Send")})
        Button(action: endIt, label: {
            Text("End")})
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
    SocketTests()
}
