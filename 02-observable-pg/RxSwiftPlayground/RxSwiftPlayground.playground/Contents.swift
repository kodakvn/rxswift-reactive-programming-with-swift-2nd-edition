//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

// ### Creating and subscribing to observables ###

//example(of: "just, of, from") {
//    // 1
//    let one = 1
//    let two = 2
//    let three = 3
//
//    // 2
//    let observable: Observable<Int> = Observable<Int>.just(one)
//    let observable2 = Observable.of(one, two, three)
//    let observable3 = Observable.of([one, two, three])
//    let observable4 = Observable.from([one, two, three])
//}
//
//example(of: "subscribe") {
//    // 1
//    let one = 1
//    let two = 2
//    let three = 3
//
//    // 2
//    let observable = Observable.of(one, two, three)
//    observable.subscribe(onNext: { element in
//        print(element)
//    })
//}
//
//example(of: "empty") {
//    let observable = Observable<Void>.empty()
//    observable.subscribe(onNext: { element in // 1
//        print(element)
//    }, onCompleted: { // 2
//        print("completed")
//    })
//}
//
example(of: "never") {
    let observable = Observable<Any>.never()

    observable.subscribe(onNext: { print("onNext \($0)") },
                         onError: { print("onError \($0)") },
                         onCompleted: { print("onCompleted") },
                         onDisposed: { print("onDisposed") })
}
//
//example(of: "range") {
//    // 1
//    let observable = Observable<Int>.range(start: 1, count: 10)
//
//    // 2
//    observable.subscribe(onNext: { i in
//        let n = Double(i)
//        let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
//        print(fibonacci)
//    })
//}

// ### Disposing and terminating

//example(of: "dispose") {
//    // 1
//    let observable = Observable.of("A", "B", "C")
//
//    // 2
//    let subscription = observable.subscribe { event in
//        // 3
//        print(event)
//    }
//
//    subscription.dispose()
//}
//
//example(of: "DisposeBag") {
//    // 1
//    let disposeBag = DisposeBag()
//
//    // 2
//    Observable.of("A", "B", "C")
//        .subscribe {
//            print($0)
//        }
//        .disposed(by: disposeBag)
//}
//
//example(of: "create") {
//    enum MyError: Error {
//        case anError
//    }
//
//    let disposeBag = DisposeBag()
//
//    Observable<String>.create { observer in
//            observer.onNext("1")
////            observer.onError(MyError.anError)
////            observer.onCompleted()
//            observer.onNext("?")
//            return Disposables.create()
//        }
//        .subscribe(
//            onNext: { print($0) },
//            onError: { print($0) },
//            onCompleted: { print("completed") },
//            onDisposed: { print("disposed") }
//        )
////        .disposed(by: disposeBag)
//}

// ### Creating observable factories ###

//example(of: "deferred") {
//    let disposeBag = DisposeBag()
//
//    // 1
//    var flip = false
//
//    // 2
//    let factory: Observable<Int> = Observable.deferred {
//        // 3
//        flip = !flip
//
//        // 4
//        if flip {
//            return Observable.of(1,2,3)
//        } else {
//            return Observable.of(4,5,6)
//        }
//    }
//
//    for _ in 0...3 {
//        factory.subscribe(onNext: {
//            print($0, terminator: "")
//        })
//        .disposed(by: disposeBag)
//
//        print()
//    }
//}

//example(of: "Single") {
//    // 1
//    let disposeBag = DisposeBag()
//
//    // 2
//    enum FileReadError: Error {
//        case fileNotFound, unreadable, encodingFailed
//    }
//
//    // 3
//    func loadText(from name: String) -> Single<String> {
//        return Single.create { single in
//            // 1
//            let disposable = Disposables.create()
//
//            // 2
//            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
//                single(.error(FileReadError.fileNotFound))
//                return disposable
//            }
//
//            // 3
//            guard let data = FileManager.default.contents(atPath: path) else {
//                single(.error(FileReadError.unreadable))
//                return disposable
//            }
//
//            // 4
//            guard let contents = String(data: data, encoding: .utf8) else {
//                single(.error(FileReadError.encodingFailed))
//                return disposable
//            }
//
//            // 5
//            single(.success(contents))
//            return disposable
//        }
//    }
//
//    loadText(from: "Copyright")
//        .subscribe {
//            switch $0 {
//            case .success(let string):
//                print(string)
//            case .error(let error):
//                print(error)
//            }
//        }
//        .disposed(by: disposeBag)
//}
/*:
 Copyright (c) 2014-2017 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
