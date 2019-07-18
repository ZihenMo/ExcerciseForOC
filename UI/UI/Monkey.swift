//
//  Person.swift
//  UI
//
//  Created by gshopper on 2019/7/17.
//  Copyright © 2019 mozihen. All rights reserved.
//

import Foundation
import SwiftMonkeyPaws

@objcMembers
class Monkey: NSObject {
    
    public static func getPaws(_ view: UIView) -> MonkeyPaws {
         return MonkeyPaws(view: view, tapUIApplication: true);
    }
}
