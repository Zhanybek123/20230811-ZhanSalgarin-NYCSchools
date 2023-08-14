//
//  MockDataService.swift
//  20230811-ZhanSalgarin-NYCSchoolsTests
//
//  Created by zhanybek salgarin on 8/14/23.
//

import Foundation

import Foundation
@testable import _0230811_ZhanSalgarin_NYCSchools

final class MockSchoolDataService: SchoolDataServiceProtocol {
    
    var dbn: String = ""
    
    func fetch<T>(with target: _0230811_ZhanSalgarin_NYCSchools.SchoolAPITarget) async -> Result<T, _0230811_ZhanSalgarin_NYCSchools.SchoolAPIError> where T : Decodable {
        switch target {
        case .schoolList:
            let data: [SchoolNameDataModel] = [SchoolNameDataModel(dbn: dbn, school_name: "jn")]
            return .success(data as! T)
        case .schoolScore:
            let data: [SchoolScoresDataModel] = [SchoolScoresDataModel(dbn: dbn, schoolName: "jknj", readingScore: "jk", mathScore: "kjn", writingScore: "Kj")]
            return .success(data as! T)
        }
    }
    
}
