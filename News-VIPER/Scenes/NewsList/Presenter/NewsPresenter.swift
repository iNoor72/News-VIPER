//
//  NewsPresenter.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

final class NewsPresenter: NewsPresenterInput {
    
    private var interactor: NewsInteractorInput!
    private var articles: [Article] = []
    private var view: NewsPresenterOutput!
    
    init(interactor: NewsInteractorInput, view: NewsPresenterOutput) {
        self.interactor = interactor
        self.view = view
    }
    
    func fetchData() {
        self.interactor.fetchCNNNews()
    }

    func populateArticles(with index: Int) -> ArticleViewItem {
        return interactor.articleViewItem(article: self.articles[index])
    }
    
    func numOfArticles() -> Int {
        articles.count
    }
}

extension NewsPresenter: NewsInteractorOutput {
    func didFetchArticles(articles: [Article]) {
        self.articles = articles
        view.reloadTableView()
    }
    
    func didFetchEmptyResponse() {
        // show no articles
    }
    
    func failFetch(with error: any Error) {
        // show error with error message
    }
    
}
