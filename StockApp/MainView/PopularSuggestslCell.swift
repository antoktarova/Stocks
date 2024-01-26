import Foundation
import UIKit
import SnapKit

class PopularSuggestslCell: UICollectionViewCell {
    
    private let suggustName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSuggustName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePopularSuggestslCell() {
        
    }
    
    private func configureSuggustName() {
        addSubview(suggustName)
        
        suggustName.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(self)
        }
        
        suggustName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
}
