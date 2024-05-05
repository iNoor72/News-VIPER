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
    private var savedArticles: [ArticleCoreData] = []
    private var coreDataManager: CoreDataManagerProtocol!
    weak var presenter: NewsInteractorOutput?
    
    init(dependencies: NewsInteractorDependenciesProtocol) {
        self.networkService = dependencies.network
        self.coreDataManager = dependencies.coreDataManager
    }
    
    public func fetchCNNNews() {
        let endpoint = CNNNewsEndpoint.allNews
        networkService.fetch(endpoint: endpoint, expectedType: NewsResponse.self) { [weak self] result in
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
        var articleViewItem = ArticleViewItem(title: article.title ?? "", ImageURL: article.urlToImage ?? "")
        for savedArticle in savedArticles {
            if savedArticle.title == article.title {
                articleViewItem.isSaved = true
                break
            }
        }
        return articleViewItem
    }
    
    public func numOfArticles() -> Int {
        articles.count
    }
    
    public func saveAritcle(at index: Int) {
        coreDataManager.add(entityType: ArticleCoreData.self, mapper: ArticlesModelMapper(article: articles[index]))
    }
    
    public func fetchSavedArticles() {
        switch coreDataManager.fetch(request: ArticleCoreData.fetchRequest()) {
        case .success(let articles):
            self.savedArticles = articles
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

public struct ArticleViewItem {
    let title: String
    let ImageURL: String
    var isSaved: Bool = false
}
