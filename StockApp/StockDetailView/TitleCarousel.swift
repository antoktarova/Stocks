import Foundation
import UIKit
import SnapKit

class TitleCarousel: UIView {
    
    private var collectionHeader: UICollectionView!
    private var titlesName = ["Chart", "Summary", "News", "Forecasts", "Idea"]
    var tapOnChapter: ((String) -> ())? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configureCollectionHeader()
    }
    
    private func configureCollectionHeader() {
        collectionHeader = UICollectionView(frame: .zero, collectionViewLayout: setUpFlowLayout())
        
        addSubview(collectionHeader)
        
        collectionHeader.snp.makeConstraints { make in
            make.top.right.left.bottom.equalTo(self)
        }
        
        collectionHeader.bounces = false
        collectionHeader.showsHorizontalScrollIndicator = false
        collectionHeader.dataSource = self
        collectionHeader.delegate = self
        collectionHeader.register(TitleCarouselCell.self, forCellWithReuseIdentifier: "TitleCarouselCell")
        collectionHeader.selectItem(at: [0,0], animated: true, scrollPosition: [])
    
    }
    
    private func setUpFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 100, height: 40)
        return layout
    }
}

extension TitleCarousel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titlesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionHeader.dequeueReusableCell(withReuseIdentifier: "TitleCarouselCell", for: indexPath) as? TitleCarouselCell else {
            return UICollectionViewCell()
        }
    
        cell.configureTitleCarouselCell(arrayTitles: titlesName, index: indexPath.row)
        return cell
        
        cell.updateTitleName(titleIsSelected: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapOnChapter?(titlesName[indexPath.row])
        
        collectionHeader.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
