//
//  WakeOnClient.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 3/25/24.
//

import Foundation

class WakeOnClient
{
    
    var testURL = ""
    var serverResponse = ""
    public func testComp(computer: ComputerItem) -> String
    {
        let stringPort = String(computer.appPort)
        print(computer.computerName)
        return(computer.computerName + " " + "http://" + computer.ipAddress + ":" + stringPort + "/WoL")
    }
    
    public func buildRequest(computer: ComputerItem, reqBody: String, completion: @escaping (String?) -> Void)
    {
        let stringPort = String(computer.appPort)
        guard
            let url = URL(string: "http://" + computer.ipAddress + ":" + stringPort + "/WoL")
        else
        {
            //errorText = "Invalid server!"
            return
        }

        let body = "Client: \(reqBody)"
        var clientRequest = URLRequest(url: url)
        clientRequest.httpMethod = "POST"
        clientRequest.httpBody = body.data(using: .utf8)

        URLSession.shared.dataTask(with: clientRequest)
        {
            data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse, error == nil
            else
            {
                print("error")
                return
            }
            if response.statusCode == 200
            {
                self.serverResponse = "hi"
                if let responseString = String(data: data, encoding: .utf8)
                {
                    DispatchQueue.main.async
                    {
                        print(responseString)
                        completion(responseString)
                    }
                }
            }
            else
            {
                print("server error")
            }
        }
        .resume()
    }
}
    
    
