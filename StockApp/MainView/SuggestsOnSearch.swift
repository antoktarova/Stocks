import Foundation
import UIKit
import SnapKit

class SuggestsOnSearch: UIView {
    
    private let titlePopularRequest = UILabel()
    private var popularSuggusts: UICollectionView!
    private let tickersList = ["TSLA", "APPN", "BAC", "MA", "MSFT", "AMZN", "MA", "AAPL", "APPF", "GOOGL"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configureTitlePopularRequest()
        configurePopularSuggusts()
    }
    
    private func configureTitlePopularRequest() {
        addSubview(titlePopularRequest)
        
        titlePopularRequest.snp.makeConstraints { make in
            make.left.right.top.equalTo(self).inset(16)
        }
        
        titlePopularRequest.text = "Popular requests"
        titlePopularRequest.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private func configurePopularSuggusts() {
        popularSuggusts = UICollectionView(frame: .zero, collectionViewLayout: setUpFlowLayout())
        
        popularSuggusts.snp.makeConstraints { make in
            
        }
//        
//        popularSuggusts.delegate = self
//        popularSuggusts.dataSource = self
        popularSuggusts.register(PopularSuggestslCell.self, forCellWithReuseIdentifier: "PopularSuggestslCell")
    }
    
    private func setUpFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 80, height: 40)
        return layout
    }
}

//extension SuggestsOnSearch: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        tickersList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
