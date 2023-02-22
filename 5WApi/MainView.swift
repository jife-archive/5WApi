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

class MainView: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    let Naver_Client = "qzwg5kke32"
    let Naver_Screat_Client = "lwKSn3pYjxsOzgVL4UEZUHoSCu2oKDnFLOJGC6vB"
    let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    let Reverse_NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"

    var here = "산호대로 24길 9-5"
    let there = "36.1195987,"
    @IBAction func SearchAddress(_ sender: Any) {
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let encodeAddress = here.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: Naver_Client)
               let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: Naver_Screat_Client)
               let headers = HTTPHeaders([header1,header2])
        print(encodeAddress)
        AF.request(NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value as [String:Any]):
                        let json = JSON(value)
                        let data = json["addresses"]
                        let lat = data[0]["y"]
                        let lon = data[0]["x"]
                        print("홍대입구역의","위도는",lat,"경도는",lon)
                    case .failure(let error):
                        print(error.errorDescription ?? "")
                    default :
                        fatalError()
                    }
                }
    }
    

   

}
