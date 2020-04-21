//
//  Slide.swift
//  Cultura Visual y Sonora
//
//  Created by user169165 on 4/20/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Slide: UIView {
    
    // MARK: - Variables
    
    @IBOutlet weak var lblNumeroPregunta: UILabel!
    @IBOutlet weak var imgPregunta: UIImageView!
    @IBOutlet weak var btnRespuestaTexto1: UIButton!
    @IBOutlet weak var btnRespuestaTexto2: UIButton!
    @IBOutlet weak var btnRespuestaTexto3: UIButton!
    @IBOutlet weak var btnRespuestaTexto4: UIButton!

    //Views para hidear si la pregunta es de V/F
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Funciones de botones
    
    @IBAction func actionbtn1(_ sender: UIButton) {
        print(sender.tag)
    }
    
}
