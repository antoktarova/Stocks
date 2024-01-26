import Foundation
import UIKit
import SnapKit

class FavoriteButton: UIView {
    
    var tapOnFavouriteButton: (()->())? = nil
    
    enum State {
        case highlighted
        case unhighlighted
    }
    
    private let favoriteButton = UIButton()
    private var state: State = .unhighlighted
    
    init() {
        super.init(frame: .zero)
        
        configureFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState(state: State) {
        switch state {
        case .highlighted:
            favoriteButton.setImage(UIImage(named: "favourite"), for: .normal)
            self.state = .highlighted
        case .unhighlighted:
            favoriteButton.setImage(UIImage(named: "notFavourite2"), for: .normal) 
            self.state = .unhighlighted
        }
    }
    
    private func configureFavoriteButton() {
        addSubview(favoriteButton)
        
        favoriteButton.setImage(UIImage(named: "notFavourite2"), for: .normal)
        
        favoriteButton.snp.makeConstraints { make in
            make.right.left.bottom.top.equalTo(self)
        }
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
    }

    @objc private func favoriteButtonAction() {
        switch state {
        case .highlighted:
            favoriteButton.setImage(UIImage(named: "notFavourite2"), for: .normal)
            state = .unhighlighted
            tapOnFavouriteButton?()
        case .unhighlighted:
            favoriteButton.setImage(UIImage(named: "favourite"), for: .normal)
            state = .highlighted
            tapOnFavouriteButton?()
        }
    }
}
