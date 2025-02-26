//
//  NewsService.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 26.02.2025.
//

import Foundation

struct NewsService {
    
    private let apiKey = Config.apiKey
    private let baseURL = "https://api.nytimes.com/svc"
    
    // MARK: - Top Stories API
    func fetchTopStories(completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        let urlString = "\(baseURL)/topstories/v2/home.json?api-key=\(apiKey)"
        
    }
    
    // MARK: - Article Search API
    func searchArticles(query: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        let urlString = "\(baseURL)/search/v2/articlesearch.json?q=\(query)&api-key=\(apiKey)"
    }
    
    // MARK: - Generic Fetch Function
    private func fetchNews(from urlString: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data returned", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}

// MARK: - Decodable Models
struct NewsResponse: Decodable {
    let results: [NewsArticle]
}

struct NewsArticle: Decodable {
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let publishedDate: String
    let multimedia: [NewsMedia]?
    
    var imageUrl: String? {
        return multimedia?.first?.url
    }
}

struct NewsMedia: Decodable {
    let url: String
}
