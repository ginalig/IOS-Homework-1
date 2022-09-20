//
//  ViewController.swift
//  Homework-1
//
//  Created by Сашка Нигай on 19.09.2022.
//

import UIKit
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var changeColorButton: UIButton!
    @IBOutlet var views: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeColorButton.layer.cornerRadius = changeColorButton.bounds.height / 4
    }
    func generateHex() -> String {
        let hexChars = ["a", "b", "c", "d", "f", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "e"]
        var hex = "#"
        for _ in 1...8 {
            hex += hexChars[Int.random(in: 0...15)]
        }
        return hex
    }
    
    @IBAction func ChangeColorButtonTouched(_ sender: Any) {
        func getRandomValue() -> CGFloat {
            return CGFloat.random(in: 0 ..< 256) / 255
        }
        let button = sender as? UIButton
        button?.isEnabled = false
        
        var set = Set<UIColor>()
        for _ in 1...views.count {
            set.insert(UIColor(hex: generateHex())!)
        }
        UIView.animate(withDuration: 0.2, animations: {
            for view in self.views {
                view.backgroundColor = set.popFirst()
                
                view.layer.cornerRadius =
                CGFloat.random(in: 0 ... view.bounds.height / 2)
            }
            
        }) {
            completion in button?.isEnabled = true
        }
    }
    
}

