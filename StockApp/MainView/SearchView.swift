import Foundation
import UIKit
import SnapKit

class SearchView: UIView {
    
    private let search = UITextField()
    private let loupe = UIImageView()
    private let exitButton = UIButton()
    var returnBack: (()->())? = nil
    var tapOnSearch: (()->())? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)

        configureSearch()
        configureLoupe()
    }
    
    private func configureSearch() {
        addSubview(search)
          
        search.attributedPlaceholder = NSAttributedString(
            string: "Find company or ticker",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        )
        
        search.leftViewMode = .always
        search.leftView = UIView(frame: CGRect(x:0,y:0,width:45,height:0))
        search.layer.cornerRadius = 28
        search.layer.borderWidth = 1.5
        search.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        search.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        search.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self).inset(70)
            make.height.equalTo(55)
            make.bottom.equalTo(self).inset(15)
        }
        
        search.addTarget(self, action: #selector(enterText), for: .editingDidBegin)
    }
    
    private func configureLoupe() {
        addSubview(loupe)
        
        loupe.image = UIImage(named: "loupe")
        
        loupe.snp.makeConstraints { make in
            make.top.equalTo(search).inset(16)
            make.left.equalTo(search).inset(15)
            make.height.width.equalTo(22)
        }
    }
    
    private func configureExitButton() {
        addSubview(exitButton)
        
        exitButton.setImage(UIImage(named: "back"), for: .normal)
        exitButton.alpha = 1
        
        exitButton.snp.makeConstraints { make in
                make.top.equalTo(search).inset(16)
                make.left.equalTo(search).inset(15)
                make.height.width.equalTo(22)
        }
        
        exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    @objc private func enterText() {
        search.placeholder = nil
        loupe.alpha = 0
        tapOnSearch?()
        configureExitButton()
    }
    
    @objc private func exitAction() {
        exitButton.alpha = 0
        search.text = nil
        search.placeholder = "Find company or ticker"
        loupe.alpha = 1
        returnBack?()
        search.resignFirstResponder()
    }
}
