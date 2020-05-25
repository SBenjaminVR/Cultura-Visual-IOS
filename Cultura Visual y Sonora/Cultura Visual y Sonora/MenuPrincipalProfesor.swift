//
//  MenuPrincipalProfesor.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class MenuPrincipalProfesor: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
        
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "shinyBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //let viewCrear = segue.destination as! DetalleNuevoCuestionario
        
    }
    
    /*@IBAction func unwind(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }*/
    

}
