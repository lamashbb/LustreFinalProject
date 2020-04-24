//
//  StyleButton.swift
//  lustreProj
//
//  Created by Shahad X on 03/07/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

class StyleButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
      //  layer.borderWidth  = 1/UIScreen.main.nativeScale
        layer.cornerRadius = frame.height/6
    }
}
