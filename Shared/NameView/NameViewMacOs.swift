//
//  NameViewMacOs.swift
//  NamePrediction
//
//  Created by Hian Battiston on 01/08/2022.
//

import Foundation
import SwiftUI

struct NameView: View {
    @State var toggle = false
    @StateObject var viewModel = NameViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("NAME PREDICTION")
                    .fontWeight(.semibold)
                    .font(.title)
                    .frame(width: 428, height: 30)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                TextField("Enter your Full Name", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .disableAutocorrection(true)
                    .frame(width: 280, height: 120)

               Button(action: {
                   viewModel.apiCall()
               }) {
                   HStack {
                       Text(viewModel.isLoading ? "Loading" : "Predict!")
                       if viewModel.isLoading {
                           ProgressView()
                               .progressViewStyle(CircularProgressViewStyle(tint: .white))
                       }
                   }
                   .frame(width: 240)
                   .cornerRadius(40)
               }
            }.padding()
            
        }.sheet(isPresented: $viewModel.isSheetOpen) {
            VStack {
                if let age = viewModel.age {
                    Text("Predicted age: \(age)")
                        .fontWeight(.semibold)
                        .frame(width: 428, height: 30)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                }
                
                if let gender = viewModel.gender {
                    Text("Predicted gender: \(gender)")
                        .fontWeight(.semibold)
                        .frame(width: 428, height: 30)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                }
                
                ForEach(viewModel.countries, id: \.countryId) { country in
                    Text("Country: \(country.countryId): \(country.percentage, specifier: "%.2f")%")
                        .fontWeight(.semibold)
                        .frame(width: 428, height: 30)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                }
            }.toolbar {
                Button {
                    viewModel.isSheetOpen = false
                } label: {
                    Text("Close")
                }

            }
        }
    }
}
