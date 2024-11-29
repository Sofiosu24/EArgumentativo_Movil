//
//  Covid19App.swift
//  Covid19
//
//  Created by Sofi Osorio on 27/11/24.
//

import SwiftUI

@main
struct Covid19App: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            Covid19View()
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("App State : Background")
            case .inactive:
                print("App State : Inactive")
            case .active: // Foreground
                print("App State : Active")
            @unknown default:
                 print("App State : Unknown")
            }
        }
    }
}
