import Foundation
import UIKit
import SnapKit

class ListOfCompaniesView: UIView {
    
    let listOfCompanies = UITableView()
    private let tickersList = ["TSLA", "APPN", "BAC", "MA", "MSFT", "AMZN", "MA", "AAPL", "APPF", "GOOGL"]
    private var commonInfos: [CommonInfo] = []
    private var commonInfosBuffer: [CommonInfo] = []
    private let service = NetworkService()
    var tapOnCell: ((CommonInfo)->())? = nil
    var scrollDown: ((Double)->())? = nil
    private let favService = FavouriteService()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configureListOfCompanies()
        getListOfStoks()
    }
    
    func sync() {
        updateList(actualCommonInfos: commonInfos)
    }
    
    func showAllStocks() {
        updateList(actualCommonInfos: commonInfosBuffer)
    }
    
    func showFavouritesOnly(tapOnTitle: Bool) {
        if tapOnTitle == true {
            commonInfosBuffer = commonInfos
        }
        let oldArray = commonInfos
        let arrayOfFavourites = self.favService.getFavourits()
        commonInfos.removeAll()
        
        for element in oldArray {
            if arrayOfFavourites.contains(element.companyInfo.ticker) {
                var element2 = element
                element2.isFavourite = true
                self.commonInfos.append(element2)
            }
        }
        self.listOfCompanies.reloadData()
    }
    
    private func updateList(actualCommonInfos: [CommonInfo]) {
        let oldArray = actualCommonInfos
        let arrayOfFavourites = self.favService.getFavourits()
        commonInfos.removeAll()
        
        for element in oldArray {
            if arrayOfFavourites.contains(element.companyInfo.ticker) {
                var element2 = element
                element2.isFavourite = true
                self.commonInfos.append(element2)
            } else {
                var element2 = element
                element2.isFavourite = false
                self.commonInfos.append(element2)
            }
        }
        self.listOfCompanies.reloadData()
    }
    
    private func getListOfStoks() {
        service.fetchCommonInfos(tickers: tickersList) { array in
            self.commonInfos = array
            self.sync()
        }
    }
    
    private func configureListOfCompanies() {
        addSubview(listOfCompanies)
        
        listOfCompanies.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(self).inset(16)
        }
        
        listOfCompanies.delegate = self
        listOfCompanies.dataSource = self
        
        listOfCompanies.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        listOfCompanies.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 1000)
        listOfCompanies.showsVerticalScrollIndicator = false
    }
}

extension ListOfCompaniesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commonInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listOfCompanies.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else { return UITableViewCell() }
        
        let isColored = indexPath.row % 2 == 0

        cell.configureCell(isColored: isColored, ticker: tickersList[indexPath.row], commonInfo: commonInfos[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 90
        }
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapOnCell?(commonInfos[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y < 95 && scrollView.contentOffset.y >= 0 {
            scrollDown?(scrollView.contentOffset.y)
        }
        
        if scrollView.contentOffset.y > 95 {
            scrollDown?(95)
        }
        
        if scrollView.contentOffset.y < 0 {
            scrollDown?(0)
        }
    }
}
