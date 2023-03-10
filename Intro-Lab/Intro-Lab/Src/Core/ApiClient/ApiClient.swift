

import Foundation

final class ApiClient {
    
    func request(path: String,
                 method: String,
                 parameters: [String:String]?,
                 completion: @escaping (Result<Data, NError>) -> Void) {
        
        guard var components = URLComponents(string: path) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if method == "GET", let parameters = parameters {
            components.queryItems = parameters.map({ (key, value) in
                URLQueryItem(name: key, value: value)
            })
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
#if DEBUG
                print(error)
#endif
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}


