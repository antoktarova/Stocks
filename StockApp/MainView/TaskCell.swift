import Foundation
import UIKit
import SnapKit
import SVGKit

class TaskCell: UITableViewCell {
    
    private let viewUnderCell = UIView()
    private let logoOfCompany = UIImageView()
    private let symbolOfCompany = UILabel()
    private let nameOfCompany = UILabel()
    private let priceOfStock = UILabel()
    private let priceDifference = UILabel()
    let favoriteLabel = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureViewUnderCell()
        configureLogoOfCompany()
        configureSymbolOfCompany()
        configureNameOfCompany()
        configurePriceOfStock()
        configurePriceDifference()
        configureFavoriteLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureCell(isColored: Bool, ticker: String, commonInfo: CommonInfo) {
        configureCellFirstPart(isColored: isColored, companyInfo: commonInfo.companyInfo)
        configureCellSecondPart(priceInfo: commonInfo.priceInfo)
        
        if commonInfo.isFavourite == true {
            favoriteLabel.image = UIImage(named: "favourite")
        } else {
            favoriteLabel.image = UIImage(named: "notFavourite")
        }
    }
    
    private func configureCellFirstPart(isColored: Bool, companyInfo: CompanyInfo) {
        symbolOfCompany.text = companyInfo.ticker
        nameOfCompany.text = companyInfo.name
        
        DispatchQueue.global(qos: .userInteractive).async {
            let url = URL(string: companyInfo.logo)!
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.logoOfCompany.image = SVGKImage(data: data).uiImage
                }
            }
        }
        
        if isColored {
            viewUnderCell.backgroundColor = UIColor.systemGray6
        } else {
            viewUnderCell.backgroundColor = UIColor.white
        }
    }
    
    private func configureCellSecondPart(priceInfo: PriceInfo) {
        let priceDifferenceValue = priceInfo.c - priceInfo.pc
        let priceDifferencePrecent = (priceInfo.c / 100 * abs(priceDifferenceValue))
        var sign = ""
        
        if priceDifferenceValue > 0 {
            sign = "+"
            priceDifference.textColor = .systemGreen
        } else if priceDifferenceValue < 0 {
            sign = "-"
            priceDifference.textColor = .red
        } else {
            sign = ""
            priceDifference.textColor = .lightGray
        }

        priceOfStock.text = "$ \(priceInfo.c)"
        priceDifference.text = "\(sign)$\(NSString(format:"%.2f", abs(priceDifferenceValue))) (\(NSString(format:"%.2f", priceDifferencePrecent))%)"
    }
    
    private func configureViewUnderCell() {
        addSubview(viewUnderCell)
        
        viewUnderCell.layer.cornerRadius = 22
        
        viewUnderCell.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self)
        }
    }
    
    private func configureLogoOfCompany() {
        viewUnderCell.addSubview(logoOfCompany)
        
        logoOfCompany.layer.cornerRadius = 18
        logoOfCompany.layer.borderWidth = 0.1
        logoOfCompany.layer.borderColor = UIColor.white.cgColor
        logoOfCompany.clipsToBounds = true
        
        logoOfCompany.snp.makeConstraints { make in
            make.left.equalTo(viewUnderCell).inset(13)
            make.width.height.equalTo(64)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    private func configureSymbolOfCompany() {
        viewUnderCell.addSubview(symbolOfCompany)
        
        symbolOfCompany.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        symbolOfCompany.snp.makeConstraints { make in
            make.top.equalTo(logoOfCompany).offset(5)
            make.left.equalTo(logoOfCompany.snp.right).offset(13)
            make.height.equalTo(30)
        }
    }
    
    private func configureNameOfCompany() {
        viewUnderCell.addSubview(nameOfCompany)
        
        nameOfCompany.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        nameOfCompany.snp.makeConstraints { make in
            make.top.equalTo(symbolOfCompany).offset(35)
            make.left.equalTo(logoOfCompany.snp.right).offset(13)
            make.height.equalTo(15)
            make.width.equalTo(120)
        }
    }
    
    private func configurePriceOfStock() {
        viewUnderCell.addSubview(priceOfStock)
        
        priceOfStock.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        priceOfStock.snp.makeConstraints { make in
            make.top.equalTo(logoOfCompany).offset(5)
            make.right.equalTo(viewUnderCell.snp.right).inset(16)
            make.height.equalTo(30)
        }
    }
    
    private func configurePriceDifference() {
        viewUnderCell.addSubview(priceDifference)
        
        priceDifference.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        priceDifference.textColor = .systemGreen
        
        priceDifference.snp.makeConstraints { make in
            make.top.equalTo(symbolOfCompany).offset(35)
            make.right.equalTo(viewUnderCell.snp.right).inset(16)
            make.height.equalTo(15)
        }
    }
    
    private func configureFavoriteLabel() {
        viewUnderCell.addSubview(favoriteLabel)
        
        favoriteLabel.snp.makeConstraints { make in
            make.top.equalTo(logoOfCompany).offset(5)
            make.left.equalTo(symbolOfCompany.snp.right).offset(16)
            make.height.width.equalTo(30)
        }
    }
    
    override func prepareForReuse() {
        logoOfCompany.image = nil
        favoriteLabel.image = nil
    }
}
