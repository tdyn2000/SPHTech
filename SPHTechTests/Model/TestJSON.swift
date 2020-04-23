//
//  Created by La Hy Tai on 4/23/20.
//

let RecordJSON: [String: Any] = [
    "volume_of_mobile_data":"18.47368",
    "quarter":"2018-Q2",
    "_id":56
]

let IncorrectRecordJSON: [String: Any] = [
    "volume_of_mobile_data":"18.47368",
    "quarter":"2018-Q2",
    "_id":"tets"
]

let ErrorRecordJSON_quarter: [String: Any] = [
    "volume_of_mobile_data":"18",
    "quarter":"2018Q2",
    "_id":56
]

let ErrorRecordJSON_missing: [String: Any] = [
    "volume_of_mobile_data":"18",
    "_id":1
]

let ResponeJSON: [String: Any] = [
    "success":true,
    "result": resultJSON
]

let resultJSON: [String: Any] = [
    "total" : 1,
    "records" : [RecordJSON,IncorrectRecordJSON]
]
