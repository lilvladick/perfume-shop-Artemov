import Foundation

class NetworkManager {
    
    func sendPostRequest(urlString: String, parameters: [String: Any], completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            completion(nil, error)
            return
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NSError(domain: "Server Error", code: -1, userInfo: nil))
                return
            }
            
            print("HTTP Response Status code: \(httpResponse.statusCode)")
            
            completion(data, nil)
        }
        
        task.resume()
    }
}
