//
//  UIHelpers.swift
//  CrptoWllet
//
//  Created by V K on 15.04.2023.
//

import UIKit
import SnapKit

//MARK: - UI Constants

struct UIConstants {
    
    static let w: CGFloat = UIScreen.main.bounds.width
    static let h: CGFloat = UIScreen.main.bounds.height
    static let cornerRad: CGFloat = 10
    static let wholeScreen: CGRect = UIScreen.main.bounds
    
}

//MARK: - Gradient Background

struct Gradient {
    
    static func makeLayer() -> CALayer {
        let gradient = CAGradientLayer()
        
        gradient.colors = [UIColor(hex: "67869B")?.withAlphaComponent(0.1).cgColor ?? UIColor.cyan.cgColor,
                           UIColor(hex: "2D4A58")?.withAlphaComponent(0.15).cgColor ?? UIColor.gray.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = UIConstants.wholeScreen
        
        return gradient
    }
    
}

//MARK: - Reusable UI Elements

struct Reusable {
    
    //MARK: - Labels
    
    static func label(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: UIConstants.w/30, weight: .medium)
        
        return label
    }
    
    static func label(text: String = "",
                      font: CGFloat = UIConstants.w/25,
                      textColor: UIColor = .black,
                      weight: UIFont.Weight = .bold) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = .systemFont(ofSize: font, weight: weight)
        
        return label
    }
    
    static func pctLabel(withPlate: Bool = true) -> UILabel {
        let label = Reusable.label()
        if withPlate {
            label.backgroundColor = UIColor(hex: "F2F2F6")
            label.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
            label.layer.shadowRadius = 5
            label.layer.shadowOpacity = 0.5
        } else {
            label.shadowColor = .white
            label.shadowOffset = .init(width: 2, height: 2)
        }
        
        return label
    }
    
    static func rankLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.w/35, weight: .semibold)
        label.backgroundColor = UIColor(hex: "ECECEC")
        label.layer.shadowColor = UIColor(hex: "2d4a58")?.cgColor
        label.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(2.0))
        label.layer.shadowRadius = UIConstants.cornerRad
        label.layer.shadowOpacity = 0.8
        label.textAlignment = .center
        
        label.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w/21)
            make.height.greaterThanOrEqualTo(UIConstants.w/21)
        }
        
        return label
    }
    
    //MARK: - Symbol ImageView
    
    static func symbolImage(width: CGFloat) -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
        
        return image
    }
    
    //MARK: - StackViews
    
    static func hStack(_ left: UILabel,
                       _ right: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [left, right])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w*0.85)
        }
        
        return stackView
    }
    
    static func hStack(_ left: UILabel,
                       _ right: UILabel,
                       _ additional: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [left, right, additional])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.setCustomSpacing(15, after: right)
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w*0.85)
        }
        
        return stackView
    }
    
    //MARK: - TextField
    
    static func textField(placeholder: String, isSecure: Bool) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .black
        textField.placeholder = placeholder
        textField.layer.cornerRadius = UIConstants.cornerRad
        textField.isSecureTextEntry = isSecure
        textField.textAlignment = .center
        textField.keyboardType = .asciiCapableNumberPad
        
        return textField
    }
    
}
