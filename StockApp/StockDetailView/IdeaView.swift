import Foundation
import UIKit
import SnapKit

class IdeaView: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
    }
}
