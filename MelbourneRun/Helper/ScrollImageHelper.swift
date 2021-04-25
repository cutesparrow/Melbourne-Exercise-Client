//
//  ScrollImageHelper.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation

//translate string into SCroll image object
func getScrollImageList(images:[ImageCore]) -> [ScrollImage] {
    let length = images.count
    var result:[ScrollImage] = []
    for id in 0..<length{
        result.append(ScrollImage(id: id, image: images[id].name))
    }
    return result
}
