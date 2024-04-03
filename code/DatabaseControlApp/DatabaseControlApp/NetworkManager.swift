import Foundation

class NetworkManager {
    
    func getData(postData: Data) {
        guard let url = URL(string: "82.179.140.18:44666/get_data") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            if let response = response as? HTTPURLResponse {
                print(response)
            }
            print(String(data: data, encoding: .utf8) ?? "No data received")
        }.resume()
    }
}
