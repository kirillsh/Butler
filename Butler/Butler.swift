//
//  Butler.swift
//  Butler
//
//  Created by Nick O'Neill on 12/9/15.
//  Copyright © 2015 922am Burrito. All rights reserved.
//

import Foundation

//import Butler
//
//// this is a workaround to bring the extensions from Butler into
//// the rest of the project without having to declare `import Butler` everywhere
//typealias HelloButler = Butler

open class Butler {
    // basic test for valid email string
    open class func emailValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailTest.evaluate(with: email)
    }

    // easy to use delays
    open class func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
