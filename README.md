기능별 분류

1. module 안에 있는 내용은, 리소스에 대한 내용이 모듈에서 키 값만 넣어서 쉽게 리소스를 구성할 수 있게끔 개발한 내용으로 기능 추가나 코드 변경 같은 작업이 있는 경우, module에서 개발을 하면 됨.
2. root path {{resource}}.tf 내 module "{{resource}}" 각 리소스에 대한 내용, locals 블록안에 키에 대한 파라미터값을 넣어서 생성하도록 만든 파일
3. root path의 {{resource}}.tf 는 반복문을 사용해, locals 블록 안에 명시된 값을 가져와서 생성할 수 있도록 보기 쉽게 만든 파일

사용 방법
root 모듈에 다른 리소스를 만들고 싶다면 locals 블록을 생성한 후, module.{{resource}} 내 에서 for_each 문을 사용해, 필요한 리소스를 생성할 것
