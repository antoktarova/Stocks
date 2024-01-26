import Foundation
import UIKit
import SnapKit

class StockDetailController: UIViewController {
    
    private let header = HeaderView()
    private let titleCarousel = TitleCarousel()
    private var stock: CommonInfo
    private let favService = FavouriteService()
    private let chartInfo = ChartView()
    private let summaryInfo = SummaryView()
    private var newsInfo = NewsView()
    private let forecastsInfo = ForecastsView()
    private let ideaInfo = IdeaView()
    private let service = NetworkService()
    
    init(stock: CommonInfo) {
        self.stock = stock
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        
        view.backgroundColor = .white
        configureHeader()
        configureTitleCarousel()
        configureChapter(theView: chartInfo)
    }
    
    private func configureHeader() {
        view.addSubview(header)
        
        header.backgroundColor = .white
        
        header.titleSymbol.text = stock.companyInfo.ticker
        header.subtitleName.text = stock.companyInfo.name
        
        if stock.isFavourite == true {
            header.favButton.setState(state: .highlighted)
        } else {
            header.favButton.setState(state: .unhighlighted)
        }
        
        header.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.height.equalTo(140)
        }
        
        header.tapOnBackButton = {
            self.navigationController?.popViewController(animated: true)
        }
        
        header.favButton.tapOnFavouriteButton = {
            if self.stock.isFavourite == true {
                self.stock.isFavourite = false
                self.favService.deleteFavourits(ticker: self.stock.companyInfo.ticker)
            } else {
                self.stock.isFavourite = true
                self.favService.saveFavourits(ticker: self.stock.companyInfo.ticker)
            }
        }
    }
    
    private func configureTitleCarousel() {
        view.addSubview(titleCarousel)
        
        titleCarousel.layer.shadowOffset = CGSize(width: 0, height: 5)
        titleCarousel.layer.shadowColor = UIColor.gray.cgColor
        titleCarousel.layer.shadowOpacity = 0.1
        
        titleCarousel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(40)
        }
        
        titleCarousel.tapOnChapter = { name in
            if name == "Chart" {
                self.configureChapter(theView: self.chartInfo)
            } else if name == "Summary" {
                self.service.fetchSummaryInfo(ticker: self.stock.companyInfo.ticker) { summaryInfo in
                    self.summaryInfo.summary.text = summaryInfo.body.longBusinessSummary
                }
                self.configureChapter(theView: self.summaryInfo)
            } else if name == "News" {
                self.service.fetchNewsInfo(ticker: self.stock.companyInfo.ticker) { newsInfo in
                    self.newsInfo.setNewsArray(newsArray: newsInfo)
                }
                self.configureChapter(theView: self.newsInfo)
            } else if name == "Forecasts" {
                self.configureChapter(theView: self.forecastsInfo)
            } else if name == "Idea" {
                self.configureChapter(theView: self.ideaInfo)
            }
        }
    }
    
    private func configureChapter(theView: UIView) {
        self.view.addSubview(theView)
        
        theView.snp.makeConstraints { make in
            make.top.equalTo(titleCarousel.snp.bottom).offset(7)
            make.left.right.bottom.equalTo(view)
        }
 
        configureChartInfo()
    }

    private func configureChartInfo() {
        chartInfo.titlePrice.text = "$ \(stock.priceInfo.c)"
        let priceDifferenceValue = stock.priceInfo.c - stock.priceInfo.pc
        let priceDifferencePrecent = (stock.priceInfo.c / 100 * abs(priceDifferenceValue))
        var sign = ""
        
        if priceDifferenceValue > 0 {
            sign = "+"
            chartInfo.titleCompare.textColor = .systemGreen
        } else if priceDifferenceValue < 0 {
            sign = "-"
            chartInfo.titleCompare.textColor = .red
        } else {
            sign = ""
            chartInfo.titleCompare.textColor = .lightGray
        }

        chartInfo.titlePrice.text = "$\(stock.priceInfo.c)"
        chartInfo.titleCompare.text = "\(sign)$\(NSString(format:"%.2f", abs(priceDifferenceValue))) (\(NSString(format:"%.2f", priceDifferencePrecent))%)"
        chartInfo.payButton.setTitle("Buy for $\(stock.priceInfo.c)", for: .normal)
    }
}
