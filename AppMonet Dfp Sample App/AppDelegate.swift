//
//  AppDelegate.swift
//  AppMonet Dfp Sample App
//
//  Created by Jose Portocarrero on 3/13/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import UIKit
import CoreData
import AppMonet_Dfp

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // AppMonet Setup
        let appMonetConfiguration = AppMonetConfigurations.configuration { (AppMonetConfigurations) in
            AppMonetConfigurations?.applicationId = "<APPLICATIOND_ID>"
        }
        AppMonet.initialize(appMonetConfiguration)
        return true
    }
}
