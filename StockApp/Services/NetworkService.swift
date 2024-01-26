import Foundation
import UIKit
import SnapKit

class NetworkService {
    
    func fetchCommonInfos(tickers: [String], completion: @escaping ([CommonInfo]) -> ()) {
        var companies: [CommonInfo] = []
        for ticker in tickers {
            fetchCommonInfo(ticker: ticker) { commonInfo in
                companies.append(commonInfo)
                
                if companies.count == tickers.count {
                    completion(companies)
                }
            }
        }
    }
    
    func fetchCommonInfo(ticker: String, completion: @escaping (CommonInfo) -> ()) {
        fetchCompanyInfo(ticker: ticker) { companyInfo in
            self.fetchPriceInfo(ticker: ticker) { priceInfo in
                let commonInfo = CommonInfo(companyInfo: companyInfo, priceInfo: priceInfo)
                completion(commonInfo)
            }
        }
    }
    
    func fetchCompanyInfo(ticker: String, completion: @escaping (CompanyInfo) -> ()) {
        let token = "clt5rl9r01qhnjgr7nngclt5rl9r01qhnjgr7no0"
        guard let url = URL(string: "https://finnhub.io/api/v1/stock/profile2?symbol=\(ticker)&token=\(token)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if
                let data = data,
                var companyInfo = try? JSONDecoder().decode(CompanyInfo.self, from: data)
            {
                DispatchQueue.main.async {
                    completion(companyInfo)
                }
            } else {
                print("Network error! \(error)")
            }
        }
        dataTask.resume()
    }
    
    func fetchPriceInfo(ticker: String, completion: @escaping (PriceInfo) -> ()) {
        let token = "clt5rl9r01qhnjgr7nngclt5rl9r01qhnjgr7no0"
        guard let url = URL(string: "https://finnhub.io/api/v1/quote?symbol=\(ticker)&token=\(token)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if
                let data = data,
                var priceInfo = try? JSONDecoder().decode(PriceInfo.self, from: data)
            {
                DispatchQueue.main.async{
                    completion(priceInfo)
                }
            } else {
                print("Network error! \(error)")
            }
        }
        dataTask.resume()
    }
    
    func fetchNewsInfo(ticker: String, completion: @escaping ([NewsInfo]) -> ()) {
        let token = "clt5rl9r01qhnjgr7nngclt5rl9r01qhnjgr7no0"
        guard let url = URL(string: "https://finnhub.io/api/v1/company-news?symbol=\(ticker)&from=2023-08-15&to=2023-08-20&token=\(token)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if
                let data = data,
                var newsInfo = try? JSONDecoder().decode([NewsInfo].self, from: data)
            {
                DispatchQueue.main.async{
                    completion(newsInfo)
                }
            } else {
                print("Network error! \(ticker)")
            }
        }
        dataTask.resume()
    }
    
    func fetchSummaryInfo(ticker: String, completion: @escaping (SummaryInfo) -> ()) {
        let urlsStr = "https://yahoo-finance15.p.rapidapi.com/api/v1/markets/stock/modules?ticker=\(ticker)&module=asset-profile"
        let url = URL(string: urlsStr)!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": "dfcf3e94eemsh9d2380ee24a4b65p128daejsn156dad6f6473",
            "X-RapidAPI-Host": "yahoo-finance15.p.rapidapi.com"
        ]

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if
                let data = data,
                var summaryInfo = try? JSONDecoder().decode(SummaryInfo.self, from: data)
            {
                DispatchQueue.main.async{
                    completion(summaryInfo)
                }
            } else {
                print("Network error! \(error)")
            }
        }
        dataTask.resume()
    }
}


