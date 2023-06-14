//
//  AppRoute.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import UIKit

final class AppRoute {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let vm = PeopleListViewModel()
        let vc = PeopleListViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

let app = AppContainer()

final class AppContainer {
    let route = AppRoute()
}
