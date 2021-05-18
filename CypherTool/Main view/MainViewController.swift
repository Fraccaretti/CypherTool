//
//  MainViewController.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import UIKit

protocol MainViewBusinessLogic {
    func selectAlgorithmButtonDidTapped()
    func encrypt(_ text: String)
    func decrypt(_ text: String)
    func algorithmDidSelected(_ algorithm: String)
    func shiftDidSelected(_ shift: Int)
    func keyDidEntered(_ key: String)
    func twoKeysDidEntered(keyA: String, keyB: String)
}

class MainViewController: UIViewController {

    private let marginConstant: CGFloat = 32
    private let animationsQueue: OperationQueue = OperationQueue()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var interactor: MainViewBusinessLogic!
    var configurator: MainViewControllerConfigurator!
    
    private var selectedPickerView: UIPickerView?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var selectAlgorithmButton: UIButton!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var algorithmPickerView: UIPickerView!
    @IBOutlet weak var shiftPickerView: UIPickerView!
    @IBOutlet weak var keyInputTextField: UITextField!
    @IBOutlet weak var keyInputTextFieldContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyInputTextFieldContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyAInputTextField: UITextField!
    @IBOutlet weak var keyBInputTextField: UITextField!
    @IBOutlet weak var twoKeysInputContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var twoKeysInputContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerViewTitleLabel: UILabel!
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var pickerViewDoneButton: UIButton!
    @IBOutlet weak var pickerViewContainerTopBar: UIView!
    @IBOutlet weak var pickerViewContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var replaceTextsButton: UIButton!
    
