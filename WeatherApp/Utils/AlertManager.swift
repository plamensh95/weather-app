//
//  AlertManager.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 31.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//
import UIKit

class AlertManager {
    
    static let sharedInstance = AlertManager()
    
    private init(){}
    
    func showErrorAlert(with title: String? = nil, message: String) {
        UIAlertController(title: title ?? Title.kErrorOccurred, message: message,
                          defaultActionButtonTitle: Title.kOK, tintColor: .blue).show()
    }
    
    func showInputAlert(with title: String? = nil, message: String,
                        inputPlaceholder: String, inputCompletion: @escaping (String?) -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(placeholder: inputPlaceholder,
                           editingChangedTarget: nil, editingChangedSelector: nil)
        alert.addAction(title: Title.kGO, style: .default, isEnabled: true) { action in
            inputCompletion(alert.textFields?.first?.text)
        }
        alert.show()
    }
}
