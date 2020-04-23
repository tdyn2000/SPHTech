//
//  Created by La Hy Tai on 4/23/20.
//

import Foundation

public enum NetworkError: Error {
    /// Not connected to the internet.
    case NotConnectedToInternet
    
    /// Cannot reach the server.
    case NotReachedServer
    
    /// Connection is lost.
    case ConnectionLost
    
    /// Incorrect data returned from the server.
    case IncorrectDataReturned
    
    /// Unknown or not supported error.
    case Unknown
    
    internal init(error: NSError) {
        if error.domain == NSURLErrorDomain {
            switch error.code {
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost, NSURLErrorTimedOut, NSURLErrorDNSLookupFailed:
                self = .NotReachedServer
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            case NSURLErrorBadURL:
                self = .IncorrectDataReturned
            case NSURLErrorUnsupportedURL:
                self = .IncorrectDataReturned
            case NSURLErrorDataLengthExceedsMaximum:
                self = .IncorrectDataReturned
            case NSURLErrorResourceUnavailable:
                self = .IncorrectDataReturned
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
                self = .IncorrectDataReturned
            case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
                self = .IncorrectDataReturned
            case NSURLErrorCannotParseResponse:
                self = .IncorrectDataReturned
            case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
                self = .IncorrectDataReturned
            default:
                self = .Unknown
            }
        }
        else {
            self = .Unknown
        }
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .NotConnectedToInternet:
            return NSLocalizedString(
                "Can't connect to Internet. Please check again.",
                comment: ""
            )
        case .NotReachedServer:
            return NSLocalizedString(
                "Can't connect to Server. Please check again.",
                comment: ""
            )
        case .ConnectionLost:
            return NSLocalizedString(
                "Connection lost. Please check again.",
                comment: ""
            )
        case .IncorrectDataReturned:
            return NSLocalizedString(
                "Incorrect data returned. Please check again.",
                comment: ""
            )
        case .Unknown:
            return NSLocalizedString(
                "Unknown Error. Please check again.",
                comment: ""
            )
        }
    }
}
