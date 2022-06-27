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
    @Published var age: Int?
    
    init() {}
    
    func apiCall() {
//        print("API Call with name: \(name)")
//        https://api.agify.io/?name=meelad
//        https://api.nationalize.io/?name=nathaniel
        
        let url = URL(string: "https://api.agify.io/?name=\(name)")!
        let request = URLRequest(url: url)
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let res = try JSONDecoder().decode(AgifyResponse.self, from: data)

                self.age = res.age
            } catch {
                print("error:: \(error.localizedDescription)")
            }
        }

//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let data = data {
//                let res = try! JSONDecoder().decode(AgifyResponse.self, from: data)
//
//                DispatchQueue.main.async {
//                    self.age = res.age
//                }
//            }
//        }
//        .resume()
    }
}

struct AgifyResponse: Decodable {
    let name: String
    let age: Int
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
            }
        }
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
