//
//  ResultadosGeneralesCuestionarios.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class ResultadosGeneralesCuestionarios: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollViewRes: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var arrSlides3 : [Slide]!
    
     var respuestasUsuario2 : [Int] = []
     var respuestasCorrectas2: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollViewRes.delegate = self
        
        bloquearBotones()
        setupSlideScrollView(slides: arrSlides3)
        
        pageControl.numberOfPages = arrSlides3.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        marcarCorrectas()
    }
    
    func bloquearBotones(){
        for i in 0...arrSlides3.count-1{
            arrSlides3[i].btnRespuestaTexto1.isEnabled = false
            arrSlides3[i].btnRespuestaTexto2.isEnabled = false
            arrSlides3[i].btnRespuestaTexto3.isEnabled = false
            arrSlides3[i].btnRespuestaTexto4.isEnabled = false
            arrSlides3[i].btnReiniciar.isHidden = true
            arrSlides3[i].btnEntregar.isHidden = true
        }
    }
    
    func marcarCorrectas(){
        for i in 0...arrSlides3.count-1{
            arrSlides3[i].progressView.isHidden = true;
                 switch respuestasCorrectas2[i] {
                 case 1:
                    arrSlides3[i].view1.layer.borderWidth = 10
                    arrSlides3[i].view1.layer.borderColor = UIColor(named: "BlueColor")?.cgColor
                     break;
                 case 2:
                    arrSlides3[i].view2.layer.borderWidth = 10
                    arrSlides3[i].view2.layer.borderColor = UIColor(named: "BlueColor")?.cgColor
                     break;
                 case 3:
                    arrSlides3[i].view3.layer.borderWidth = 10
                    arrSlides3[i].view3.layer.borderColor = UIColor(named: "BlueColor")?.cgColor
                     break;
                 case 4:
                    arrSlides3[i].view4.layer.borderWidth = 10
                    arrSlides3[i].view4.layer.borderColor = UIColor(named: "BlueColor")?.cgColor
                     break;
                 default:
                     break;
                 }
            }
    }
                

    
    func setupSlideScrollView(slides : [Slide]) {
        scrollViewRes.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollViewRes.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollViewRes.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollViewRes.addSubview(slides[i])
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
