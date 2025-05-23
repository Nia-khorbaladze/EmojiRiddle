//
//  SceneDelegate.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let viewController = HomePageView()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
