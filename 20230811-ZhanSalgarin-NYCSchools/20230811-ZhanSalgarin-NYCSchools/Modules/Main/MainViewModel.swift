//
//  SchoolViewModel.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var schools: [SchoolNameDataModel] { get }
    var didDataLoad: (() -> Void)? { get set }
    var didErrorOccur: ((Error) -> Void)? { get set }

    func fetchData()
}

final class MainViewModel: MainViewModelProtocol {
    
    var schools: [SchoolNameDataModel] = []
    var didDataLoad: (() -> Void)?
    var didErrorOccur: ((Error) -> Void)?
    
    var schoolDataService: SchoolDataServiceProtocol
    
    init(schoolDataService: SchoolDataServiceProtocol) {
        self.schoolDataService = schoolDataService
    }
    
    func fetchData() {
        Task{
            let schoolResult: Result<[SchoolNameDataModel], SchoolAPIError> = await schoolDataService.fetch(with: .schoolList)
            switch schoolResult {
            case let .success(schools):
                self.schools = schools
                await MainActor.run {
                    self.didDataLoad?()
                }
            case let .failure(error):
                await MainActor.run {
                    self.didErrorOccur?(error)
                }
            }
        }
    }

}
