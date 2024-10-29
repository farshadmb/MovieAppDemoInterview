//
//  AppDIContainer.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit
import Alamofire

final class AppDIContainer {
   
    lazy var apiClientAuthenticator: ApiClientAuthenticator = {
        DefaultApiClientAuthenticator(apiToken: AppConfig.ApiKey)
    }()
    
    lazy var apiClient: ApiClient = {
        DefaultApiClient(configuration: .af.default,
                                      authenticator: apiClientAuthenticator)
    }()
    
    func makeMovieDIContainer() -> MovieDIContainer {
       MovieDIContainer(apiClient: apiClient)
    }
}
