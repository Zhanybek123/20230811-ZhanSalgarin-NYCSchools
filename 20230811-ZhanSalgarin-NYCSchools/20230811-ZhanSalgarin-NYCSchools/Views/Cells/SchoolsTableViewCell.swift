//
//  SchoolsTableViewCell.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import UIKit

private extension SchoolTableViewCell {
    struct Layout {
        static let offset: CGFloat = 16
    }
}

final class SchoolTableViewCell: UITableViewCell {
    
    static let id = "SchoolTableViewCell"
    
    private var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: SchoolNameDataModel) {
        self.schoolNameLabel.text = model.school_name
    }
}

private extension SchoolTableViewCell {
    
    func setLayouts() {
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        schoolNameLabel.font = fontMetrics.scaledFont(for: UIFont.preferredFont(forTextStyle: .headline))
        
        contentView.addSubview(schoolNameLabel)
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.offset),
            schoolNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Layout.offset),
            schoolNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Layout.offset),
            schoolNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Layout.offset),
        ])
    }
    
}
