//
//  Models.swift
//  NamePrediction
//
//  Created by Hian Battiston on 01/08/2022.
//

import Foundation

struct AgifyResponse: Decodable {
    let name: String
    let age: Int
}

struct GenderizeResponse: Decodable {
    let name: String
    let gender: String
    let probability: Double
    let count: Int
}

struct NationalizeResponse: Decodable {
    struct Country: Decodable {
        let countryId: String
        let probability: Double
        var percentage: Double {
            probability * 100
        }
    }
    
    let name: String
    let country: [Country]
    
    enum CodingKeys: String, CodingKey {
        case name, country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tempCountry = try container.decode([Country].self, forKey: .country)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.country = tempCountry.isEmpty ? [Country(countryId: "PT", probability: 1)] : tempCountry
    }
}

extension NationalizeResponse.Country {
    /// Steps to write custom decoding
    /// 1. Define CodingKeys which should have one option for each property we're decoding
    enum CodingKeys: String, CodingKey {
        case countryId = "country_id", probability
    }
    
    /// 2. Write a custom decoder, which uses the `CodingKeys` enum to decode the response
    /// - Parameter decoder: The swift decoder provided by apple.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.countryId = try container.decode(String.self, forKey: .countryId)
        self.probability = try container.decode(Double.self, forKey: .probability)
    }
}
