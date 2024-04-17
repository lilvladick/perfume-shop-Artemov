import Foundation

class NetworkManager {
    
    func sendGetRequest(urlString: String, parameters: [String: Any], completion: @escaping (Data?, Error?) -> Void) {
        var urlComponents = URLComponents(string: urlString)
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NSError(domain: "Server Error", code: -1, userInfo: nil))
                return
            }
            
            completion(data, nil)
        }
        
        task.resume()
    }
}
