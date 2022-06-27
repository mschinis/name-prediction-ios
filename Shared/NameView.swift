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
    VStack {
            Spacer()
            Text("NAME PREDICTION")
                .fontWeight(.semibold)
                .font(.system(size: 29))
                .frame(width: 428, height: 30)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            TextField("Enter your Full Name", text: $name)
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
                .foregroundColor(.black)
                .disableAutocorrection(true)
                .frame(width: 280, height: 120)
           Button(action: {
               print("Hello World!")
           }) {
               HStack {
                   Text("Predict!")
                       .fontWeight(.semibold)
                       .font(.system(size: 20))
               }
               .frame(width: 240)
               .padding()
               .foregroundColor(.white)
               .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
               .cornerRadius(40)
           }

            Spacer()
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .background(LinearGradient(gradient:
            Gradient(colors:[.gray, .white]),
                     startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
