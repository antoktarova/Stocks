import Foundation
import UIKit
import SnapKit

class FavouriteService {
    
    private let userDefaults = UserDefaults.standard
    
    func getFavourits() -> [String] {
        guard let data = userDefaults.data(forKey: "isFavourite") else {
            return []
        }
        
        let decoder = PropertyListDecoder()
        let tickers = try? decoder.decode([String].self, from: data)
        return tickers ?? []
    }
    
    func saveFavourits(ticker: String) {
        var arrayOfTickers = getFavourits()
        if !arrayOfTickers.contains(ticker) {
            arrayOfTickers.append(ticker)
        }
        
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(arrayOfTickers)
        userDefaults.set(data, forKey: "isFavourite")
    }
    
    func deleteFavourits(ticker: String) {
        var arrayOfTickers = getFavourits()

        var searchIndex = 0
        for index in 0...arrayOfTickers.count - 1 {
            if arrayOfTickers[index] == ticker {
                searchIndex = index
            }
        }
        arrayOfTickers.remove(at: searchIndex)
//
//        
//        var arrayOfTickers = getFavourits().filter { element in
//            if element == ticker {
//                return false
//            }
//            return true
//        }
        
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(arrayOfTickers)
        userDefaults.set(data, forKey: "isFavourite")
    }
    
}
