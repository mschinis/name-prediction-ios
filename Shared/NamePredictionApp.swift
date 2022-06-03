//
//  NamePredictionApp.swift
//  Shared
//
//  Created by Michael Schinis on 03/06/2022.
//

// Architecture of the app:
// We use MVVM architecture
// 1. Model             - Responsible for doing API calls, loading/sending information.
// 2. View              - Responsible for UI
// 3. ViewModel         - Responsbile for connecting the View with the Model, and containing business logic.
//

import SwiftUI

@main
struct NamePredictionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
