//
//  NewsPresenter.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

final class NewsPresenter: NewsPresenterInput {
    
    private var interactor: NewsInteractorInput!
    weak var view: NewsPresenterOutput?
    
    init(interactor: NewsInteractorInput) {
        self.interactor = interactor
    }
    
    func fetchData() {
        self.interactor.fetchCNNNews()
    }

    func populateArticles(with index: Int) -> ArticleViewItem {
        interactor.articleViewItem(at: index)
    }
    
    func numOfArticles() -> Int {
        interactor.numOfArticles()
    }
}

extension NewsPresenter: NewsInteractorOutput {
    func didFetchArticles() {
        view?.reloadTableView()
    }
    
    func didFetchEmptyResponse() {
        // show no articles
    }
    
    func failFetch(with error: any Error) {
        // show error with error message
    }
    
}
