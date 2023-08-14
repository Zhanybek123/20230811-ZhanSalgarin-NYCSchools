//
//  File2.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import Foundation

struct SchoolScoresDataModel: Decodable {
    let dbn: String
    let schoolName: String
    let readingScore: String
    let mathScore: String
    let writingScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case readingScore = "sat_critical_reading_avg_score"
        case mathScore = "sat_math_avg_score"
        case writingScore = "sat_writing_avg_score"
    }
}
