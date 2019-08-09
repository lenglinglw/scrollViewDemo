//
//  LocalDataStorage.swift
//  swift-BatteryBox
//
//  Created by 苏强 on 2018/9/12.
//  Copyright © 2018年 苏强. All rights reserved.
//

import Foundation
class LocalDataStorage : NSObject {
    
    static let localDataStorage = LocalDataStorage()
    
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    class func storageDataAndKey (data: Any?, key: String) {

        if data == nil {
            
            UserDefaults.standard.removeObject(forKey: key)
            
        } else {
            
            UserDefaults.standard.set(data, forKey: key)
            /// 同步
            UserDefaults.standard.synchronize()
            
        }
        
    }
    /**
     通过对应的key移除储存
     - parameter key: 对应key
     */
    class func removeNormalData(key:String?) {
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     通过key找到储存的value
     - parameter key: key
     - returns: AnyObject
     */
    class func getNormalData(key:String)->Any?{
        
        return UserDefaults.standard.value(forKey: key)
        
    }
}
