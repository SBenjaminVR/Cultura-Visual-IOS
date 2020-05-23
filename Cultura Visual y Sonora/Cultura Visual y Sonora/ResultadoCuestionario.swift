//
//  ResultadoCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import Charts

class ResultadoCuestionario: UIViewController {

    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var lbTexto: UILabel!
    
    var respuestasUsuario1 : [Int] = []
   
    var respuestasCorrectas1: [Int] = []
    
    var texto:String!
    var Correctas: Double!
    var Incorrectas:Double!
    
    var correctasDataEntry = PieChartDataEntry(value: 0)
    var incorrectasDataEntry = PieChartDataEntry(value: 0)
    
    var arrSlides2 : [Slide]!
    
    
    
    var dataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTexto.text = texto
        
        
        
        pieChart.chartDescription?.text = ""
        correctasDataEntry.value = Correctas
        correctasDataEntry.label = "Correctas"
        incorrectasDataEntry.value = Incorrectas
        incorrectasDataEntry.label = "Incorrectas"
        
        dataEntries = [correctasDataEntry, incorrectasDataEntry]
        
        updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "BlueColor"), UIColor(named: "RedColor")]
        
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
        
        
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let viewRes = segue.destination as! ResultadosGeneralesCuestionarios
        viewRes.arrSlides3 = arrSlides2
        viewRes.respuestasUsuario2 = respuestasUsuario1
        viewRes.respuestasCorrectas2 = respuestasCorrectas1
    }
    
    @IBAction func salirCuestionario(_ sender: Any) {
        let p = self.presentingViewController
        self.dismiss(animated: true) {
            p?.dismiss(animated: true, completion: nil)
        }
    }
    
}
