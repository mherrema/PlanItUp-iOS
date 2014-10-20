//
//  Task.swift
//  PlanItUp-iOS
//
//  Created by Mitch Herrema on 10/18/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

import Foundation

struct Task {
    let taskId : Int
    let name : String
    let description : String
    let projectId : Int
    let dueDate : NSDate
    let rating : Int
    let userID : Int
    let status : String
}