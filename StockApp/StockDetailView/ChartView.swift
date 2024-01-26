import Foundation
import UIKit
import SnapKit

class ChartView: UIView {
    
    let titlePrice = UILabel()
    let titleCompare = UILabel()
    private var periodLength = UIStackView()
    let payButton = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        configureTitlePrice()
        configureTitleCompare()
        configurePeriodLength()
        configurePayButton()
    }
    
    private func configureTitlePrice() {
        addSubview(titlePrice)
        
        titlePrice.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        titlePrice.snp.makeConstraints { make in
            make.top.equalTo(self).inset(33)
            make.centerX.equalTo(self)
            make.height.equalTo(70)
        }
    }
    
    private func configureTitleCompare() {
        addSubview(titleCompare)
        
        titleCompare.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleCompare.textColor = .systemGreen
        
        titleCompare.snp.makeConstraints { make in
            make.top.equalTo(titlePrice.snp.bottom).inset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    private func addButtonInPeriodLength() {
        let numberOfButtons = 5
        
        for i in 0...numberOfButtons {
            let button = UIButton()
            button.backgroundColor = .systemGray6
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 16
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            
            if i == 0 {
                button.setTitle("D", for: .normal)
            } else if i == 1 {
                button.setTitle("W", for: .normal)
            } else if i == 2 {
                button.setTitle("M", for: .normal)
            } else if i == 3 {
                button.setTitle("6M", for: .normal)
            } else if i == 4 {
                button.setTitle("1Y", for: .normal)
            } else if i == 5 {
                button.setTitle("All", for: .normal)
            }
            periodLength.addArrangedSubview(button)
        }
    }
    
    private func configurePeriodLength() {
        addSubview(periodLength)
        
        periodLength.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(150)
            make.left.right.equalTo(self).inset(20)
            make.height.equalTo(50)
        }
        
        periodLength.spacing = 10
        periodLength.axis = .horizontal
        periodLength.distribution = .fillEqually
        addButtonInPeriodLength()
    }
    
    private func configurePayButton() {
        addSubview(payButton)
        
        payButton.snp.makeConstraints { make in
            make.top.equalTo(periodLength.snp.bottom).offset(55)
            make.left.right.equalTo(self).inset(20)
            make.height.equalTo(60)
        }
        
        payButton.backgroundColor = .black
        payButton.layer.cornerRadius = 16
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        payButton.setTitleColor(.white, for: .normal)
    }
}



