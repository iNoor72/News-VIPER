//
//  NewsInteractor.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

public final class NewsInteractor : NewsInteractorInput {
    
    private var networkService: NetworkServiceProtocol!
    private var articles: [Article] = []
    weak var presenter: NewsInteractorOutput?
    
    init(dependencies: NewsInteractorDependenciesProtocol) {
        self.networkService = dependencies.network
    }
    
    public func fetchCNNNews() {
        networkService.requestCNNNews { [weak self] result in
            switch result {
            case .success(let news):
                guard news.articles != nil else {
                    self?.presenter?.didFetchEmptyResponse()
                    return
                }
                self?.articles = news.articles ?? []
                self?.presenter?.didFetchArticles()
            case .failure(let error):
                self?.presenter?.failFetch(with: error)
            }
        }
    }
    
    
    public func articleViewItem(at index: Int) -> ArticleViewItem {
        let article = articles[index]
        let articleViewItem = ArticleViewItem(title: article.title ?? "", ImageURL: article.urlToImage ?? "")
        return articleViewItem
    }
    
    public func numOfArticles() -> Int {
        articles.count
    }
}

public struct ArticleViewItem {
    let title: String
    let ImageURL: String
}
