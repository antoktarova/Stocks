import Foundation
import UIKit
import SnapKit

class SummaryView: UIView {
    
    let scrollView = UIScrollView()
    let summary = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        configureScrollView()
        configureSummary()
    }
    
    private func configureScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(self)
        }
    }
    
    private func configureSummary() {
        scrollView.addSubview(summary)
        
        summary.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView).inset(16)
            make.left.equalTo(scrollView).inset(22)
            make.width.equalTo(scrollView).inset(22)
        }
        
        summary.numberOfLines = 0
        summary.textAlignment = .center
        summary.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}
