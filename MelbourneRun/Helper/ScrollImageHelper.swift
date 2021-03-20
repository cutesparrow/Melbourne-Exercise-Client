//
//  ScrollImageHelper.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import Foundation


func getScrollImageList(images:[String]) -> [ScrollImage] {
    let length = images.count
    var result:[ScrollImage] = []
    for id in 0..<length{
        result.append(ScrollImage(id: id, image: images[id]))
    }
    return result
}
