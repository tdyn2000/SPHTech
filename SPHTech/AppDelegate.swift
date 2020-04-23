//
//  AppDelegate.swift
//  SPHTech
//
//  Created by La Hy Tai on 4/23/20.
//

import UIKit

#if DEBUG
import SBTUITestTunnelServer;
import CoreLocation;
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        SBTUITestTunnelServer.takeOff()
        #endif
        
        return true
    }
    
}

