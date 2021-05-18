//
//  MainViewPresenter.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

protocol MainViewDisplayLogic {
    func displayAlgorithmPicker(withTitle title: String, animated: Bool)
    func hideAlgorithmPicker(animated: Bool)
    func displayAlgorithmNotSelectedError()
    func displayOutputText(_ text: String)
    func displaySelectedAlgorithmName(_ algorithmName: String)
    func displaySelectedShift(_ shift: String)
    func displayShiftPicker(withTitle title: String, animated: Bool)
    func hideShiftPicker(animated: Bool)
    func displayKeyInputTextField(animated: Bool)
    func hideKeyInputTextField(animated: Bool)
    func displayKeyLenghtError(withMessage message: String)
    func displayTwoKeysInputFields(animated: Bool)
    func hideTwoKeysInputFields(animated: Bool)
}

class MainViewPresenter {
    
    let localizations: MainViewLocalizations
    
    var viewController: MainViewDisplayLogic!
    
    init(localizations: MainViewLocalizations) {
        self.localizations = localizations
    }
}

extension MainViewPresenter: MainViewPresentingLogic {

    func presentAlgorithmPicker() {
        viewController.displayAlgorithmPicker(withTitle: localizations.chooseAlgorithmText, animated: true)
    }
    
    func hideAlgorithmPicker() {
        viewController.hideAlgorithmPicker(animated: true)
    }
    
    func presentAlgorithmNotSelected() {
        viewController.displayAlgorithmNotSelectedError()
    }
    
    func presentOutputText(_ text: String) {
        viewController.displayOutputText(text)
    }
    
    func presentSelectedAlgorithmName(_ algorithmName: String) {
        viewController.displaySelectedAlgorithmName(algorithmName.uppercased())
    }
    
    func presentSelectedShift(_ shift: Int) {
        let shiftString = " \(shift)"
        viewController.displaySelectedShift(shiftString)
    }
    
    func presentShiftPicker() {
        viewController.displayShiftPicker(withTitle: localizations.chooseShiftText, animated: true)
    }
    
    func hideShiftPicker() {
        viewController.hideShiftPicker(animated: true)
    }
    
    func presentKeyInputTextField() {
        viewController.hideAlgorithmPicker(animated: true)
        viewController.displayKeyInputTextField(animated: true)
    }
    
    func hideKeyInputTextField() {
        viewController.hideKeyInputTextField(animated: true)
    }
    
    func presentKeyLenghtError() {
        viewController.displayKeyLenghtError(withMessage: localizations.invalidKeyLenghtMessage.uppercased())
    }
    
    func presentTwoKeysInputFields() {
        viewController.displayTwoKeysInputFields(animated: true)
    }
    
    func hideTwoKeysInputFields() {
        viewController.hideTwoKeysInputFields(animated: true)
    }
    
    func presentTwoKeysError() {
        viewController.displayKeyLenghtError(withMessage: localizations.invalidKeyLenghtMessage.uppercased())
    }
}
