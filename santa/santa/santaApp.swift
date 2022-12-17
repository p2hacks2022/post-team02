//
//  santaApp.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct santaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            // Test()
        }
    }
}
