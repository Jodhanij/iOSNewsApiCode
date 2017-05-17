//
//  ServiceCustom.swift
//Copyright (c) 2017 Jaysukh. All rights reserved.
import UIKit
import AFNetworking
class ServiceCustom: NSObject
{
    //share instance used to call class method any of place
    static let sharedMyManager : ServiceCustom = {
        let instance = ServiceCustom()
        return instance
    }()
    
    //MARK: Local Variable
    var manager = AFHTTPSessionManager()
    //MARK: Init
    
    convenience override init()
    {
        self.init(array : [])
    }
    
    //MARK: Init Array
    
    init( array : [String]) {
        manager = AFHTTPSessionManager()
    }
    
    //for post methods -> to call any post methods api
    func postAtURL(strURL:String, parameter: NSDictionary, sucess:@escaping (_ requestOperation:URLSessionDataTask, _ responseobject:Any) -> Void, failure:@escaping (_ requestOperation:URLSessionDataTask, _ error:Error) -> Void)
    {
        manager.post(strURL, parameters: parameter, progress: nil, success: { (requestOperation, response) in
            sucess(requestOperation,response)
        }) { (requestOperation, error) in
            failure(requestOperation!,error)
        }
    }
    
    
    //for get methods -> to call any get methods api
    func GetAtURL(strURL:String, sucess:@escaping (_ requestOperation:URLSessionDataTask, _ responseobject:Any) -> Void, failure:@escaping (_ requestOperation:URLSessionDataTask, _ error:Error) -> Void)
    {
        manager.get(strURL, parameters: nil, progress: nil, success: { (requestOperation, response) in
            sucess(requestOperation,response)
        }) { (requestOperation, error) in
            failure(requestOperation!,error)
        }
    }

}
