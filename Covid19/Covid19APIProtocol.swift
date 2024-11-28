//
//  Covid19APIProtocol.swift
//  Covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import Foundation

protocol Covid19APIProtocol {
    func fetchCovid19Data() async -> [(month: String, total: Int, newCases: Int)]?
}

