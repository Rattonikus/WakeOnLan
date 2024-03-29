//
//  testView.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 3/25/24.
//

import SwiftUI

struct testView: View
{
    var testerDo : WakeOnClient
    @State private var inputText = ""
    @State private var serverResponse = "Server Response Here"
    
    var body: some View
    {
        Text(testerDo.testComp(computer: demoComputer))
        TextField("Enter text", text: $inputText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        Button("Send to Server") {
            sendToServer()
        }
        .padding()

        Text(serverResponse)
            .padding()
        
    }
    
    func sendToServer()
    {
        testerDo.buildRequest(computer: demoComputer, reqBody: "Request body")
        {
            response in
            if let serverResponse = response 
            {
                print("Server Response: \(serverResponse)")
                self.serverResponse = serverResponse
            }
            else
            {
                print("Server request failed")
            }
        }
    }
}

#Preview {
    testView(testerDo: WakeOnClient())
}
