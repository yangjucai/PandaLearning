//
//  EditableTextCell.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/8/26.
//

import UIKit

class EditableTextCell: UITableViewCell, UITextFieldDelegate {
    
    var textField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .next
        return field
    }()
    
    var completionHandler: (() -> ())?
    
    func setup() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        completionHandler = {self.textField.resignFirstResponder()}
        self.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.selectionStyle = .none
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        completionHandler?()
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
