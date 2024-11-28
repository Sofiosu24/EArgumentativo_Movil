//
//  Covid19.swift
//  Covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import Foundation

struct Covid19Cases: Decodable {
    let total: Int
    let new: Int
}

struct Covid19Data: Decodable {
    let country: String
    let region: String
    let cases: [String: Covid19Cases] // Diccionario donde las claves son fechas (YYYY-MM-DD)
}

extension Covid19Data {
    func casesGroupedByMonth() -> [(month: String, total: Int, newCases: Int)] {
        var monthlyData: [String: (total: Int, newCases: Int)] = [:]
        var lastDayOfMonth: [String: String] = [:] // Almacena la última fecha disponible por mes
        
        for (dateString, cases) in cases {
            let components = dateString.split(separator: "-")
            guard components.count >= 2 else { continue }
            let yearMonth = "\(components[0])-\(components[1])"
            
            // Actualizar la última fecha del mes si esta es posterior a la existente
            if let currentLastDay = lastDayOfMonth[yearMonth] {
                if dateString > currentLastDay {
                    lastDayOfMonth[yearMonth] = dateString
                }
            } else {
                lastDayOfMonth[yearMonth] = dateString
            }
            
            // Sumar los nuevos casos al mes correspondiente
            if monthlyData[yearMonth] != nil {
                monthlyData[yearMonth]?.newCases += cases.new
            } else {
                monthlyData[yearMonth] = (total: 0, newCases: cases.new)
            }
        }
        
        // Actualizar el total con el valor del último día del mes
        for (month, lastDate) in lastDayOfMonth {
            if let lastDayCases = cases[lastDate] {
                monthlyData[month]?.total = lastDayCases.total
            }
        }
        
        return monthlyData.map { (month: $0.key, total: $0.value.total, newCases: $0.value.newCases) }
            .sorted { $0.month < $1.month }
    }
}



