//
//  ViewController.swift
//  5WApi
//
//  Created by 최지철 on 2023/02/21.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

class ViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 로그인 성공")
          self.naverLoginPaser()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("네이버 토큰\(String(describing: naverLoginInstance?.accessToken))")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃")

    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러 = \(error.localizedDescription)")

    }
    func naverLoginPaser() {
              guard let accessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
              
              if !accessToken {
                return
              }
              
              guard let tokenType = naverLoginInstance?.tokenType else { return }
              guard let accessToken = naverLoginInstance?.accessToken else { return }
                
              let requestUrl = "https://openapi.naver.com/v1/nid/me"
              let url = URL(string: requestUrl)!
              
              let authorization = "\(tokenType) \(accessToken)"
              
              let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
              
              req.responseJSON { response in
                
                guard let body = response.value as? [String: Any] else { return }
                  
                  if let resultCode = body["message"] as? String{
                      if resultCode.trimmingCharacters(in: .whitespaces) == "success"{
                          let resultJson = body["response"] as! [String: Any]
                          
                          let name = resultJson["name"] as? String ?? ""
                          let id = resultJson["id"] as? String ?? ""
                          let phone = resultJson["mobile"] as! String
                          let gender = resultJson["gender"] as? String ?? ""
                          let birthyear = resultJson["birthyear"] as? String ?? ""
                          let birthday = resultJson["birthday"] as? String ?? ""
                          let profile = resultJson["profile_image"] as? String ?? ""
                          let email = resultJson["email"] as? String ?? ""
                          let nickName = resultJson["nickname"] as? String ?? ""

                          print("네이버 로그인 이름 ",name)
                          print("네이버 로그인 아이디 ",id)
                          print("네이버 로그인 핸드폰 ",phone)
                          print("네이버 로그인 성별 ",gender)
                          print("네이버 로그인 생년 ",birthyear)
                          print("네이버 로그인 생일 ",birthday)
                          print("네이버 로그인 프로필사진 ",profile)
                          print("네이버 로그인 이메일 ",email)
                          print("네이버 로그인 닉네임 ",nickName)
                      }
                      else{
                          //실패
                      }
                  }
              }
        }

    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        naverLoginInstance?.delegate = self

        // Do any additional setup after loading the view.
    }


    @IBAction func NaverBtn(_ sender: Any) {
        naverLoginInstance?.requestThirdPartyLogin()

    }
}

