//
//  MenuPrincipalAlumno.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class MenuPrincipalAlumno: UIViewController, UIPopoverPresentationControllerDelegate {

    var nombreUsuario:String! = nil
    
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
    
    func adaptivePresentationStyle (for controller:
        UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cuestionarios" {
            let navCon = segue.destination as! UINavigationController
            let tableViewCon = navCon.topViewController as! ListaCuestionariosA
            tableViewCon.nombreUsuario = nombreUsuario
        }
        
        if segue.identifier == "estadisticas" {
            let navController = segue.destination as! UINavigationController
            let vista = navController.topViewController as! EstadisticasAlumno
            vista.nombreUsuario = nombreUsuario!
        }
        
        if segue.identifier == "popOver" {
            let vistaPopOver = segue.destination as! CuestionarioGeneral
            vistaPopOver.popoverPresentationController!.delegate = self
            vistaPopOver.nombreUsuario = nombreUsuario!
        }
    }
    

}
