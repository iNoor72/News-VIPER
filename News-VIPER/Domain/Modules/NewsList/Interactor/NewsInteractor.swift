//
//  NewsInteractor.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

final class NewsInteractor : NewsInteractorInput {
    
    private var networkService: NetworkServiceProtocol!
    private var articles: [Article] = []
    var presenter: NewsInteractorOutput!
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCNNNews() {
        networkService.requestCNNNews { [weak self] result in
            switch result {
            case .success(let news):
                guard let articles = news.articles else {
                    self?.presenter.didFetchEmptyResponse()
                    return
                }
                self?.presenter.didFetchArticles(articles: articles)
            case .failure(let error):
                self?.presenter.failFetch(with: error)
            }
        }
    }
    
    
    func articleViewItem(article: Article) -> ArticleViewItem {
        
        let articleViewItem = ArticleViewItem(title: article.title ?? "", ImageURL: article.urlToImage ?? "")
        return articleViewItem
    }
}

struct ArticleViewItem {
    let title: String
    let ImageURL: String
}
