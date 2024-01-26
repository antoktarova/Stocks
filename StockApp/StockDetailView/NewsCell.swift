import Foundation
import UIKit
import SnapKit
import SVGKit

class NewsCell: UITableViewCell {
    
    let headlineText = UILabel()
    let summaryText = UILabel()
    let justPoint = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHeadlineText()
        configureSummaryText()
        configureJustPoint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureNewsCell(headline: String, summary: String) {
        headlineText.text = headline
        summaryText.text = summary
    }
    
    private func configureHeadlineText() {
        addSubview(headlineText)
        
        headlineText.snp.makeConstraints { make in
            make.left.equalTo(self).inset(20)
            make.top.right.width.equalTo(self).inset(13)
            make.height.equalTo(49)
        }
        
        headlineText.textAlignment = .left
        headlineText.numberOfLines = 0
        headlineText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private func configureSummaryText() {
        addSubview(summaryText)
        
        summaryText.snp.makeConstraints { make in
            make.top.equalTo(headlineText.snp.bottom)
            make.left.equalTo(self).inset(18)
            make.right.width.equalTo(self).inset(13)
            make.height.equalTo(39)
        }
        
        summaryText.textAlignment = .left
        summaryText.numberOfLines = 0
        summaryText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    private func configureJustPoint() {
        addSubview(justPoint)
        
        justPoint.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.height.equalTo(10)
            make.left.equalTo(self)
        }
        
        justPoint.image = UIImage(named: "justPoint")
    }
}
