//
//  MainView.swift
//  5WApi
//
//  Created by 최지철 on 2023/02/22.
//

import UIKit
import NMapsMap
import CoreLocation
import Alamofire
import SwiftyJSON

class MainView: UIViewController, CLLocationManagerDelegate, UISheetPresentationControllerDelegate {
    var locationManager = CLLocationManager()

    @IBAction func SearchAddress(_ sender: Any) {
       /* let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)*/
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchAddressView") else {return}


        
      //  vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            
            //지원할 크기 지정
            sheet.detents = [.medium(), .large()]
            //크기 변하는거 감지
            sheet.delegate = self
           
            //시트 상단에 그래버 표시 (기본 값은 false)
            sheet.prefersGrabberVisible = true
            
            //처음 크기 지정 (기본 값은 가장 작은 크기)
            //sheet.selectedDetentIdentifier = .large
            
            //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
            //sheet.largestUndimmedDetentIdentifier = .medium
           // present(vc, animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
         }
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
