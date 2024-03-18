import Foundation
import Starscream

class WebSockets: WebSocketDelegate
{
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    let cafe: Data? = "Café".data(using: .utf8)
    
    func startSocks()
    {
        var request = URLRequest(url: URL(string: "ws://localhost:3621")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        print("Success")
      //  socket.write(string: "HI")
        print("hello")
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        case .peerClosed:
            break
        }
    }
    
    func handleError(_ error: Error?) {
            if let e = error as? WSError {
                print("websocket encountered an error: \(e.message)")
            } else if let e = error {
                print("websocket encountered an error: \(e.localizedDescription)")
            } else {
                print("websocket encountered an error")
            }
        }
    
    
    func writeText()
    {
        socket.write(string: "TEST")
    }
    
    func disconnect()
    {
        if isConnected
        {
            socket.disconnect()
            }
        else
        {
                socket.connect()
            }
        }
    
}
