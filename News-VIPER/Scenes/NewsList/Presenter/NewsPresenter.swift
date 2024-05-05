//
//  NewsPresenter.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

final class NewsPresenter: NewsPresenterInput {
    
    private var router: NewsRouterInput
    private var interactor: NewsInteractorInput
    weak var view: NewsPresenterOutput?
    
    init(dependencies: NewsPresenterDependenciesProtocol) {
        self.interactor = dependencies.interactor
        self.router = dependencies.router
    }
    
    func fetchData() {
        self.interactor.fetchCNNNews()
        self.interactor.fetchSavedArticles()
    }

    func populateArticles(with index: Int) -> ArticleViewItem {
        interactor.articleViewItem(at: index)
    }
    
    func numOfArticles() -> Int {
        interactor.numOfArticles()
    }
    
    func favouriteButtonToggle(index: Int) {
        interactor.saveAritcle(at: index)
        interactor.fetchSavedArticles()
    }
    
    func fetchAllSavedArticles() {
        interactor.fetchSavedArticles()
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
