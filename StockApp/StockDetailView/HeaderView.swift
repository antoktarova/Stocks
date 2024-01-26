import Foundation
import UIKit
import SnapKit

class HeaderView: UIView {
    
    let titleSymbol = UILabel()
    let subtitleName = UILabel()
    private let backButton = UIButton()
    let favButton = FavoriteButton()
    var tapOnBackButton: (()->())? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configureTitleSymbol()
        configureSubtitleName()
        configureFavButton()
        configureBackButton()
    }
    
    private func configureTitleSymbol() {
        addSubview(titleSymbol)
    
        titleSymbol.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        titleSymbol.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).inset(70)
            make.height.equalTo(30)
        }
    }
    
    private func configureSubtitleName() {
        addSubview(subtitleName)
        
        subtitleName.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        subtitleName.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(titleSymbol).offset(20)
            make.height.equalTo(15)
        }
    }
    
    private func configureFavButton() {
        addSubview(favButton)
        
        favButton.snp.makeConstraints { make in
            make.right.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(30)
            make.height.width.equalTo(30)
        }
    }
    
    private func configureBackButton() {
        addSubview(backButton)
            
        backButton.setImage(UIImage(named: "back"), for: .normal)
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(30)
            make.height.width.equalTo(22)
        }
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    @objc private func backButtonAction() {
        tapOnBackButton?()
    }
}
