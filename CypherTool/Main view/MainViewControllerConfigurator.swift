//
//  MainViewControllerConfigurator.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 30/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import UIKit

class MainViewControllerConfigurator {
    
    private let checkmarkImageName: String = "Checkmark"
    private let textViewsCornerRadiusValue: CGFloat = 10
    private let localizations: MainViewLocalizations
    
    init(localizations: MainViewLocalizations) {
        self.localizations = localizations
    }
    
    func configure(_ viewController: MainViewController) {
        configureViews(in: viewController)
    }
    
    private func configureViews(in viewController: MainViewController) {
        viewController.title = localizations.viewControllerTitle
        configureNavigationBar(in: viewController)
        configureBackground(in: viewController)
        configureButtons(in: viewController)
        configureTextViews(in: viewController)
        configureTextField(in: viewController)
        configurePickerView(in: viewController)
    }
    
    private func configureScrollView(in viewController: MainViewController) {
        viewController.scrollView.delegate = viewController
        viewController.scrollView.isScrollEnabled = true
    }
    
    private func configureNavigationBar(in viewController: MainViewController) {
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        viewController.navigationController?.navigationBar.isTranslucent = true
        viewController.navigationController?.view.backgroundColor = .clear
    }
    
    private func configureBackground(in viewController: MainViewController) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewController.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.insertSubview(blurEffectView, at: 1)
    }
    
    private func configureButtons(in viewController: MainViewController) {
        let buttonsFont = UIFont.getAppFont(withSize: 17, style: .bold)
        
        viewController.selectAlgorithmButton.roundCorners(withMultiplier: 0.5)
        viewController.selectAlgorithmButton.setOutlinedStyle(withBorderWidth: 2, borderColor: .aqua)
        viewController.selectAlgorithmButton.backgroundColor = .mercuryTransparent
        viewController.selectAlgorithmButton.setTitleColor(.aqua, for: .normal)
        viewController.selectAlgorithmButton.titleLabel?.font = buttonsFont
        viewController.selectAlgorithmButton.setTitle(localizations.selectAlgorithmText.uppercased(), for: .normal)
        
        viewController.encryptButton.roundCorners(withMultiplier: 0.5)
        viewController.encryptButton.backgroundColor = .aqua
        viewController.encryptButton.setTitleColor(.white, for: .normal)
        viewController.encryptButton.titleLabel?.font = buttonsFont
        viewController.encryptButton.setTitle(localizations.encryptText.uppercased(), for: .normal)
        
        viewController.decryptButton.roundCorners(withMultiplier: 0.5)
        viewController.decryptButton.backgroundColor = .aqua
        viewController.decryptButton.setTitleColor(.white, for: .normal)
        viewController.decryptButton.titleLabel?.font = buttonsFont
        viewController.decryptButton.setTitle(localizations.decryptText.uppercased(), for: .normal)
        
        viewController.pickerViewDoneButton.roundCorners(withMultiplier: 0.5)
        viewController.pickerViewDoneButton.backgroundColor = .aqua
        viewController.pickerViewDoneButton.setImage(UIImage(named: checkmarkImageName), for: .normal)
        
        viewController.replaceTextsButton.roundCorners(withMultiplier: 0.5)
        viewController.replaceTextsButton.setOutlinedStyle(withBorderWidth: 2, borderColor: .aqua)
        viewController.replaceTextsButton.backgroundColor = .mercuryTransparent
        viewController.replaceTextsButton.setTitleColor(.aqua, for: .normal)
        viewController.replaceTextsButton.titleLabel?.font = buttonsFont
        viewController.replaceTextsButton.setTitle(localizations.replaceTextsText.uppercased(), for: .normal)
    }
    
    private func configureTextViews(in viewController: MainViewController) {
        let textViewsFont = UIFont.getAppFont(withSize: 17, style: .light)
        let textViews: [UITextView] = [viewController.inputTextView, viewController.outputTextView]
        
        for textView in textViews {
            textView.delegate = viewController
            textView.layer.cornerRadius = textViewsCornerRadiusValue
            textView.setOutlinedStyle(withBorderWidth: 2, borderColor: .aqua)
            textView.font = textViewsFont
            textView.textColor = .black
            textView.backgroundColor = .mercuryTransparent
            textView.autocapitalizationType = .allCharacters
            textView.textContainerInset = UIEdgeInsets(top: 8, left: 2, bottom: 8, right: 2)
        }
        
        viewController.inputTextView.text = localizations.inputTextViewPlaceholder.uppercased()
        viewController.outputTextView.text = localizations.outputTextViewPlaceholder.uppercased()
        viewController.inputTextView.tag = 1
        viewController.outputTextView.tag = 2
    }
    
    private func configureTextField(in viewController: MainViewController) {
        let map = [viewController.keyInputTextField, viewController.keyAInputTextField, viewController.keyBInputTextField]
        var tag = 1
        for textField in map {
            textField?.font = UIFont.getAppFont(withSize: 17, style: .light)
            textField?.delegate = viewController
            textField?.textColor = .black
            textField?.layer.cornerRadius = textViewsCornerRadiusValue
            textField?.setOutlinedStyle(withBorderWidth: 2, borderColor: .aqua)
            textField?.backgroundColor = .mercuryTransparent
            textField?.autocapitalizationType = .allCharacters
            textField?.alpha = 0
            textField?.tag = tag
            tag += 1
        }
        viewController.keyInputTextFieldContainerTopConstraint.constant = -1 * viewController.keyInputTextField.frame.size.height
        viewController.twoKeysInputContainerTopConstraint.constant = -1 * viewController.keyInputTextField.frame.size.height
        
        viewController.keyInputTextField.attributedText = NSAttributedString(string: localizations.enterCypherKey.uppercased(),
                                                                             attributes: [.foregroundColor: UIColor.darkGray])
        viewController.keyAInputTextField.attributedText = NSAttributedString(string: localizations.enterCypherKeyA.uppercased(),
                                                                              attributes: [.foregroundColor: UIColor.darkGray])
        viewController.keyBInputTextField.attributedText = NSAttributedString(string: localizations.enterCypherKeyB.uppercased(),
                                                                              attributes: [.foregroundColor: UIColor.darkGray])
    }
    
    private func configurePickerView(in viewController: MainViewController) {
        viewController.algorithmPickerView.delegate = viewController
        viewController.algorithmPickerView.dataSource = viewController
        viewController.algorithmPickerView.tag = 1
        viewController.shiftPickerView.delegate = viewController
        viewController.shiftPickerView.dataSource = viewController
        viewController.shiftPickerView.tag = 2
        viewController.pickerViewContainerTopBar.backgroundColor = .mercuryTransparent
        viewController.pickerViewContainer.backgroundColor = .white
        viewController.pickerViewTitleLabel.font = UIFont.getAppFont(withSize: 17, style: .regular)
        viewController.pickerViewTitleLabel.textColor = .black
    }
}
