//
//  SchoolDetailViewController.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import UIKit

final class SchoolDetailViewController: UIViewController {
    
    var contentView = SchoolDetailView()
    var viewModel: SchoolDetailViewModelProtocol
    
    init(viewModel: SchoolDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchScoreData()
        bind()
    }
}


private extension SchoolDetailViewController {
    
    func bind() {
        viewModel.didDataLoad = { [weak self] in
            self?.configure()
        }
        viewModel.didErrorOccur = { [weak self] error in
            // TODO: - Handle error properly via alert controller or pop off view
        }
    }
    
    func configure() {
        guard let model = viewModel.schoolScore else { return }
        self.contentView.schoolNameLabel.text = model.schoolName
        self.contentView.mathScore.text = "<SAT>  Math average score: \(model.mathScore)"
        self.contentView.readingScore.text = "<SAT>  Critical reading average score: \(model.readingScore)"
        self.contentView.writingScore.text = "<SAT>  Writing average score: \(model.writingScore)"
    }
    
}
