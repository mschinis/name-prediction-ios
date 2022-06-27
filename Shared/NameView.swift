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
    
    init() {}
    
    func apiCall() {
//        print("API Call with name: \(name)")
//        https://api.agify.io/?name=meelad
//        https://api.nationalize.io/?name=nathaniel
        
        let url = URL(string: "https://api.agify.io/?name=\(name)")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Hello there")
        }
    }
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
            }
        }
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
