//
//  MainViewAssembly.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainViewAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MainViewLocalizations.self) { _ in
            return MainViewLocalizations()
        }
        
        container.register(MainViewControllerConfigurator.self) { resolver in
            return MainViewControllerConfigurator(localizations: resolver.resolve(MainViewLocalizations.self)!)
        }
        
        container.register(MainViewPresentingLogic.self) { resolver in
            return MainViewPresenter(localizations: resolver.resolve(MainViewLocalizations.self)!)
        }
        
        container.register(MainViewBusinessLogic.self) { resolver in
            return MainViewInteractor(presenter: resolver.resolve(MainViewPresentingLogic.self)!)
        }
        
        container.storyboardInitCompleted(MainViewController.self) { resolver, controller in
            let interactor = resolver.resolve(MainViewBusinessLogic.self)! as? MainViewInteractor
            (interactor?.presenter as? MainViewPresenter)?.viewController = controller
            controller.interactor = interactor
            controller.configurator = resolver.resolve(MainViewControllerConfigurator.self)!
        }
    }
}
