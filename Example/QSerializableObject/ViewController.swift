//
//  ViewController.swift
//  QSerializableObject
//
//  Created by Quan Nguyen Van on 05/13/2016.
//  Copyright (c) 2016 Quan Nguyen Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonObject1 = ["version": 1.0, "name": "loading"]
        let test1 = TestObject(withDictData:jsonObject1)
        
        let jsonObject2 = ["version": 2.0, "name": "view"]
        let test2 = TestObject(withDictData:jsonObject2)
        
        let jsonObject3 = ["version": 3.0, "name": "typically"]
        let test3 = TestObject(withDictData:jsonObject3)
        
        let jsonObject4 = ["version": 4.0, "name": "from"]
        let test4 = TestObject(withDictData:jsonObject4)
        
        let array = [test1, test2, test3, test4]
        print(array)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

