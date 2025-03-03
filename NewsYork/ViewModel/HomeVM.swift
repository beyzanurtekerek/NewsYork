//
//  HomeVM.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 27.02.2025.
//

import Foundation

class HomeVM {
    
    private let newsService = NewsService()
    
    var breakingNewsArticles: [NewsArticle] = []  // Breaking News için
    var recommendedArticles: [NewsArticle] = []   // Recommendation için
    
    var onDataFetched: (() -> Void)?
    var onDataError: ((Error) -> Void)?
    
    func fetchBreakingNews() {
        newsService.fetchTopStories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.breakingNewsArticles = Array(articles.prefix(10))  // İlk 10 haberi Breaking News'te kullan
                    self?.recommendedArticles = Array(articles.dropFirst(10)) // İlk 10 haber hariç, geri kalanlar Recommendation kısmında
                    self?.onDataFetched?()
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.onDataError?(error)
                    }
                }
            }
        }
    }
}



