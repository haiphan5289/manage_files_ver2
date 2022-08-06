//
//  FallLoveAPIRouter.swift
//  FallInLove
//
//  Created by paxcreation on 12/22/20.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class ReadJSON {
    static var shared = ReadJSON()
    private let disposeBag = DisposeBag()
    func parseToDate(name: String, type: String) -> Observable<Data> {
        return Observable.create { (observe) -> Disposable in
            if let path = Bundle.main.path(forResource: name, ofType: type) {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    observe.onNext((data))
                } catch let error {
                    observe.onError(error)
                }
            } else {
                print("Invalid filename/path.")
            }
            return Disposables.create()
        }
    }
    
    func readJSONObs<T: Codable>(offType: T.Type, name: String, type: String) -> Observable<T> {
        return Observable.create { (observe) -> Disposable in
            if let path = Bundle.main.path(forResource: name, ofType: type) {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let objec = try JSONDecoder().decode(T.self, from: data)
                    observe.onNext((objec))
                } catch let error {
                    observe.onError(error)
                }
            } else {
                print("Invalid filename/path.")
            }
            return Disposables.create()
        }
    }
}

enum APIResult<Value, Error> {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    init(err: Error) {
        self = .failure(err)
    }
}

