//
//  APICaller.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import Foundation

protocol SchoolDataServiceProtocol {
    func fetch<T: Decodable>(with target: SchoolAPITarget) async -> Result<T, SchoolAPIError>
}

final class SchoolDataService: SchoolDataServiceProtocol {
    
    func fetch<T: Decodable>(with target: SchoolAPITarget) async -> Result<T, SchoolAPIError> {
        do {
            let (data, _) = try await URLSession.shared.data(from: target.url)
            let decoder = JSONDecoder()
            guard let model = try? decoder.decode(T.self, from: data) else {
                throw SchoolAPIError.failedToDecode
            }
            return .success(model)
        } catch {
            return .failure(.custom(error: error))
        }
    }
    
}
