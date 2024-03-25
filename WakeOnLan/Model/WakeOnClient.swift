//
//  WakeOnClient.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 3/25/24.
//

import Foundation

struct WakeOnClient
{
    
    var testURL = ""
    var serverResponse = ""
    public func testComp(computer: ComputerItem) -> String
    {
        let stringPort = String(computer.appPort)
        print(computer.computerName)
        return(computer.computerName + " " + "http://" + computer.ipAddress + ":" + stringPort + "/WoL")
    }
    
    public mutating func buildRequest(ip: String, port: Int, computer: ComputerItem, reqBody: String)
    {
        let stringPort = String(computer.appPort)
        guard
            let url = URL(string: "http://" + computer.ipAddress + ":" + stringPort + "/WoL")
        else
        {
            //errorText = "Invalid server!"
            print("Invalid URL")
            return
        }
        
        let body = "Client: \(reqBody)"
        var savedResponse = ""
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
                if let responseString = String(data: data, encoding: .utf8)
                {
                    DispatchQueue.main.async
                    {
                        savedResponse = responseString
                        //store responseString into a publicly accessible variable here
                    }
                    
                }
            }
            else
            {
                print("server error")
            }
        }
        .resume()
        serverResponse = savedResponse
    }
    }
    
    
