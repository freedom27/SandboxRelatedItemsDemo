//
//  ViewController.swift
//  SandboxRelatedItemsDemo
//
//  Created by Stefano Vettor on 18/08/15.
//  Copyright (c) 2015 Stefano Vettor. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var fileData: FileData?
    @IBOutlet weak var filenameLabel: NSTextField!
    @IBOutlet weak var extensionMenu: NSPopUpButton!
    @IBOutlet weak var writeButton: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func updateExtension(sender: AnyObject) {
        if let fData = fileData {
            fData.ext = extensionMenu.titleOfSelectedItem!
            NSFileCoordinator.removeFilePresenter(fData)
            NSFileCoordinator.addFilePresenter(fData)
            print(fData.ext)
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
            NSFileCoordinator.addFilePresenter(self.fileData!)
            self.writeButton.enabled = true
            return
        }
        
    }

    @IBAction func writeFile(sender: AnyObject) {
        if let fData = fileData, let url = fData.presentedItemURL {
            var errorMain: NSError?
            let coord = NSFileCoordinator(filePresenter: fData)
            coord.coordinateWritingItemAtURL(url, options: NSFileCoordinatorWritingOptions.allZeros, error: &errorMain, byAccessor: { writeUrl in
                println("Write File")
                var error: NSError?
                "Stuff to write in the file".writeToFile(writeUrl.path!, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
                return
            })
        }
    }
}

