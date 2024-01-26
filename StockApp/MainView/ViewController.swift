import Foundation
import UIKit
import SnapKit

class ViewController: UIViewController {

    private let search = SearchView()
    private let titles = TitlesForListView()
    private let list = ListOfCompaniesView()
    private let suggests = SuggestsOnSearch()
    private var showFavouriteOnly: Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureSearch()
        configureTitles()
        configureList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if showFavouriteOnly == nil {
            list.sync()
        } else if showFavouriteOnly == false {
            list.showAllStocks()
        } else {
            list.showFavouritesOnly(tapOnTitle: false)
        }
    }
    
    private func configureSearch() {
        view.addSubview(search)
        
        search.snp.makeConstraints { make in
            make.top.right.left.equalTo(view)
            make.height.equalTo(140)
        }
        
        search.returnBack = {
            self.titles.isHidden = false
            self.list.isHidden = false
            self.suggests.isHidden = true
        }
        
        search.tapOnSearch = {
            self.titles.isHidden = true
            self.list.isHidden = true
            self.configureSuggests()
            self.suggests.isHidden = false
        }
    }
    
    private func configureTitles() {
        view.addSubview(titles)
        
        titles.backgroundColor = .white
        
        titles.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(55)
        }
        
        titles.tapOnFavouriteTitle = {
            self.list.showFavouritesOnly(tapOnTitle: true)
            self.showFavouriteOnly = true
        }
        
        titles.tapOnStocksTitle = {
            self.list.showAllStocks()
            self.showFavouriteOnly = false
        }
    }
    
    private func configureList() {
        view.addSubview(list)
        
        list.snp.makeConstraints { make in
            make.top.equalTo(titles.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        list.tapOnCell = { stock in
            let vc = StockDetailController(stock: stock)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        list.scrollDown = { y in
            self.search.alpha = (90 - y)/95
            self.search.snp.removeConstraints()
            self.search.snp.makeConstraints { make in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(-y)
                make.height.equalTo(140)
            }
        }
    }
    
    private func configureSuggests() {
        view.addSubview(suggests)
        
        suggests.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}

