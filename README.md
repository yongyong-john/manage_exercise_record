# manage_exercise_records
## 개요
### 목적
- 이 프로젝트는 사용자가 운동을 기록하고 기록한 운동의 이력을 보여줍니다.
### 기능
- 메인화면에는 동영상 두 개가 반복되어 재생됩니다.
- 기록 가능한 운동은 런지, 스쿼트, 푸쉬업, 레그레이즈가 있습니다.
- 타인이 접근하지 못하도록 기록을 하거나 보기 위해서는 로그인이 필요합니다.
- 기록을 하고자하는 운동을 선택하여 운동한 날짜와 시각을 설정 후 운동한 정보에 대해 간단하게 기록이 가능합니다.
- 기록한 운동을 선택하면 기록한 순서대로 운동 내역을 볼 수 있습니다.
## 문제 해결을 위한 아이디어 요약
### 프로세스 항목
1. 디자인 목업 생성
2. Flutter 개발 환경 설정
3. API 연동
4. 테스트
5. 배포
### 작업 리스트
- [x] 메인화면에 동영상이 순차로 재생
- [x] 로그인 (password:'12345')
- [x] 로그인이 되지 않은 경우, 운동 기록 하기 및 보기 화면 전환 불가
- [x] 운동 기록 하기
  - 카테고리별 사진 1장 띄우기
  - 운동 일자(default: 현재, 날짜 및 시간 선택 가능)
  - 상태 메시지
- [x] 메인화면에서 페이지 이동 시 이전 화면을 볼 수 있는 뒤로가기 버튼
- [x] 운동 기록 보기 인피티니 스크롤
- [ ] 운동 기록 보기 내림차순
- [ ] 하단의 탭 바 고정
- [ ] 홈 화면이 나올 때 까지 이전 작업 저장
### API 설계
- Mock API 사용: https://mockapi.io
- POST https://64f7dc29824680fd217ee2bb.mockapi.io/api/v1/recordexercisebytype
- GET https://64f7dc29824680fd217ee2bb.mockapi.io/api/v1/recordexercisebytype?type={type}
## 개발 환경
### FE
- Flutter SDK: 3.3.6
- Dart: 2.18.2
### BE
- API 작성 (https://mockapi.io)
### 환경 구성
1. Flutter SDK 설치: https://flutter.dev/docs/get-started/install
2. IDE: VSCode
3. Flutter 플러그인 설치
## 빌드 & 테스트 & 실행
1. 프로젝트 클론: `git clone https://github.com/yongyong-john/manage_exercise_record.git`
2. 의존성 설치: `flutter pub get`
3. Unit 테스트: 'flutter test'
4. 에뮬레이터 실행 or 실제 디바이스 연결
5. 앱 실행: `flutter run`
## 미해결 이슈
- i18n 미적용
- 운동 기록 보기 시 api에 paging 및 불러올 개수 미적용
  - 기록이 많을 수록 불러오는데 시간이 걸림
