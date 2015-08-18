//
//  ViewController.swift
//  SandboxRelatedItemsDemo
//
//  Created by Stefano Vettor on 18/08/15.
//  Copyright (c) 2015 Stefano Vettor. All rights reserved.
//

import Cocoa

class FileData: NSObject {
    var filePath: String
    var altFilePath: String
    
    init(path: String) {
        filePath = path
        let alt = path.substringToIndex(advance(path.endIndex, -3))
        altFilePath = alt + "srt"
        println(altFilePath)
    }
}

extension FileData: NSFilePresenter {
    var presentedItemURL: NSURL? {
        return NSURL(fileURLWithPath: filePath)
    }
    
    var primaryPresentedItemURL: NSURL? {
        return NSURL(fileURLWithPath: altFilePath)
    }
    
    var presentedItemOperationQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }
}

class ViewController: NSViewController {
    
    var fileData: FileData?
    @IBOutlet weak var filenameLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func loadFile(sender: AnyObject) {
        println("Load file")
        
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        
        
        panel.beginSheetModalForWindow (self.view.window!) { result in
            let path = panel.URL?.path ?? ""
            self.fileData = FileData(path: path)
            self.filenameLabel.stringValue = path
            //NSFileCoordinator.addFilePresenter(self.fileData!)
            return
        }
        
    }

    @IBAction func writeFile(sender: AnyObject) {
        var errorMain: NSError?
        let coord = NSFileCoordinator(filePresenter: fileData!)
        let url: NSURL = fileData!.presentedItemURL!
        coord.coordinateWritingItemAtURL(url, options: NSFileCoordinatorWritingOptions.allZeros, error: &errorMain, byAccessor: { writeUrl in
            println("Write File")
            var error: NSError?
            self.fileData?.filePath.writeToFile(self.fileData!.altFilePath, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
            return
        })
    }
}

