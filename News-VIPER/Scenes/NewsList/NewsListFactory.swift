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
        let viewController = UIStoryboard(name: AppStrings.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: AppStrings.viewControllerIdentifier) as! ViewController
        
        let newsRouter = NewsRouter()
        
        let interactorDependencies = NewsInteractorDependencies(network: NetworkService(), coreDataManager: CoreDataManager.shared)
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

protocol NewsInteractorDependenciesProtocol {
    var network: NetworkService { get }
    var coreDataManager: CoreDataManagerProtocol { get }
}

struct NewsInteractorDependencies: NewsInteractorDependenciesProtocol {
    let network: NetworkService
    let coreDataManager: CoreDataManagerProtocol
}

public protocol NewsPresenterDependenciesProtocol {
    var interactor: NewsInteractorInput { get }
    var router: NewsRouterInput { get }
}

struct NewsPresenterDependencies: NewsPresenterDependenciesProtocol {
    let interactor: NewsInteractorInput
    let router: NewsRouterInput
}
