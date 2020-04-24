//
//  review.swift
//  lustreProj
//
//  Created by lam  on 4/24/20.
//  Copyright © 2020 lam . All rights reserved.
//

import Foundation

import UIKit

class review: NSObject {
    
    var date = ""
    var name = ""
    var rating = ""
    var review = ""
    
    override init() {
    
    }
    
    init(name : String , date : String , rating : String , review : String) {
        self.name = name
        self.date = date
        self.rating = rating
        self.review = review
        }
    }