    // MARK: - ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(self)
        hideKeyboardWhenTappedAround()
    }

    // MARK: - IBActions
    
    @IBAction func onSelectAlgorithmButtonTapped(_ sender: Any) {
        selectAlgorithmButton.layer.borderColor = UIColor.aqua.cgColor
        selectAlgorithmButton.titleLabel?.textColor = .aqua
        interactor.selectAlgorithmButtonDidTapped()
    }
    
    @IBAction func onEncryptButtonTapped(_ sender: UIButton) {
        interactor.encrypt(inputTextView.text)
    }
    
    @IBAction func onDecryptButtonTapped(_ sender: UIButton) {
        interactor.decrypt(inputTextView.text)
    }
    
    @IBAction func onPickerViewDoneButtonTapped(_ sender: Any) {
        guard let selectedPickerView = selectedPickerView else { return }
        let selectedRow = selectedPickerView.selectedRow(inComponent: 0)
        
        switch selectedPickerView.tag {
        case 1:
            interactor.algorithmDidSelected(CypherAlgorithmsConstants.availableAlgorithmsNames[selectedRow])
        case 2:
            interactor.shiftDidSelected(selectedRow + 1)
        default: return
        }
    }
    
    @IBAction func onReplaceTextsButtonTapped(_ sender: UIButton) {
        let temp = inputTextView.text
        inputTextView.text = outputTextView.text
        outputTextView.text = temp
    }
    
    // MARK: - Animations
    
    private func showPickerView(animated: Bool) {
        if animated {
            animationsQueue.addOperation {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.pickerViewContainerBottomConstraint.constant = 0
                        self.view.layoutIfNeeded()
                    }
                }
            }
        } else {
            self.pickerViewContainerBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func hidePickerView(animated: Bool) {
        if animated {
            animationsQueue.addOperation {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.pickerViewContainerBottomConstraint.constant =
                            (self.pickerViewContainer.frame.size.height +
                                self.pickerViewContainerTopBar.frame.size.height +
                                50) * -1
                        self.view.layoutIfNeeded()
                    }
                }
            }
        } else {
            self.pickerViewContainerBottomConstraint.constant =
                (self.pickerViewContainer.frame.size.height +
                self.pickerViewContainerTopBar.frame.size.height +
                50) * -1
            self.view.layoutIfNeeded()
        }
    }
    
    private func showKeyInputContainer(animated: Bool) {
        twoKeysInputContainerTopConstraint.isActive = false
        twoKeysInputContainerBottomConstraint.isActive = false
        keyInputTextField.isHidden = false
        if animated {
            animationsQueue.addOperation {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.keyInputTextField.alpha = 1
                        self.keyInputTextFieldContainerTopConstraint.constant = self.marginConstant
                        self.view.layoutIfNeeded()
                    }
                }
            }
        } else {
            self.keyInputTextFieldContainerTopConstraint.constant = self.marginConstant
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideKeyInputContainer(animated: Bool) {
        keyInputTextField.isHidden = true
        if animated {
            animationsQueue.addOperation {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.keyInputTextField.alpha = 0
                        self.keyInputTextFieldContainerTopConstraint.constant = -1 * self.keyInputTextField.frame.size.height
                        self.view.layoutIfNeeded()
                    }
                }
            }
        } else {
            self.keyInputTextFieldContainerTopConstraint.constant = -1 * self.keyInputTextField.frame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    private func showTwoKeysInputContainer(animated: Bool) {
        keyInputTextFieldContainerTopConstraint.isActive = false
        keyInputTextFieldContainerBottomConstraint.isActive = false
        if animated {
            animationsQueue.addOperation {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.keyAInputTextField.alpha = 1
                        self.keyBInputTextField.alpha = 1
                        self.twoKeysInputContainerTopConstraint.constant = self.marginConstant
                        self.view.layoutIfNeeded()
                    }
                }
            }
        } else {
            self.twoKeysInputContainerTopConstraint.constant = self.marginConstant
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideTwoKeysInputContainer(animated: Bool) {
        if animated {
                animationsQueue.addOperation {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3) {
                            self.keyAInputTextField.alpha = 0
                            self.keyBInputTextField.alpha = 0
                            self.twoKeysInputContainerTopConstraint.constant = -1 * self.keyInputTextField.frame.size.height
                            self.view.layoutIfNeeded()
                        }
                    }
                }
        } else {
            self.twoKeysInputContainerTopConstraint.constant = -1 * self.keyInputTextField.frame.size.height
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Presenter output extension

extension MainViewController: MainViewDisplayLogic {
    func displayTwoKeysInputFields(animated: Bool) {
        showTwoKeysInputContainer(animated: animated)
    }
    
    func hideTwoKeysInputFields(animated: Bool) {
        hideTwoKeysInputContainer(animated: animated)
    }
    

    func displayAlgorithmNotSelectedError() {
        selectAlgorithmButton.layer.borderColor = UIColor.pomegranate.cgColor
        selectAlgorithmButton.titleLabel?.textColor = .pomegranate
    }
    
    func displayOutputText(_ text: String) {
        outputTextView.text = text
    }
    
    func displayAlgorithmPicker(withTitle title: String, animated: Bool) {
        pickerViewTitleLabel.text = title
        algorithmPickerView.isHidden = false
        selectedPickerView = algorithmPickerView
        showPickerView(animated: animated)
    }
    
    func hideAlgorithmPicker(animated: Bool) {
        algorithmPickerView.isHidden = true
        selectedPickerView = nil
        hidePickerView(animated: animated)
    }
    
    func displaySelectedAlgorithmName(_ algorithmName: String) {
        selectAlgorithmButton.setTitle(algorithmName, for: .normal)
    }
    
    func displaySelectedShift(_ shift: String) {
        selectAlgorithmButton.setTitle((selectAlgorithmButton.titleLabel?.text ?? "").appending(shift), for: .normal)
    }
    
    func displayShiftPicker(withTitle title: String, animated: Bool) {
        pickerViewTitleLabel.text = title
        shiftPickerView.isHidden = false
        selectedPickerView = shiftPickerView
        showPickerView(animated: animated)
    }
    
    func hideShiftPicker(animated: Bool) {
        shiftPickerView.isHidden = true
        selectedPickerView = nil
        hidePickerView(animated: animated)
    }
    
    func displayKeyInputTextField(animated: Bool) {
        showKeyInputContainer(animated: animated)
    }
    
    func hideKeyInputTextField(animated: Bool) {
        hideKeyInputContainer(animated: animated)
    }
    
    func displayKeyLenghtError(withMessage message: String) {
        showAlert(withTitle: "Error", message: message)
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        present(alert, animated: true)
    }
}

// MARK: - PickerView data source extension

extension MainViewController: UIPickerViewDelegate {
    // ...
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return CypherAlgorithmsConstants.availableAlgorithmsNames.count
        case 2: return CypherAlgorithmsConstants.caesarShiftsCount
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var text: String = ""
        switch pickerView.tag {
        case 1: text = CypherAlgorithmsConstants.availableAlgorithmsNames[row]
        case 2: text = "\(row + 1)"
        default: text = ""
        }
        
        return NSAttributedString(string: text,
                                  attributes: [.foregroundColor: UIColor.black,
                                               .font: UIFont.getAppFont(withSize: 17, style: .light)])
    }
}

// MARK: - TextView delegate extension

extension MainViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

// MARK: - TextField delegate extension

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            interactor.keyDidEntered(textField.text ?? "")
        } else if textField.tag == 3 {
            interactor.twoKeysDidEntered(keyA: keyAInputTextField.text ?? "", keyB: keyBInputTextField.text ?? "")
        }
    }
}

// MARK: - ScrollView delegate extension

extension MainViewController: UIScrollViewDelegate {
    // ...
}
