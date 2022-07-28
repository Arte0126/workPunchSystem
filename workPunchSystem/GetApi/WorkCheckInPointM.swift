//
//  WorkCheckInPointM.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/15.
//

import Foundation
struct WorkCheckInPointM:Encodable {
    var uid:String = ""
    var lat:String = ""
    var lng:String = ""
    init(uid:String,lat:String,lng:String)
    {
        self.uid = uid
        self.lat = lat
        self.lng = lng
    }
}
