//
//  TestObject.swift
//  TestSwitf
//
//  Created by MAC MINI  on 5/12/16.
//  Copyright © 2016 MAC MINI . All rights reserved.
//

import UIKit
import QSerializableObject

class TestObject: QSerializableObject {
    
    let Serializable_Key_version = "version"
    let Serializable_Key_name = "test_name"
    
    var version = 1.0
    var name = "Test"
    
}
