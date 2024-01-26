import Foundation
import UIKit
import SnapKit

class NewsView: UIView {
    
    let listOfNews = UITableView()
    private var newsArray: [NewsInfo] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        configureListOfNews()
    }
    
    func setNewsArray(newsArray: [NewsInfo]) {
        self.newsArray = newsArray
        listOfNews.reloadData()
    }
    
    private func configureListOfNews() {
        addSubview(listOfNews)
        
        listOfNews.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.bottom.equalTo(self)
        }
        
        listOfNews.delegate = self
        listOfNews.dataSource = self
        
        listOfNews.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
    }
}

extension NewsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listOfNews.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UITableViewCell()}

        cell.configureNewsCell(headline: newsArray[indexPath.row].headline, summary: newsArray[indexPath.row].summary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
