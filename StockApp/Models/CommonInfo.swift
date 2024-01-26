import Foundation
import UIKit
import SnapKit

struct CommonInfo: Codable {
    let companyInfo: CompanyInfo
    let priceInfo: PriceInfo
    var isFavourite = false
}
