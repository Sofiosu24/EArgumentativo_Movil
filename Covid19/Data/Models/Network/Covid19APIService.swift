//
//  Covid19APIService.swift
//  covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import Foundation
import Alamofire

class Covid19APIService {
    static let shared = Covid19APIService()
    private let apiKey = "/Tie/v4WiFy7T2FANdfwJw==5r280im7d5OPkjvc"

    func getCovid19Data(url: URL) async -> [Covid19Data]? {
        let headers: HTTPHeaders = [
            "X-Api-Key": apiKey
        ]

        let taskRequest = AF.request(url, method: .get, headers: headers).validate()
        let response = await taskRequest.serializingData().response

        switch response.result {
        case .success(let data):
            do {
                return try JSONDecoder().decode([Covid19Data].self, from: data)
            } catch {
                debugPrint("Error decoding data: \(error.localizedDescription)")
                return nil
            }
        case let .failure(error):
            debugPrint("Request failed: \(error.localizedDescription)")
            return nil
        }
    }

    func getCovid19DataByCountry(url: URL, country: String) async -> [Covid19Data]? {
        let headers: HTTPHeaders = [
            "X-Api-Key": apiKey
        ]

        let parameters: Parameters = [
            "country": country
        ]

        let taskRequest = AF.request(url, method: .get, parameters: parameters, headers: headers).validate()
        let response = await taskRequest.serializingData().response

        switch response.result {
        case .success(let data):
            do {
                return try JSONDecoder().decode([Covid19Data].self, from: data)
            } catch {
                debugPrint("Error decoding data: \(error.localizedDescription)")
                return nil
            }
        case let .failure(error):
            debugPrint("Request failed: \(error.localizedDescription)")
            return nil
        }
    }
}
