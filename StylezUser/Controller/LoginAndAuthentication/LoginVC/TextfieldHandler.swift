//
//  TextfieldHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
import UIKit

//MARK: - textfield extension
extension LoginViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch textField {
        case txtPhone :
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: "0123456789") &&
            prospectiveText.count <= 9
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}
