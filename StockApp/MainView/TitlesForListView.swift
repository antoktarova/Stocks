import Foundation
import UIKit
import SnapKit

class TitlesForListView: UIView {
    
    private let buttonStocks = UIButton()
    private let buttonFavorite = UIButton()
    var tapOnFavouriteTitle: (()->())? = nil
    var tapOnStocksTitle: (()->())? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)

        configureButtonStocks()
        configureButtonFavorite()
    }
       
    private func configureButtonStocks() {
        addSubview(buttonStocks)
        
        buttonStocks.setTitle("Stocks", for: .normal)
        buttonStocks.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        buttonStocks.setTitleColor(.black, for: .normal)
        
        buttonStocks.snp.makeConstraints { make in
            make.left.equalTo(self).inset(16)
            make.width.equalTo(110)
            make.top.equalTo(self)
        }
        
        buttonStocks.addTarget(self, action: #selector(chooseStocks), for: .touchUpInside)
    }
    
    private func configureButtonFavorite() {
        addSubview(buttonFavorite)
        
        buttonFavorite.setTitle("Favourite", for: .normal)
        buttonFavorite.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        buttonFavorite.setTitleColor(.gray, for: .normal)
        
        buttonFavorite.snp.makeConstraints { make in
            make.left.equalTo(buttonStocks).offset(70)
            make.width.equalTo(200)
            make.bottom.equalTo(self).inset(9)
        }
        
        buttonFavorite.addTarget(self, action: #selector(chooseFavourite), for: .touchUpInside)
    }
    
    @objc private func chooseFavourite() {
        buttonFavorite.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        buttonFavorite.setTitleColor(.black, for: .normal)
        
        buttonFavorite.snp.removeConstraints()
        buttonFavorite.snp.makeConstraints { make in
            make.left.equalTo(buttonStocks).offset(70)
            make.width.equalTo(200)
            make.top.equalTo(self)
        }
        
        buttonStocks.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        buttonStocks.setTitleColor(.gray, for: .normal)
        
        buttonStocks.snp.removeConstraints()
        buttonStocks.snp.makeConstraints { make in
            make.left.equalTo(self).inset(7)
            make.width.equalTo(100)
            make.bottom.equalTo(self).inset(9)
        }
        tapOnFavouriteTitle?()
    }
    
    @objc private func chooseStocks() {
        buttonStocks.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        buttonStocks.setTitleColor(.black, for: .normal)
        
        buttonStocks.snp.removeConstraints()
        buttonStocks.snp.makeConstraints { make in
            make.left.equalTo(self).inset(16)
            make.width.equalTo(110)
            make.top.equalTo(self)
        }
        
        buttonFavorite.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        buttonFavorite.setTitleColor(.gray, for: .normal)
        
        buttonFavorite.snp.removeConstraints()
        buttonFavorite.snp.makeConstraints { make in
            make.left.equalTo(buttonStocks).offset(70)
            make.width.equalTo(200)
            make.bottom.equalTo(self).inset(9)
        }
        tapOnStocksTitle?()
    }
}
