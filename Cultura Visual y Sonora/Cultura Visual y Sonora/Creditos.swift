//
//  Creditos.swift
//  Cultura Visual y Sonora
//
//  Created by Fabiola Valdez on 24/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Creditos: UIViewController {

    @IBOutlet weak var tvCreditos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        var maximoFont: CGFloat
        
        if (width > 1125) {
            maximoFont = 30
        }
        else {
            maximoFont = 18
        }
        ajustarFontSize(textView: tvCreditos, bold: true, maxSize: maximoFont)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func ajustarFontSize(textView: UITextView, bold: Bool, maxSize: CGFloat) -> Void {
        let maxFontSize: CGFloat = maxSize
        let minFontSize: CGFloat = 10

        if bold {
            textView.font = UIFont(name: "HelveticaNeue-Bold", size: maxFontSize)!
        }
        else {
            textView.font = UIFont(name: "HelveticaNeue", size: maxFontSize)!
        }
        
        /*
        textView.adjustsFontSizeToFitWidth = true
        textView.minimumScaleFactor = minFontSize/maxFontSize
        */
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
