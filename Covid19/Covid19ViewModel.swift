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

    private let covid19Repository: Covid19Repository

    init(repository: Covid19Repository = Covid19Repository()) {
        self.covid19Repository = repository
    }

    @MainActor
    /// Función para cargar los datos del API y agruparlos por mes
    func loadCovid19Data() async {
        isLoading = true
        defer { isLoading = false } // Asegura que el estado de carga se actualiza correctamente

        do {
            // Llama al repositorio para obtener los datos
            if let data = await covid19Repository.fetchCovid19Data() {
                self.monthlyCovidData = data
            } else {
                self.monthlyCovidData = nil
            }
        }
    }
}

