//
//  NewsViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit

final class NewsViewController: UIViewController {
    @IBOutlet private weak var newsTableView: UITableView!

    private var news = [News]()
    private var refreshControl = RefreshManager.shared.setupRefreshControl(#selector(refresh(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        getNews()
        newsTableView.refreshControl = refreshControl
    }

    private func getNews() {
        let queue = DispatchQueue(label: "getNewsQueue", qos: .utility)
        queue.async { [unowned self] in
            APIManager.shared.fetchNews(completion: { (news: [News]) in
                self.news = news
                DispatchQueue.main.async { [unowned self] in
                    self.newsTableView.reloadData()
                }
            }, errorHandler: {
                self.popUpErrorAlert(message: "Error fetching News API")
            })
        }
    }

    private func registerTableView() {
        newsTableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "newsCellId")
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }

    @objc 
    private func refresh(_ sender: AnyObject) {
        getNews()
        refreshControl.endRefreshing()
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCellId", for: indexPath)
            as? NewsViewCell {
            cell.configNews(thisNews: news[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
