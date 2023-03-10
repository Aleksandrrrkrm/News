

import Foundation

class NewsNetworkManager {
    
    let apiClient = ApiClient()
    static let shared = NewsNetworkManager()
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    func getArticles(currentPage: String, completion: @escaping (Result<NewsEntity, NError>) -> Void) {
        
        let parameters = [
            "country" : "ru",
            "pageSize" : "20",
            "page" : currentPage,
            "apiKey" : "9a0d581804c249c992f61085e46b83d8"
        ]
        
        apiClient.request(path: baseURL, method: "GET", parameters: parameters) { result in
            
            switch result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.locale = Locale(identifier: "en_AU")
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let news: NewsEntity = try decoder.decode(NewsEntity.self, from: data)
                    completion(.success(news))
                } catch let error {
#if DEBUG
                print(error)
#endif
                    completion(.failure(.invalidJson))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
