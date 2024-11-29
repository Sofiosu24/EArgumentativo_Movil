//
//  Covid19Repository.swift
//  covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import Foundation

// Definimos las rutas base y específicas de la API
struct Api {
    static let base = "https://api.api-ninjas.com/v1/"
    
    struct routes {
        static let covid19 = "covid19"
    }
}

protocol Covid19APIProtocol {
    func fetchCovid19Data() async -> [(month: String, total: Int, newCases: Int)]?
}

// Implementación del Repositorio
class Covid19Repository: Covid19APIProtocol {
    static let shared = Covid19Repository()
    let nservice: Covid19APIService

    init(nservice: Covid19APIService = Covid19APIService.shared) {
        self.nservice = nservice
    }

    func fetchCovid19Data() async -> [(month: String, total: Int, newCases: Int)]? {
        guard let url = URL(string: "\(Api.base)\(Api.routes.covid19)") else {
            return nil
        }

        if let data = await nservice.getCovid19DataByCountry(url: url, country: "Mexico") {
            return data.first?.casesGroupedByMonth()
        }

        return nil
    }
}


