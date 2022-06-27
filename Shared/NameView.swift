//
//  NameView.swift
//  NamePrediction
//
//  Created by Hian Battiston on 03/06/2022.
//

import SwiftUI

struct NameView: View {
    @State var name = ""
    @State var toggle = false
    
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

                TextField("Enter your Full Name", text: $name)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .foregroundColor(.black)
                    .disableAutocorrection(true)
                    .frame(width: 280, height: 120)

               Button(action: {
                   print("Hello World!")
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
            .dynamicTypeSize(.xxxLarge)
    }
}
