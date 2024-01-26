import Foundation
import UIKit
import SnapKit

class TitleCarouselCell: UICollectionViewCell {
    
    private let titleName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTitleName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
       didSet {
           updateTitleName(titleIsSelected: isSelected)
       }
   }
    
    func configureTitleCarouselCell(arrayTitles: [String], index: Int) {
        titleName.text = arrayTitles[index]
        
        self.clipsToBounds = true
    }
    
    private func configureTitleName() {
        addSubview(titleName)
        
        titleName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleName.textColor = .gray
        
        titleName.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(self)
        }
    }
    
    func updateTitleName(titleIsSelected: Bool) {
        if titleIsSelected {
            titleName.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            titleName.textColor = .black
        } else {
            titleName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            titleName.textColor = .gray
        }
    }
}
