//
//  Discussion.swift
//  PlanItUp-iOS
//
//  Created by Mitch Herrema on 10/18/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

import Foundation

struct Discussion {
    let discussionID : Int
    let projectID : Int
    let subject : String
    let taskID : [Task]
    let content : [DiscussionItem]
    let lastModified : NSDate
}