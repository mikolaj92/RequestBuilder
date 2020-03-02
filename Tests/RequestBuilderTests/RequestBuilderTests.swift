import XCTest
@testable import RequestBuilder

final class RequestBuilderTests: XCTestCase {
    private enum Constants {
        static let baseURL = "jsonplaceholder.typicode.com"
        static let userId = 1
    }
    
	private struct PostRequest: ServiceRequestProtocol {
        let urlHost: String = Constants.baseURL
        let urlPath: String = "/posts"
        let httpMethod: HTTPMethod = .post
		let body: RequestBody? = .json(PostParams(userId: Constants.userId))
    }
	
	private struct PostWithQueryRequest: ServiceRequestProtocol {
        let urlHost: String = Constants.baseURL
        let urlPath: String = "/posts"
        let httpMethod: HTTPMethod = .post
        let body: RequestBody? = .json(PostParams(userId: Constants.userId))
		var urlParameters: [String : String]? {
			["userId":"\(Constants.userId)"]
		}
    }
	
	struct GetRequest: ServiceRequestProtocol {
		let urlHost: String = "jsonplaceholder.typicode.com"
		let urlPath: String = "/posts"
		var urlParameters: [String : String]? {
		  ["userId":"\(Constants.userId)"]
		}
		let userId: Int
	}

    
    private struct PostParams: Codable, Equatable {
        let userId: Int
    }
    
    func testGetRequest() {
        let request = GetRequest(userId: Constants.userId).request
        XCTAssertEqual(request.url, URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(Constants.userId)"))
		XCTAssertEqual(request.httpMethod, "GET")
		XCTAssertNil(request.httpBody)
    }
    
    func testGetCurl() {
        let request = GetRequest(userId: Constants.userId)
        XCTAssertEqual(request.curlString, "curl https://jsonplaceholder.typicode.com/posts?userId=\(Constants.userId)")
    }
    
    func testPostRequest() {
        let request = PostWithQueryRequest().request
        XCTAssertEqual(request.url, URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(Constants.userId)"))
		XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.httpBody, PostParams(userId: Constants.userId).encoded)
    }
	
    func testPostWithQueryRequest() {
        let request = PostRequest().request
        XCTAssertEqual(request.url, URL(string: "https://jsonplaceholder.typicode.com/posts"))
		XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.httpBody, PostParams(userId: Constants.userId).encoded)
    }
    
    
    func testPostCurl() {
        let request = PostRequest()
        let curl = request.curlString
        XCTAssertTrue(curl.contains("curl https://jsonplaceholder.typicode.com/posts"))
        XCTAssertTrue(curl.contains("-d '{\"userId\":1}'"))
        XCTAssertTrue(curl.contains("-X POST"))
    }

    static var allTests = [
        ("testGetRequest", testGetRequest),
		("testGetCurl", testGetCurl),
		("testPostRequest", testPostRequest),
		("testPostCurl", testPostCurl),
    ]
}
