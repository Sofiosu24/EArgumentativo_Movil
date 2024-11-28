//
//  ContentView.swift
//  Covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import SwiftUI

struct Covid19View: View {
    @StateObject private var viewModel = Covid19ViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading data...")
                } else if let monthlyData = viewModel.monthlyCovidData {
                    List(monthlyData, id: \.month) { data in
                        VStack(alignment: .leading) {
                            Text("Month: \(data.month)")
                                .font(.headline)
                            Text("Total Cases: \(data.total)")
                                .font(.subheadline)
                            Text("New Cases: \(data.newCases)")
                                .font(.subheadline)
                        }
                    }
                } else {
                    Text("Failed to load data.")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("COVID-19 Data México")
            .onAppear {
                Task {
                    await viewModel.loadCovid19Data()
                }
            }
        }
    }
}

#Preview {
    Covid19View()
}
