//
//  Slide.swift
//  Cultura Visual y Sonora
//
//  Created by user169165 on 4/20/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

protocol protocoloContestaCuestionario {
    func agregaRespuesta(resp : Int, id: Int) -> Void
    func entregaCuestionario() -> Void
}

class Slide: UIView {
    
    // MARK: - Variables
    
    @IBOutlet weak var lblNumeroPregunta: UILabel!
    @IBOutlet weak var imgPregunta: UIImageView!
    @IBOutlet weak var btnRespuestaTexto1: UIButton!
    @IBOutlet weak var btnRespuestaTexto2: UIButton!
    @IBOutlet weak var btnRespuestaTexto3: UIButton!
    @IBOutlet weak var btnRespuestaTexto4: UIButton!
    @IBOutlet weak var btnEntregar: UIButton!
    
    var id:Int!

    //Views para hidear si la pregunta es de V/F
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    var delegado : protocoloContestaCuestionario!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Funcion de botones
    
    @IBAction func actionbtn1(_ sender: UIButton) {
        //print(sender.tag)
        delegado.agregaRespuesta(resp: sender.tag, id: self.id)
    }
    
    @IBAction func finishQuestionnaire(_ sender: UIButton) {
        delegado.entregaCuestionario()
    }
}
