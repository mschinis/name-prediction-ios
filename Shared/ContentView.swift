//
//  ContentView.swift
//  Shared
//
//  Created by Michael Schinis on 03/06/2022.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var age = 0

    init() {}
    
    func increaseAge(amount: Int) {
        age = age + amount
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text("\(viewModel.age)")
                .padding()

            Button("Click me") {
                viewModel.increaseAge(amount: 5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
