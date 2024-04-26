//
//  NewsListFactory.swift
//  News-VIPER
//
//  Created by Noor El-Din Walid on 26/04/2024.
//

import UIKit

protocol NewsListFactoryProtocol {
    func makeView() -> UIViewController
}

final class NewsListFactory: NewsListFactoryProtocol {
    
    func makeView() -> UIViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let newsRouter = NewsRouter()
        
        let interactorDependencies = NewsInteractorDependencies(network: NetworkService())
        let newInteractor = NewsInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = NewsPresenterDependencies(
            interactor: newInteractor,
            router: newsRouter
        )
        let newsPresenter = NewsPresenter(dependencies: presenterDependencies)
        
        newsPresenter.view = viewController
        newInteractor.presenter = newsPresenter
        viewController.present = newsPresenter
        
        return viewController
    }
}

public protocol NewsInteractorDependenciesProtocol {
    var network: NetworkService { get }
}

struct NewsInteractorDependencies: NewsInteractorDependenciesProtocol {
    let network: NetworkService
}

public protocol NewsPresenterDependenciesProtocol {
    var interactor: NewsInteractorInput { get }
    var router: NewsRouterInput { get }
}

struct NewsPresenterDependencies: NewsPresenterDependenciesProtocol {
    let interactor: NewsInteractorInput
    let router: NewsRouterInput
}
