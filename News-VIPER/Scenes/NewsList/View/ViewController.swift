//
//  ViewController.swift
//  News-VIPER
//
//  Created by Noor El-Din Walid on 20/04/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var present: NewsPresenterInput!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        present.fetchData()
    }
}
extension ViewController: NewsPresenterOutput {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return present.numOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let article = present.populateArticles(with: indexPath.row)
        cell.textLabel?.text = article.title
        return cell
    }
    
}

