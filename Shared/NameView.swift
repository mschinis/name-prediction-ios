//
//  NameView.swift
//  NamePrediction
//
//  Created by Hian Battiston on 03/06/2022.
//

import SwiftUI

@MainActor
class NameViewModel: ObservableObject {
    @Published var name = ""
    @Published var gender: String?
    @Published var countries: [NationalizeResponse.Country] = []
    @Published var age: Int?
    
    init() {}
    
    func apiCall() {
//        print("API Call with name: \(name)")
//        https://api.agify.io/?name=meelad
//        https://api.nationalize.io/?name=nathaniel
//        https://api.genderize.io/?name=luc
        
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
            } catch {
                print("error:: \(error.localizedDescription)")
            }
        }
    }
}

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
        let country_id: String
        let probability: Double
    }
    
    let name: String
    let country: [Country]
}

struct NameView: View {
    
    @State var toggle = false
    @StateObject var viewModel = NameViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors:[.gray, .white]
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                Text("NAME PREDICTION")
                    .fontWeight(.semibold)
                    .font(.title)
                    .frame(width: 428, height: 30)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.bottom, 8)

                TextField("Enter your Full Name", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .foregroundColor(.black)
                    .disableAutocorrection(true)
                    .frame(width: 280, height: 120)

               Button(action: {
                   viewModel.apiCall()
               }) {
                   HStack {
                       Text("Predict!")
                           .fontWeight(.semibold)
                           .font(.title)
                   }
                   .frame(width: 240)
                   .padding()
                   .foregroundColor(.white)
                   .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                   .cornerRadius(40)
               }
                if let age = viewModel.age {
                    Text("Predicted age: \(age)")
                        .fontWeight(.semibold)
                        .frame(width: 428, height: 30)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                }
                
                if let gender = viewModel.gender {
                    Text("Predicted gender: \(gender)")
                        .fontWeight(.semibold)
                        .frame(width: 428, height: 30)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                }
                
                ForEach(viewModel.countries, id: \.country_id) { country in
                    Text("Country: \(country.country_id): \(country.probability)")
                        .fontWeight(.semibold)
                        .frame(width: 428, height: 30)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                }
            }
        }
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
