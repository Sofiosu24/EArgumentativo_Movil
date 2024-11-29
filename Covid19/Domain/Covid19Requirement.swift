//
//  Covid19DataRequirement.swift
//  covid19
//
//  Created by Sofi Osorio on 28/11/24.
//

import Foundation

protocol Covid19RequirementProtocol {
    func fetchCovid19Data() async -> [(month: String, total: Int, newCases: Int)]?    
}

class Covid19Requirement: Covid19RequirementProtocol {
    static let shared = Covid19Requirement()
    let dataRepository: Covid19Repository
    
    init(dataRepository: Covid19Repository = Covid19Repository.shared) {
        self.dataRepository = dataRepository
    }
    
    func fetchCovid19Data() async -> [(month: String, total: Int, newCases: Int)]? {
        return await dataRepository.fetchCovid19Data()
    }
}
