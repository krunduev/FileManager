//
//  ViewController.swift
//  FileManager
//
//  Created by Kostyantyn Runduyev on 8/8/17.
//  Copyright © 2017 CuriousIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    let fileName = "file.txt"
    
    func checkDirectory() -> String? {
        do {
            
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

            let filesInDirectory = try fileManager.contentsOfDirectory(atPath: documentPath)
            
            let files = filesInDirectory
            if files.count > 0 {
                if files.first == fileName {
                    print("file.txt found")
                    return files.first
                } else {
                    print("File not found")
                    return nil
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    @IBAction func createFileBtnPressed(sender: AnyObject) {
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let path = (documentPath as NSString).appendingPathComponent(fileName)
        
        let contentsOfFile = "Some Text Here"
        
        // Записываем в файл
        do {
            try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            print("File text.txt created at temp directory")
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    @IBAction func viewDirectoryBtnPressed(sender: AnyObject) {
        // Смотрим содержимое папки
        let directoryWithFiles = checkDirectory() ?? "Empty"
        print("Contents of Directory =  \(directoryWithFiles)")
    }
    
    @IBAction func readFileBtnPressed(sender: AnyObject) {
        
        // Читаем
        let directoryWithFiles = checkDirectory() ?? "Empty"
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = (documentPath as NSString).appendingPathComponent(directoryWithFiles)
        
        do {
            let contentsOfFile = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            print("content of the file is: \(contentsOfFile)")
        } catch let error as NSError {
            print("there is an file reading error: \(error)")
        }
    }
    
    @IBAction func deleteFileBtnPressed(sender: AnyObject) {
        
        let directoryWithFiles = checkDirectory() ?? "Empty"
        do {
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let path = (documentPath as NSString).appendingPathComponent(directoryWithFiles)
            try fileManager.removeItem(atPath: path)
            print("file deleted")
        } catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
    }
    
    @IBAction func viewRecource(_ sender: Any) {
        let fileNmae = "test2"
        
        let path = Bundle.main.path(forResource: fileNmae, ofType: "txt")
        let path1 = Bundle.main.path(forResource: fileNmae, ofType: "txt", inDirectory: "Resource")
        do {
            let content = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            try fileManager.attributesOfItem(atPath: path!)
            print(content)
            
            let fileUrl = NSURL(fileURLWithPath: path!)
            var modified: AnyObject?
            try fileUrl.getResourceValue(&modified, forKey: URLResourceKey.contentModificationDateKey)

            print(modified as! Date)
            
        } catch {
            print("nil")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

