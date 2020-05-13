//
//  RespondeCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

protocol protocoloRespuestasUsuario {
    func guardaRespuestasUsuario(resps: [Int])
}

class RespondeCuestionario: UIViewController, UIScrollViewDelegate, protocoloContestaCuestionario {
        
    
    
    // MARK: - Variables
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var cuestionarioACargar : Cuestionario!
    
    var NumeroDeRespuestas : Int!
    
    var respuestasUsuario : [Int]!
    var cantCorrectas = 0
    var respuestasCorrectas: [Int] = []
    
    var slides:[Slide] = [];
    
    var delegado : protocoloRespuestasUsuario!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NumeroDeRespuestas = cuestionarioACargar.numeroDePreguntas
            
        respuestasCorrectas = Array(repeating: 0, count: NumeroDeRespuestas)
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        marcarCorrectas()
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    
    func createSlides() -> [Slide] {
        
        var arrSlides : [Slide]!
        
        arrSlides = []
        
        for i in 0...cuestionarioACargar.numeroDePreguntas-1{
            respuestasCorrectas[i] = cuestionarioACargar.preguntas[i].respuestaCorrecta
            
            let slideTmp:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slideTmp.lblNumeroPregunta.text = cuestionarioACargar.preguntas[i].descripcion
            
            let dataImgPreg = cuestionarioACargar.preguntas[i].imgPregunta.jpegData(compressionQuality: 0.1)
            let dataDefault = UIImage(named:"default")?.jpegData(compressionQuality: 0.1)
            	
            if dataImgPreg != dataDefault {
                slideTmp.imgPregunta.image = cuestionarioACargar.preguntas[i].imgPregunta
            } else {
                slideTmp.imgPregunta.image = nil
            }
            
            //Checa si son de V/F
            if cuestionarioACargar.preguntas[i].tipoRespuestas == "V/F"{
                //Checa si son respuestas de tipo Imagen

                slideTmp.btnRespuestaTexto1.setTitle(cuestionarioACargar.preguntas[i].respuestas[0], for: .normal)
                slideTmp.btnRespuestaTexto2.setTitle(cuestionarioACargar.preguntas[i].respuestas[1], for: .normal)
                
                
                slideTmp.view3.isHidden = true
                slideTmp.view4.isHidden = true
            }
            
            else{
                if cuestionarioACargar.preguntas[i].categoria == "imagenes" {
                    //Si son imagenes, y son de tipo multiple
                    slideTmp.btnRespuestaTexto1.setImage(cuestionarioACargar.preguntas[i].imagenes[0], for: .normal)
                    slideTmp.btnRespuestaTexto1.imageView?.contentMode = .scaleAspectFit
                    slideTmp.btnRespuestaTexto2.setImage(cuestionarioACargar.preguntas[i].imagenes[1], for: .normal)
                    slideTmp.btnRespuestaTexto2.imageView?.contentMode = .scaleAspectFit
                    slideTmp.btnRespuestaTexto3.setImage(cuestionarioACargar.preguntas[i].imagenes[2], for: .normal)
                    slideTmp.btnRespuestaTexto3.imageView?.contentMode = .scaleAspectFit
                    slideTmp.btnRespuestaTexto4.setImage(cuestionarioACargar.preguntas[i].imagenes[3], for: .normal)
                    slideTmp.btnRespuestaTexto4.imageView?.contentMode = .scaleAspectFit
                    
                    slideTmp.view1.backgroundColor = .white
                    slideTmp.view2.backgroundColor = .white
                    slideTmp.view3.backgroundColor = .white
                    slideTmp.view4.backgroundColor = .white
                    
                }
                //Si no, carga el texto que puedan traer
                else{
                    slideTmp.btnRespuestaTexto1.setTitle(cuestionarioACargar.preguntas[i].respuestas[0], for: .normal)
                    slideTmp.btnRespuestaTexto2.setTitle(cuestionarioACargar.preguntas[i].respuestas[1], for: .normal)
                    slideTmp.btnRespuestaTexto3.setTitle(cuestionarioACargar.preguntas[i].respuestas[2], for: .normal)
                    slideTmp.btnRespuestaTexto4.setTitle(cuestionarioACargar.preguntas[i].respuestas[3], for: .normal)
                }
                
            }
            slideTmp.id = i
            slideTmp.delegado = self
            
            let numBotonEntregar = cuestionarioACargar.numeroDePreguntas-1
            if i != numBotonEntregar {
                slideTmp.btnEntregar.isHidden = true
            }
            
            arrSlides.append(slideTmp)
        }
        

    
        return arrSlides
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
            let paginaActual = Int(pageIndex)
            pageControl.currentPage = paginaActual
            
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
    
    func marcarCorrectas(){
        for i in 0...slides.count-1{
            
                 switch respuestasUsuario[i] {
                 case 1:
                    slides[i].view1.layer.borderWidth = 10
                    slides[i].view1.layer.borderColor = UIColor.red.cgColor
                     break;
                 case 2:
                    slides[i].view2.layer.borderWidth = 10
                    slides[i].view2.layer.borderColor = UIColor.red.cgColor
                     break;
                 case 3:
                    slides[i].view3.layer.borderWidth = 10
                    slides[i].view3.layer.borderColor = UIColor.red.cgColor
                     break;
                 case 4:
                    slides[i].view4.layer.borderWidth = 10
                    slides[i].view4.layer.borderColor = UIColor.red.cgColor
                     break;
                 default:
                     break;
                 }
            }
    }
    
    // MARK: - ProtocoloContestaCuestionario
    func agregaRespuesta(resp : Int, id: Int) {
        respuestasUsuario[id] = resp
    }
    
    func entregaCuestionario() {
        for i in 0...respuestasCorrectas.count-1 {
            if respuestasUsuario[i] == respuestasCorrectas[i] {
                cantCorrectas += 1
            }
        }
        
        self.performSegue(withIdentifier: "resultados", sender: self)
        
    }
    
    func reiniciarCuestionario() {
        for i in 0...respuestasUsuario.count-1 {
            respuestasUsuario[i] = 0
        }
        for i in 0...slides.count-1 {
            slides[i].view1.layer.borderWidth = 0
            slides[i].view2.layer.borderWidth = 0
            slides[i].view3.layer.borderWidth = 0
            slides[i].view4.layer.borderWidth = 0
        }
        pageControl.currentPage = 0
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        scrollViewDidScroll(scrollView)
        
    }
    
    //MARK: - Metodos Codable
   /* func dataFileURL(nombre : String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(nombre)
        return pathArchivo
    }
    
    @IBAction func guardarNumeros() {
        do {
            let data = try PropertyListEncoder().encode(pickerData)
            try data.write(to: dataFileURL(nombre: "Numeros.plist"))
        }
        catch {
            print("Error al guardar numeros")
        }
    }
    
    func obtenerNumeros() {
        pickerData.removeAll()
        
        do {
            let data = try Data.init(contentsOf: dataFileURL(nombre: "Numeros.plist"))
            pickerData = try PropertyListDecoder().decode([Numero].self, from: data)
        }
        catch {
            print("Error al cargar numeros")
        }
        
        if(pickerData.count > 0) {
            selected = pickerData[pickerData.count-1].num
            pickerData.removeLast()
        }
        pickerView.reloadAllComponents()
        pickerView.selectRow(selected, inComponent: 0, animated: true)
    }*/
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "resultados" {
            let viewRes = segue.destination as! ResultadoCuestionario
          
            let cCorrectas =  Double(cantCorrectas)
            let cIncorrectas = Double(respuestasCorrectas.count - cantCorrectas)
            var califa = cCorrectas / Double(respuestasCorrectas.count)
            califa *= 100
            viewRes.texto = "Calificacion: \(Int(califa)) %"
            viewRes.Correctas = cCorrectas
            viewRes.Incorrectas = cIncorrectas
            viewRes.arrSlides2 = slides
            viewRes.respuestasUsuario1 = respuestasUsuario
            viewRes.respuestasCorrectas1 = respuestasCorrectas
            
        }
    }
    @IBAction func regresarMenu(_ sender: Any) {
        delegado.guardaRespuestasUsuario(resps: respuestasUsuario)
        dismiss(animated: true, completion: nil)
    }
    
}
