//
//  Custom+UIButton.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright © 2020 Amanda. All rights reserved.
//

import UIKit

@IBDesignable
final class CustomButton: UIButton {

    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
         super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 20.0
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//        self.isButtonDisable()
    }
    
    func isButtonDisable() {
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.2)
    }
    
    func isButtonEnable() {
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
    }
    

}
