//
//  Covid19ViewModel.swift
//  covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import Foundation


class Covid19ViewModel: ObservableObject {
    @Published var monthlyCovidData: [(month: String, total: Int, newCases: Int)]? = nil
    @Published var isLoading = false

    var covid19Requirement: Covid19RequirementProtocol

    init (covid19Requirement: Covid19RequirementProtocol = Covid19Requirement.shared) {
        self.covid19Requirement = covid19Requirement
    }

    @MainActor
    /// Función para cargar los datos del API y agruparlos por mes
    func loadCovid19Data() async {
        isLoading = true
        defer { isLoading = false } // Asegura que el estado de carga se actualiza correctamente

        do {
            // Llama al repositorio para obtener los datos
            if let data = await covid19Requirement.fetchCovid19Data() {
                self.monthlyCovidData = data
            } else {
                self.monthlyCovidData = nil
            }
        }
    }
}

