//
//  NameViewModel.swift
//  NamePrediction
//
//  Created by Hian Battiston on 01/08/2022.
//

import SwiftUI
import Foundation

@MainActor
class NameViewModel: ObservableObject {
    @Published var name = ""
    @Published var gender: String?
    @Published var countries: [NationalizeResponse.Country] = []
    @Published var age: Int?
    @Published var isLoading = false
    @Published var isSheetOpen = false
    
    init() {}
    
    func apiCall() {
//        print("API Call with name: \(name)")
//        https://api.agify.io/?name=meelad
//        https://api.nationalize.io/?name=nathaniel
//        https://api.genderize.io/?name=luc
        
        self.isLoading = true
        
        let agifyUrl = URL(string: "https://api.agify.io/?name=\(name)")!
        let agifyRequest = URLRequest(url: agifyUrl)
        
        let genderizeUrl = URL(string: "https://api.genderize.io/?name=\(name)")!
        let genderizeRequest = URLRequest(url: genderizeUrl)
        
        let nationalizeUrl = URL(string: "https://api.nationalize.io/?name=\(name)")!
        let nationalizeRequest = URLRequest(url: nationalizeUrl)
        
        Task {
            do {
                let (agifyData, _) = try await URLSession.shared.data(for: agifyRequest)
                let agifyResponse = try JSONDecoder().decode(AgifyResponse.self, from: agifyData)

                let (nationalizeData, _) = try await URLSession.shared.data(for: nationalizeRequest)
                let nationalizeResponse = try JSONDecoder().decode(NationalizeResponse.self, from: nationalizeData)
                
                let (genderizeData, _) = try await URLSession.shared.data(for: genderizeRequest)
                let genderizeResponse = try JSONDecoder().decode(GenderizeResponse.self, from: genderizeData)
                
                self.countries = nationalizeResponse.country
                self.age = agifyResponse.age
                self.gender = genderizeResponse.gender
                
                self.isLoading = false
                self.isSheetOpen = true
            } catch {
                print("error:: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
}
