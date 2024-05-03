//
//  NewsInteractorInput.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

// this is what the presenter see in interactor
public protocol NewsInteractorInput {
    func fetchCNNNews() 
    func articleViewItem(at index: Int) -> ArticleViewItem
    func numOfArticles() -> Int
    func saveAritcle(at index: Int)
    func fetchSavedArticles()
}
