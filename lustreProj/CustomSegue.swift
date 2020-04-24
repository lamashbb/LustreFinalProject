//
//  CustomSegue.swift
//  lustreProj
//
//  Created by Shahad X on 07/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

public class CustomSegue: UIStoryboardSegue {
    override public func perform(){
        let src = self.source
        let dst = self.destination
        src.navigationController?.pushViewController(dst, animated: true)
        
        
        
        
    }
    
    
    
    
    
}
