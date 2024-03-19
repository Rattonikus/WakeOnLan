import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var serverResponse = ""

    var body: some View {
        VStack {
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
        .padding()
    }

    func sendToServer() {
        guard let url = URL(string: "http://localhost:8000/print") else {
            print("Invalid URL")
            return
        }

        let body = "text=\(inputText)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        
       

      /*  URLSession.shared.dataTask(with: request)
       {
            data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if response.statusCode == 200 {
                if let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.serverResponse = responseString
                    }
                }
            } else {
                print("Server returned status code: \(response.statusCode)")
            }
        }*/
            //.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
