//
//  JSONConvertible.swift
//Copyright (c) 2017 Jaysukh. All rights reserved.


import Foundation
import SwiftyJSON

protocol JSONConvertible {
    associatedtype JsonConvertible
    
    static func fromJSON(json: JSON) -> JsonConvertible
    func toJSON() -> JSON
}

extension JSONConvertible {
    func toJSON() -> JSON {
        let jsonDict = [String : Any]()
        
        return JSON(jsonDict)
    }
}
