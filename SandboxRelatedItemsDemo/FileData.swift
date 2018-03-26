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
    var presentedItemURL: URL? {
        let range = filePath.range(of: ".", options:NSString.CompareOptions.backwards)
        let baseName = String(filePath[..<range!.lowerBound])

        let altFilePath = baseName + "." + ext
        return URL(fileURLWithPath: altFilePath)
    }
    
    var primaryPresentedItemURL: URL? {
        return URL(fileURLWithPath: filePath)
    }
    
    var presentedItemOperationQueue: OperationQueue {
        return OperationQueue.main
    }
}
