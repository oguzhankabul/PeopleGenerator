//
//  AppDelegate.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        app.route.start()
        
        return true
    }
}

