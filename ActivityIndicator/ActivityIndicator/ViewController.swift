//
//  ViewController.swift
//  ActivityIndicator
//
//  Created by Arken Sarsenov on 01.04.2022.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class ViewController: UIViewController {
    
    //MARK: - Properties
    var index = 0
    let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), type: .ballPulseSync, color: .systemBlue, padding: 10)
    let titleTextField:UITextField = {
        let tf = UITextField()
        let placeholderColor = NSAttributedString(string: "Write Title",
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.5)])
        tf.attributedPlaceholder = placeholderColor
        tf.setHeight(50)
        tf.textColor = .white
        tf.tintColor = .white
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        return tf
    }()    
    let typePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.setValue(UIColor.white, forKey: "textColor")
        return picker
    }()
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Start Activity Indicator", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(startIndicator), for: .touchUpInside)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.setHeight(50)
        button.layer.cornerRadius = 8
        return button
    }()
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    let colorsArr: [UIColor] = [.white, .red, .blue, .yellow, .black, .systemPink]
    
    //MARK: - Livecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        typePicker.delegate = self
        typePicker.dataSource = self
    }
    
    //MARK: - Action
    
    @objc func startIndicator() {
        let size = CGSize(width: 35, height: 35)
        activityIndicator.type = presentingIndicatorTypes[index]
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.showAnimation {
            let selectedIndicatorIndex = sender.tag
            self.activityIndicator.color = self.colorsArr[selectedIndicatorIndex]
        }
    }
    
    //MARK: - Configure UI
    
    func configureUI() {
        configureGradientLayer()
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 5
        for index in 0..<colorsArr.count {
            let button = UIButton(type: .system)
            button.backgroundColor = colorsArr[index]
            button.tag = index
            button.setHeight(50)
            button.setWidth(50)
            button.layer.cornerRadius = 50/2
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            button.layer.shadowOpacity = 5
            button.layer.shadowRadius = 5.0
            button.addTarget(self,
                             action: #selector(buttonTapped(_:)),
                             for: .touchUpInside)
            buttonStack.addArrangedSubview(button)
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleTextField, activityIndicator, typePicker, applyButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        view.addSubview(buttonStack)
        buttonStack.centerX(inView: view)
        buttonStack.anchor(top: stackView.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 32, paddingBottom: 32)
        

    }
}

//MARK: - UIPickerDelegare and dataSaource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presentingIndicatorTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = "\(presentingIndicatorTypes[row])"
        return row
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row

    }
}
