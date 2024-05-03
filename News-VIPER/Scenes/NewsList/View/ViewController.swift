//
//  ViewController.swift
//  News-VIPER
//
//  Created by Noor El-Din Walid on 20/04/2024.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var present: NewsPresenterInput?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: AppStrings.newsTableViewCellIdenetifier, bundle: nil), forCellReuseIdentifier: AppStrings.newsTableViewCellIdenetifier)
        present?.fetchData()
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
        return present?.numOfArticles() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppStrings.newsTableViewCellIdenetifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        guard let article = present?.populateArticles(with: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(with: article)
        cell.newsImageView.sd_setImage(with: URL(string: article.ImageURL), placeholderImage: UIImage(named: "placeholder-image.png"))
        cell.favouriteButtonTapped = { [weak self] cell in
            guard let index = self?.tableView.indexPath(for: cell) else { return }
            self?.present?.favouriteButtonToggle(index: index.row)
            self?.tableView.reloadData()
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

