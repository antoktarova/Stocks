import Foundation
import UIKit
import SnapKit

struct SummaryInfo: Codable {
    
    struct Body: Codable {
        let longBusinessSummary: String
    }
    
    let body: Body
}


