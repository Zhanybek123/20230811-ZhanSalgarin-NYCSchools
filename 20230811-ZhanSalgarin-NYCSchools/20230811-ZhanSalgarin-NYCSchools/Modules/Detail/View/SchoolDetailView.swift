//
//  SchoolDetailView.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by SALGARA, YESKENDIR on 14.08.23.
//

import UIKit

private extension SchoolDetailView {
    struct Constant {
        static let defaultName: String = "Something for now"
        static let readingScore: String = "Here is going to be a description"
    }
}

final class SchoolDetailView: UIView {
    
    private(set) var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemCyan
        label.textColor = .white
        label.text = Constant.defaultName
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private(set) var mathScore: UILabel = {
        let label = UILabel()
        label.text = Constant.defaultName
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private(set) var readingScore: UILabel = {
        let label = UILabel()
        label.text = Constant.readingScore
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    private(set) var writingScore: UILabel = {
        let label = UILabel()
        label.text = "Here is going to be a description"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SchoolDetailView {
    func configure() {
        backgroundColor = .systemBackground
        [schoolNameLabel, mathScore, readingScore, writingScore].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            
            schoolNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            schoolNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            schoolNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            mathScore.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 16),
            mathScore.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mathScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            readingScore.topAnchor.constraint(equalTo: mathScore.bottomAnchor, constant: 20),
            readingScore.centerXAnchor.constraint(equalTo: mathScore.centerXAnchor),
            readingScore.leftAnchor.constraint(equalTo: mathScore.leftAnchor),
            readingScore.rightAnchor.constraint(equalTo: mathScore.rightAnchor),
            
            writingScore.topAnchor.constraint(equalTo: readingScore.bottomAnchor,constant: 16),
            writingScore.leadingAnchor.constraint(equalTo: readingScore.leadingAnchor),
            writingScore.trailingAnchor.constraint(equalTo: readingScore.trailingAnchor),
            writingScore.centerXAnchor.constraint(equalTo: readingScore.centerXAnchor),
        ])
    }
}
