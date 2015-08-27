//
//  FileData.swift
//  SandboxRelatedItemsDemo
//
//  Created by Stefano Vettor on 28/08/15.
//  Copyright (c) 2015 Stefano Vettor. All rights reserved.
//

import Foundation

class FileData: NSObject {
    var filePath: String
    var ext = "srt"
    
    init(path: String) {
        filePath = path
    }
}

// MARK: - NSFilePresenter
extension FileData: NSFilePresenter {
    var presentedItemURL: NSURL? {
        let range = filePath.rangeOfString(".", options:NSStringCompareOptions.BackwardsSearch)
        let baseName = filePath.substringToIndex((range?.startIndex)!)
        
        let altFilePath = baseName + "." + ext
        return NSURL(fileURLWithPath: altFilePath)
    }
    
    var primaryPresentedItemURL: NSURL? {
        return NSURL(fileURLWithPath: filePath)
    }
    
    var presentedItemOperationQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }
}