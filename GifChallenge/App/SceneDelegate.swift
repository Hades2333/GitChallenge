//
//  SceneDelegate.swift
//  GifChallenge
//
//  Created by Mikalai on 09.03.2022.
//

import UIKit
import SwiftyBeaver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = ListAssembly.assembly()
        window.rootViewController = viewController
        self.window = window

        setupSwiftyBeaverLogging()

        window.makeKeyAndVisible()
    }

    private func setupSwiftyBeaverLogging() {
        let console = ConsoleDestination()
        SwiftyBeaver.addDestination(console)
    }
}
