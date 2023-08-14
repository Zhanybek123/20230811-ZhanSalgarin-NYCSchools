//
//  SchoolApiTarget.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by SALGARA, YESKENDIR on 14.08.23.
//

import Foundation

enum SchoolAPITarget {
    case schoolList, schoolScore(dbn: String)
    
    var url: URL {
        switch self {
        case .schoolList:
            return URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!
        case let .schoolScore(dbn):
            return URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)")!
        }
    }
}
