# Prography 8th iOS Quest 
## Moviestagram
<img src = "https://user-images.githubusercontent.com/59835351/216823743-883e892f-ef9c-4017-b558-31b7d87bc2aa.png" width="60%" height="60%">

> 🏃🏻🏃🏻‍♂️💨 **프로젝트 기간:** `23.02.05` ~ `23.02.06`

## 📝 프로젝트 구조


> UIKit (Code base) + MVC Pattern
> 
- 빠른 구현을 위해 가장 단순한 MVC 구조를 사용하였습니다.
    
    <img width="277" alt="스크린샷 2023-02-05 오후 10 05 30" src="https://user-images.githubusercontent.com/59835351/216823807-94dc78c5-989a-405e-8d96-f835a7b47b01.png">
    
## 📱 동작 화면
### 1. 앱 초기 화면
![1  앱 초기 화면](https://user-images.githubusercontent.com/59835351/216824101-21d0e42e-2a7e-4cbe-b476-c67795d6e31a.gif)

### 2. 메인 피드 (무한 스크롤, 새로고침)
![2  메인 피드 (무한 스크롤, 새로고침)](https://user-images.githubusercontent.com/59835351/216824183-9fa05a08-4445-4517-a59b-67476bdda8bd.gif)

### 3. 메인 피드 (인기순, 평점순 정렬)
![3  메인 피드 (인기순, 평점순 정렬)](https://user-images.githubusercontent.com/59835351/216824242-736274d4-a79d-4a83-a196-b6161693c478.gif)

### 4. 상세 페이지
![4  상세 페이지](https://user-images.githubusercontent.com/59835351/216824270-5e889475-06e2-41fb-95c0-a4c88b15317e.gif)

### 5. 사용자 별점 기능
![5  사용자 별점 기능](https://user-images.githubusercontent.com/59835351/216824285-8ccd92a4-627f-4c83-985a-f60851329c4d.gif)

### 6. 사용자 북마크 저장 기능
![6  사용자 북마크 저장 기능](https://user-images.githubusercontent.com/59835351/216824292-c23709e0-70c8-442f-9c92-c35f00a2ece1.gif)

### 7. 영화 검색 기능
![7  영화 검색 기능](https://user-images.githubusercontent.com/59835351/216824305-0830ef1a-4805-4dc6-b413-133007e742e8.gif)

### 8. 영화 검색 - 결과 없음 사용자 알림
![8  영화 검색 - 결과 없음 사용자 알림](https://user-images.githubusercontent.com/59835351/216824313-d1853446-6c7d-485a-810e-799973ac7a3d.gif)

### 9. 유저 프로필
![9  유저 프로필](https://user-images.githubusercontent.com/59835351/216824325-04e6ca18-ef0b-445a-a410-f0b7669273c3.gif)


## 🔨 사용 라이브러리 목록

### 🎣 Kingfisher

- 프로젝트 특성상 영화 API 에서 포스터 이미지를 불러오는 작업을 자주 하기에, 캐싱 작업을 위해 사용하였습니다.

### 🫰 SnapKit

- 처음엔 UIView의 extension으로 anchore를 쉽게 잡게 해 주는 Helper function 을 생성하여 작업하였으나, 
프로젝트 중간부터 스냅킷의 활용을 학습 하여 프로젝트에 적용하였습니다.
- 모든 프로젝트를 Code UI 로 작성하였기에 사용하였습니다.
- Storyboard 로 작업할 수도 있었지만, 차후 협업을 위해서는 Code base UI 가 더 적절하다 판단하였습니다.

## 🎞️ API - 영화 정보

> 프로젝트 요구사항이었던 yts의 API 사용
> 
- API 관련 정보: [https://yts.lt/api#list_movies](https://yts.lt/api#list_movies)
- API base URL: [https://yts.lt/api/v2/list_movies.json](https://yts.lt/api/v2/list_movies.json)

## ✅ 차후 작업 사항

- [ ]  MVVM, Clean Architecture 구조로 리팩터링
    
    > MVVM, Clean Architecture 를 학습 후 적용 할 예정.
    > 
    - [ ]  Controller와 Repository 간의 종속성 분리
    - [ ]  Cell과 같은 View들이 Model에 대해 모르게끔 구현
    - [ ]  현재 Movie는 Usecase + Model 형태인데, 이를 분리 할 예정
- [ ]  유닛 테스트 구현
    > 시간 관계로 유닛 테스트는 구현하지 못하였고, 
    트러블 슈팅은 lldb, log를 활용한 디버깅을 하며 작업하였는데 한 문제에서 막혔을 때 시간이 지연되는 부분이 있었던 것이 아쉬움
    > 
- [ ]  Auto Layout - SnapKit 으로 마저 리팩터링
- [ ]  현재는 User가 저장한 데이터를 UserDefaults로 Local에 저장하는데, 
이를 Firebase를 활용하여 Server 에 저장하도록 구현 예정
    - [ ]  (미정) 각 영화별로 댓글을 달 수 있고, 평점을 공유할 수 있는 SNS 기능
