# 서울영화 (SeoulMovie)
 서울시 무료 영화 상영 정보를 실제 영화관 앱처럼 정보를 제공하는 iOS Application  - `2017년 서울시 앱공모전 출품작 (서울시)`

[![Swift](https://img.shields.io/badge/Swift-compatible-E77335.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS_9.0+-lightgrey.svg)](https://github.com/blackturtle2/SeoulMovie)
[![Twitter](https://img.shields.io/badge/twitter-%40blackturtle2-1EA0F2.svg)](http://twitter.com/blackturtle2)
[![Facebook](https://img.shields.io/badge/facebook-%40blackturtle2-4267B1.svg)](http://facebook.com/blackturtle2)
[![Blog](https://img.shields.io/badge/blog-blackturtle2.net-EC5620.svg)](http://blackturtle2.net)

![test](/Screen%20Shot%2001%20-%20Main%20View.png "test title")  ![test](/Screen%20Shot%2002%20-%20Detail%20View.png "test title")

## About
 서울버스, 서울여행, 서울데이트팝, 서울OOO, ... 그래서 **서울영화** 를 만들다.

 서울시 및 지역구 등에서 무료로 영화를 상영하는 좋은 기회들이 많지만, 시민들이 접할 수 있는 통로는 많지 않았고, 때문에 그런 좋은 기회들이 만들어져도 해당 정보를 알고 방문하는 시민들은 많지 않았다.

 점점 비싸지는 대기업 영화 관람료를 대신하여 서울시에서 무료로 상영하는 영화 정보들을 영화관 앱처럼 제공해서, 보다 많은 시민들과 학생 그리고 문화 사각지대에 놓인 소년소녀가장들에게도 더 많은 영화 관람의 기회가 있기를 바라며, `서울영화` 앱을 개발하게 되었다.

 서울시에서 무료로 상영중인 영화 상영 정보를 영화관 앱과 같이 보기 좋게 나열하여 시민들이 보다 편리하고, 손 쉽게 좋은 영화 상영 기회를 얻을 수 있도록 한다.
 
 이전에 여기저기로 흩어져 있던 각 주최 기관의 상영 정보를 한 곳에 모아 제공함으로써 보다 많은 시민들에게 무료 영화 상영 정보를 알릴 수 있게 되었다. 마치 실제 영화관 앱처럼 상영 정보가 나열되어 있어서, 많은 상영 정보들 중에 내가 원하는 것을 골라서 관람할 수도 있다. 특히 문화 사각지대에 놓인 학생들이나 소년/소녀 가장들에게도 한 눈에 정보들을 확인할 수 있어 매우 유용하다.

## Features
- [x] 영화 상영 정보, 페이지컨트롤로 구현.
- [x] 상영 정보 자세히 보기 뷰.
- [x] 상영 정보의 웹사이트 바로가기
- [x] 상영 정보로 문의 전화하기
- [x] 상영 정보의 장소 지도보기.
- [x] 상영 정보로 영화 정보, 구글/네이버/다음 검색하기.



## Used Open API
- `서울시 문화행사정보 장르별 검색` API (OA-139)
	- URL: http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-139
	- Note: 장르 번호 `18`번으로 검색.
- `서울시 문화행사 정보` API (OA-135)
	- URL: http://data.seoul.go.kr/openinf/sheetview.jsp?infId=OA-135
	- Note: 문화행사코드(`CULTCODE`)로 검색한 정보 출력.


## Used Open Source
- `Alamofire`: https://github.com/Alamofire/Alamofire
- `Kingfisher`: https://github.com/onevcat/Kingfisher
- `Toaster`: https://github.com/devxoul/Toaster
- `PageControl`: https://github.com/policante/PageControl


## Contact Me
[![Gmail](https://img.shields.io/badge/Gmail-blackturtle2@gmail.com-000000.svg)](blackturtle2@gmail.com)
