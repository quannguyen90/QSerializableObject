//
//  QSerializable.swift
//  TestSwitf
//
//  Created by MAC MINI  on 5/12/16.
//  Copyright © 2016 MAC MINI . All rights reserved.
//

import UIKit

protocol Reflectable {
    func propertys()->[String]
}

extension Reflectable
{
    func propertys()->[String]{
        var s = [String]()
        for c in Mirror(reflecting: self).children
        {
            if let name = c.label{
                s.append(name)
            }
        }
        return s
    }
    
    func getKeySeriable() -> [String] {
        var s = [String]()
        for c in Mirror(reflecting: self).children
        {
            if let name = c.label where name.containsString("Serializable_Key_") {
                s.append("\(c.value)")
            }
        }
        
        return s
    }
    
    func getDictInfo() -> [String: AnyObject] {
        var s = [String: AnyObject]()
        for c in Mirror(reflecting: self).children
        {
            if let name = c.label where name.containsString("Serializable_Key_") {
                let key = name.stringByReplacingOccurrencesOfString("Serializable_Key_", withString: "")
                let value = getValueOfPopertyValueWithKey(key)
                let keySeriable = c.value as! String
                s[keySeriable] = value
            }
        }
        return s
    }
    
    func getValueOfPopertyValueWithKey(key: String) -> AnyObject? {
        for c in Mirror(reflecting: self).children
        {
            if let name = c.label where name == key {
                return c.value as? AnyObject
            }
        }
        return nil
    }
    
    func checkKeyPath(keyPath: String) -> Bool {
        let children = Mirror(reflecting: self).children.filter({$0.label == keyPath})
        if children.count > 0 {
            return true
        }
        return false
    }
    
    func getKeyPathOfValuePropertyValueWithKey(key: String) -> String? {
        for c in Mirror(reflecting: self).children
        {
            if let name = c.value as? String where name == key {
                if let key = c.label {
                    let replaceKey = key.stringByReplacingOccurrencesOfString("Serializable_Key_", withString: "")
                    if checkKeyPath(replaceKey) {
                        return replaceKey
                    } else {
                        assertionFailure("Key '\(replaceKey)' is not exist but  Serizable Key '\(key)' is existed")
                    }
                }
            }
        }
        return nil
    }
    
}

public class QSerializableObject: NSObject, Reflectable {

    public convenience init(withDictData dict: [String: AnyObject]) {
        self.init()
        
        for (key, value) in dict {
            if let keyPath = getKeyPathOfValuePropertyValueWithKey(key) {
                self.setValue(value, forKeyPath: keyPath)
            }
        }
    }
    
    func jsonString() -> String {
        let dataArchive = getDictInfo()
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dataArchive, options: NSJSONWritingOptions())
            let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as! String
            return jsonString
        } catch _ {
        }
        return ""
    }
    
    override public var description: String {
        get {
            return jsonString()
        }
    }
}

