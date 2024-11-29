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
                            Text("Cases per month: \(data.month)")
                                .font(.headline)
                            Text("Total Cases: \(data.total)")
                                .font(.subheadline)
                                .foregroundColor(.red)
                            Text("New Cases: \(data.newCases)")
                                .font(.subheadline)
                                .foregroundColor(.blue)
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
