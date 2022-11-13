//
//  MainInteractor.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 14.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainBusinessLogic {
    func makeRequest(request: Main.Request)
}

protocol MainDataStore {
    
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    func makeRequest(request: Main.Request) {
        switch request {
        case .loadBackgroundImage:
            Task {
                do {
                    let data = try await fetcher.fetchRandomImage(of: 1)
                    presenter?.present(response: .presentBackgroundImage(data: data, error: nil))
                } catch let error {
                    presenter?.present(response: .presentBackgroundImage(data: nil, error: error))
                }
            }
        }
    }
    
    
    
    private let fetcher: NetworkFetcher
    
    init(fetcher: NetworkFetcher) {
        self.fetcher = fetcher
    }
    
//    func loadBackgroundImage(request: .) {
//        Task {
//            do {
//                let data = try await fetcher.fetchRandomImage(of: 1)
//
//            } catch let error {
//
//            }
//        }
//    }
    
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    //var name: String = ""

    // MARK: Do something (and send response to MainPresenter)

//    func doSomething(request: Main.Something.Request) {
//        worker = MainWorker()
//        worker?.doSomeWork()
//
//        let response = Main.Something.Response()
//        presenter?.presentSomething(response: response)
//    }
//
//    func doSomethingElse(request: Main.SomethingElse.Request) {
//        worker = MainWorker()
//        worker?.doSomeOtherWork()
//
//        let response = Main.SomethingElse.Response()
//        presenter?.presentSomethingElse(response: response)
//    }
}