//
//  PinningDelegate.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 12/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

final class PinningDelegate: NSObject, URLSessionDelegate {

    // swiftlint:disable:next function_body_length
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)

                if isServerTrusted {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        let data = CFDataGetBytePtr(serverCertificateData)
                        let size = CFDataGetLength(serverCertificateData)
                        let cert1 = NSData(bytes: data, length: size)
                        let derFile = Bundle.main.path(forResource: "marlove", ofType: "cer")

                        if let file = derFile {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert1.isEqual(to: cert2 as Data) {
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential,
                                                      URLCredential(trust: serverTrust))
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }

        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }

}
