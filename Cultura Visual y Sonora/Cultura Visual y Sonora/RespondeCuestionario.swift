//
//  RespondeCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class RespondeCuestionario: UIViewController, UIScrollViewDelegate, protocoloContestaCuestionario {
    
    // MARK: - Dummy

     let Preg1 = Pregunta(desc: "Si o No", resp: [ "Si", "No"], correcta: 1, tipo: "V/F", imgs: [UIImage(named: "default")! , UIImage(named: "default")! ], categ: "texto", imgPreg: UIImage(named: "default")!)
    
    let Preg2 = Pregunta(desc: "Cuarto Numero", resp: [ "1", "2", "3", "4"], correcta: 4, tipo: "multiple", imgs: [UIImage(named: "default")! , UIImage(named: "default")! ], categ: "texto", imgPreg: UIImage(named: "default")!)
    
    let Preg3 = Pregunta(desc: "Ya fue el 21?", resp: [ "Si", "No"], correcta: 1, tipo: "V/F", imgs: [UIImage(named: "default")! , UIImage(named: "default")! ], categ: "texto", imgPreg: UIImage(named: "default")!)
    
    let Preg4 = Pregunta(desc: "Picaso creo el cubismo", resp: [ "Si", "No"], correcta: 1, tipo: "V/F", imgs: [UIImage(named: "default")! , UIImage(named: "default")! ], categ: "texto", imgPreg: UIImage(named: "default")!)
    
    let Preg5 = Pregunta(desc: "Picaso no creo el cubismo", resp: [ "Si", "No"], correcta: 2, tipo: "V/F", imgs: [UIImage(named: "default")! , UIImage(named: "default")! ], categ: "texto", imgPreg: UIImage(named: "default")!)
    
    
    
    // MARK: - Variables
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[Slide] = [];
    var respuestasUsuario = Array(repeating: 0, count: 6) //harcodeado
    var cantCorrectas = 0
    let respuestasCorrectas = Array(repeating: 1, count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.lblNumeroPregunta.text = Preg1.descripcion
        slide1.imgPregunta.image = UIImage(named: "Background")
        slide1.btnRespuestaTexto1.setTitle(Preg1.respuestas[0], for: .normal)
        slide1.btnRespuestaTexto2.setTitle(Preg1.respuestas[1], for: .normal)
        slide1.id = 1
        slide1.delegado = self
        slide1.btnEntregar.isHidden = true
        
        if(Preg1.tipoRespuestas == "V/F"){
            slide1.view3.isHidden = true
            slide1.view4.isHidden = true
        }
        
    
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.lblNumeroPregunta.text = Preg2.descripcion
        slide2.imgPregunta.image = UIImage(named: "RedBtn")
        slide2.btnRespuestaTexto1.setTitle(Preg2.respuestas[0], for: .normal)
        slide2.btnRespuestaTexto2.setTitle(Preg2.respuestas[1], for: .normal)
        slide2.btnRespuestaTexto3.setTitle(Preg2.respuestas[2], for: .normal)
        slide2.btnRespuestaTexto4.setTitle(Preg2.respuestas[3], for: .normal)
        slide2.id = 2
        slide2.delegado = self
        slide2.btnEntregar.isHidden = true
        
    
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.lblNumeroPregunta.text = Preg3.descripcion
        slide3.imgPregunta.image = UIImage(named: "Background")
        slide3.btnRespuestaTexto1.setTitle(Preg3.respuestas[0], for: .normal)
        slide3.btnRespuestaTexto2.setTitle(Preg3.respuestas[1], for: .normal)
        slide3.id = 3
        slide3.delegado = self
        slide3.btnEntregar.isHidden = true
        
        if(Preg3.tipoRespuestas == "V/F"){
            slide3.view3.isHidden = true
            slide3.view4.isHidden = true
        }
        
    
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.lblNumeroPregunta.text = Preg4.descripcion
        slide4.imgPregunta.image = UIImage(named: "RedBtn")
        slide4.btnRespuestaTexto1.setTitle(Preg4.respuestas[0], for: .normal)
        slide4.btnRespuestaTexto2.setTitle(Preg4.respuestas[1], for: .normal)
        slide4.id = 4
        slide4.delegado = self
        slide4.btnEntregar.isHidden = true
        
        if(Preg4.tipoRespuestas == "V/F"){
            slide4.view3.isHidden = true
            slide4.view4.isHidden = true
        }

    
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.lblNumeroPregunta.text = Preg5.descripcion
        slide5.imgPregunta.image = UIImage(named: "Background")
        slide5.btnRespuestaTexto1.setTitle(Preg5.respuestas[0], for: .normal)
        slide5.btnRespuestaTexto2.setTitle(Preg5.respuestas[1], for: .normal)
        slide5.id = 5
        slide5.delegado = self
        
        if(Preg5.tipoRespuestas == "V/F"){
            slide5.view3.isHidden = true
            slide5.view4.isHidden = true
        }
        
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
        /*
         * default function called when view is scolled. In order to enable callback
         * when scrollview is scrolled, the below code needs to be called:
         * slideScrollView.delegate = self or
         */
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
            
            // vertical
            let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
            let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
            
            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
}
            
            
            /*
             * below code changes the background color of view on paging the scrollview
             */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
            
        
            /*
             * below code scales the imageview on paging the scrollview
             
            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
            
            if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
                
                slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
                slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
                
            } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
                slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
                slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
                
            } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
                slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
                slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
                
            } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
                slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
                slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            }
        */
    
    // MARK: - ProtocoloContestaCuestionario
    func agregaRespuesta(resp : Int, id: Int) {
        respuestasUsuario[id] = resp
        
        for i in 1...respuestasUsuario.count-1 {
            print(respuestasUsuario[i])
        }
        print("-------------------")
    }
    
    func entregaCuestionario() {
        for i in 1...respuestasCorrectas.count-1 {
            if respuestasUsuario[i] == respuestasCorrectas[i] {
                cantCorrectas += 1
            }
        }
        
        
        self.performSegue(withIdentifier: "resultados", sender: self)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "resultados" {
            let viewRes = segue.destination as! ResultadoCuestionario
            viewRes.texto = "\(cantCorrectas) / \(respuestasCorrectas.count-1)"
        }
    }
    

}
