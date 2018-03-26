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
    
    @IBAction func updateExtension(_ sender: AnyObject) {
        if let fData = fileData {
            fData.ext = extensionMenu.titleOfSelectedItem!
            NSFileCoordinator.removeFilePresenter(fData)
            NSFileCoordinator.addFilePresenter(fData)
            print(fData.ext)
        }
    }

    @IBAction func loadFile(_ sender: AnyObject) {
        print("Load file")
        
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        
        
        panel.beginSheetModal (for: self.view.window!) { result in
            let path = panel.url?.path ?? ""
            self.fileData = FileData(path: path)
            self.filenameLabel.stringValue = path
            NSFileCoordinator.addFilePresenter(self.fileData!)
            self.writeButton.isEnabled = true
            return
        }
        
    }

    @IBAction func writeFile(_ sender: AnyObject) {
        if let fData = fileData, let url = fData.presentedItemURL {
            var errorMain: NSError?
            let coord = NSFileCoordinator(filePresenter: fData)
            coord.coordinate(writingItemAt: url as URL, options: .forReplacing, error: &errorMain, byAccessor: { writeUrl in
                print("Write File")
                do {
                    try "Stuff to write in the file".write(toFile: writeUrl.path, atomically: true, encoding: String.Encoding.utf8)

                } catch {
                    print("Error writing to file: \(error)")
                }
                return
            })
        }
    }
}

