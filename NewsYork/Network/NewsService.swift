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
        fetchNews(from: urlString, completion: completion)
    }
    
    // MARK: - Article Search API
    func searchArticles(query: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        let urlString = "\(baseURL)/search/v2/articlesearch.json?q=\(query)&api-key=\(apiKey)"
        fetchNews(from: urlString, completion: completion)
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

// Model for the API response
struct NewsResponse: Decodable {
    let status: String
    let copyright: String
    let section: String
    let lastUpdated: String
    let numResults: Int
    let results: [NewsArticle]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright, section, results
        case lastUpdated = "last_updated"
        case numResults = "num_results"
    }
}

// Model for individual articles
struct NewsArticle: Decodable {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let itemType: String
    let updatedDate: String
    let createdDate: String
    let publishedDate: String
    let multimedia: [NewsMedia]?
    
    var imageUrl: String? {
        return multimedia?.first?.url
    }
    
    enum CodingKeys: String, CodingKey {
        case section, subsection, title, abstract, url, byline
        case itemType = "item_type"
        case updatedDate = "updated_date"
        case createdDate = "created_date"
        case publishedDate = "published_date"
        case multimedia
    }
}

// Model for multimedia (images)
struct NewsMedia: Decodable {
    let url: String
    let format: String
    let height: Int
    let width: Int
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
}
