import Foundation

func printFileSystem(atPath path: String, prefix: String, isLastItem: Bool) {
    let fileManager = FileManager.default
    let url = URL(fileURLWithPath: path)
    var isDirectory: ObjCBool = false
    
    if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
        let itemPrefix = isLastItem ? "└─ " : "├─ "
        print("\(prefix)\(itemPrefix)\(url.lastPathComponent)")
        
        if isDirectory.boolValue {
            do {
                let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
                let itemCount = contents.count
                
                for (index, item) in contents.enumerated() {
                    let isLast = (index == itemCount - 1)
                    let subPrefix = isLastItem ? "\(prefix)    " : "\(prefix)│   "
                    
                    printFileSystem(atPath: item.path, prefix: subPrefix, isLastItem: isLast)
                }
            } catch {
                print("Error accessing contents of directory: \(error)")
            }
        }
    } else {
        print("Invalid path: \(path)")
    }
}

let path = "/Users/dogusguleryuz/Desktop/MiniProject"
printFileSystem(atPath: path, prefix: "", isLastItem: true)
