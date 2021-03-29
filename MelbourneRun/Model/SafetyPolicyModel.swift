//
//  SafetyPolicyModel.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 29/3/21.
//

import Foundation


struct SafetyPolicy:Codable,Identifiable{
    var id:Int
    var date:String
    var title:String
    var content:String
}
