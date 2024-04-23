//
//  NewsPresenterOutput.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation

// This is what the presenter see in the view.
protocol NewsPresenterOutput: AnyObject {
    func reloadTableView()
}
