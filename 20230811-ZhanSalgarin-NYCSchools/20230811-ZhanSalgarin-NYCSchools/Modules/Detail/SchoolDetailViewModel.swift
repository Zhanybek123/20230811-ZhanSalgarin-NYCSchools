//
//  SchoolDetailViewModel.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by SALGARA, YESKENDIR on 14.08.23.
//

import Foundation

protocol SchoolDetailViewModelProtocol {
    var schoolScore: SchoolScoresDataModel? { get }
    var didDataLoad: (() -> Void)? { get set }
    var didErrorOccur: ((Error) -> Void)? { get set }
    
    func fetchScoreData()
}

final class SchoolDetailViewModel: SchoolDetailViewModelProtocol {
    
    private let schoolDBN: String
    var schoolScore: SchoolScoresDataModel?
    
    var didDataLoad: (() -> Void)?
    var didErrorOccur: ((Error) -> Void)?
    
    var schoolDataService: SchoolDataServiceProtocol
    
    init(schoolDBN: String,
         schoolDataService: SchoolDataServiceProtocol) {
        self.schoolDBN = schoolDBN
        self.schoolDataService = schoolDataService
    }
    
    func fetchScoreData() {
        Task {
            let schoolScoreResult: Result<[SchoolScoresDataModel], SchoolAPIError> = await schoolDataService.fetch(with: .schoolScore(dbn: schoolDBN))
            switch schoolScoreResult {
            case let .success(schoolScores):
                await MainActor.run(body: {
                    self.schoolScore = schoolScores.first
                    self.didDataLoad?()
                })
            case let .failure(error):
                await MainActor.run {
                    self.didErrorOccur?(error)
                }
            }
        }
    }
    
}
