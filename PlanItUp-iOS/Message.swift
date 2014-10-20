//
//  Message.swift
//  PlanItUp-iOS
//
//  Created by Mitch Herrema on 10/18/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

import Foundation

struct Message {
    let messageId : Int
    let sendingUser : Int
    let receivingUser : [Int]
    let dateTime : NSDate
    let content : String
}