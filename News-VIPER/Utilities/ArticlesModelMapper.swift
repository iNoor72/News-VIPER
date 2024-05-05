//
//  ArticlesModelMapper.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 01/05/2024.
//

import Foundation
import CoreData

struct ArticlesModelMapper: CoreDataModelMapper {
    
    let article : Article
    
    init(article: Article) {
        self.article = article
    }
    
    func copyIn<U: NSManagedObject> (entity: U) {
        guard let articleEntity = entity as? ArticleCoreData else {
          return
        }
        articleEntity.title = article.title
        articleEntity.author = article.author
        articleEntity.content = article.content
        articleEntity.imageURl = article.urlToImage
        articleEntity.publishedAt = article.publishedAt
        articleEntity.type = article.description
        articleEntity.url = article.url
    }
    
    
}
