//
//  User.swift
//  PlanItUp-iOS
//
//  Created by Mitch Herrema on 10/18/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

import Foundation

struct User {
    let userId : Int
    let firstName : String
    let lastName : String
    let email : String
    let phone : String
    let projects : [Project]
    let availablility : [Availability]
}