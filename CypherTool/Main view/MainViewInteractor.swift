//
//  MainViewInteractor.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

protocol MainViewPresentingLogic {
    func presentAlgorithmPicker()
    func hideAlgorithmPicker()
    func presentAlgorithmNotSelected()
    func presentOutputText(_ text: String)
    func presentSelectedAlgorithmName(_ algorithmName: String)
    func presentSelectedShift(_ shift: Int)
    func presentShiftPicker()
    func presentKeyInputTextField()
    func presentKeyLenghtError()
    func hideShiftPicker()
    func hideKeyInputTextField()
    func presentTwoKeysInputFields()
    func presentTwoKeysError()
    func hideTwoKeysInputFields()
}

class MainViewInteractor {
    
    let presenter: MainViewPresentingLogic
    
    private var algorithm: CypherAlgorithm?
    
    init(presenter: MainViewPresentingLogic) {
        self.presenter = presenter
    }
}

extension MainViewInteractor: MainViewBusinessLogic {

    
    func selectAlgorithmButtonDidTapped() {
        presenter.hideKeyInputTextField()
        presenter.hideTwoKeysInputFields()
        presenter.presentAlgorithmPicker()
    }
    
    func encrypt(_ text: String) {
        guard let algorithm = algorithm else {
            presenter.presentAlgorithmNotSelected()
            return
        }
        
        do {
            let encryptedText = try algorithm.encrypt(text)
            presenter.presentOutputText(encryptedText)
        } catch CypherError.invalidKeyLenght {
            presenter.presentKeyLenghtError()
        } catch {
            // TODO: Unknown error handling
        }
    }
    
    func decrypt(_ text: String) {
        guard let algorithm = algorithm else {
            presenter.presentAlgorithmNotSelected()
            return
        }
        
        do {
            let decryptedText = try algorithm.decrypt(text)
            presenter.presentOutputText(decryptedText)
        } catch CypherError.invalidKeyLenght {
            presenter.presentKeyLenghtError()
        } catch {
            // TODO: Unknown error handling
        }
    }
    
    func algorithmDidSelected(_ algorithm: String) {
        guard let algorithm = AvailableCypherAlgorithm(rawValue: algorithm) else { return }
        presenter.hideAlgorithmPicker()
        presenter.presentSelectedAlgorithmName(algorithm.rawValue)
        
        switch algorithm {
        case .caesar:
            presenter.presentShiftPicker()
        case .vigenere:
            presenter.presentKeyInputTextField()
        case .affine:
            presenter.presentTwoKeysInputFields()
        case .playfair:
            algorithm = PlayfairCipher()
        }
    }
    
    func shiftDidSelected(_ shift: Int) {
        algorithm = CeasarCipher(shift: shift)
        presenter.hideShiftPicker()
        presenter.presentSelectedShift(shift)
    }
    
    func keyDidEntered(_ key: String) {
        algorithm = VigenereCipher(key: key)
    }
    
    func twoKeysDidEntered(keyA: String, keyB: String) {
        guard let keyA = Int(keyA),
            let keyB = Int(keyB) else {
                presenter.presentTwoKeysError()
                return
        }
        
        algorithm = AffineCipherAlgorithm(keyA: keyA, keyB: keyB)
    }
}
