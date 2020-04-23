//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
@testable import SPHTech

class NetworkErrorSpec: QuickSpec {
    override func spec() {
        it(".NotConnectedToInternet") {
            let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
            let error = NetworkError(error: nsError)
            expect(error) == NetworkError.NotConnectedToInternet
            expect(error.localizedDescription) == "Can't connect to Internet. Please check again."
        }
        
        describe(".NotReachedServer") {
            it(".NSURLErrorCannotFindHost") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.NotReachedServer
                expect(error.localizedDescription) == "Can't connect to Server. Please check again."
            }
            it(".NSURLErrorCannotConnectToHost") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorCannotConnectToHost, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.NotReachedServer
                expect(error.localizedDescription) == "Can't connect to Server. Please check again."
            }
            it(".NSURLErrorTimedOut") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.NotReachedServer
                expect(error.localizedDescription) == "Can't connect to Server. Please check again."
            }
            it(".NSURLErrorDNSLookupFailed") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorDNSLookupFailed, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.NotReachedServer
                expect(error.localizedDescription) == "Can't connect to Server. Please check again."
            }
        }
        
        it(".ConnectionLost") {
            let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost, userInfo: nil)
            let error = NetworkError(error: nsError)
            expect(error) == NetworkError.ConnectionLost
            expect(error.localizedDescription) == "Connection lost. Please check again."
        }
        describe(".IncorrectDataReturned") {
            it(".NSURLErrorBadURL") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorUnsupportedURL") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorDataLengthExceedsMaximum") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorDataLengthExceedsMaximum, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorResourceUnavailable") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorResourceUnavailable, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorRedirectToNonExistentLocation") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorRedirectToNonExistentLocation, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorBadServerResponse") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorZeroByteResource") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorZeroByteResource, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorCannotDecodeRawData") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorCannotDecodeRawData, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorCannotDecodeContentData") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorCannotDecodeContentData, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorCannotParseResponse") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorCannotParseResponse, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorFileDoesNotExist") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorFileDoesNotExist, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
            it(".NSURLErrorFileIsDirectory") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorFileIsDirectory, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.IncorrectDataReturned
                expect(error.localizedDescription) == "Incorrect data returned. Please check again."
            }
        }
        
        describe(".Unknown Error") {
            it(".Unknown Error Other Error") {
                let nsError = NSError.init(domain: "OtherError", code: 0, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.Unknown
                expect(error.localizedDescription) == "Unknown Error. Please check again."
            }
            it(".Unknown Error NSURLErrorDomain") {
                let nsError = NSError.init(domain: NSURLErrorDomain, code: -11, userInfo: nil)
                let error = NetworkError(error: nsError)
                expect(error) == NetworkError.Unknown
                expect(error.localizedDescription) == "Unknown Error. Please check again."
            }
        }
    }
}
