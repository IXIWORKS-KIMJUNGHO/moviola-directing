# MOVIOLA Directing

Claude Code나 Codex에서 MOVIOLA 드래프트를 연출하고 편집하는 스킬입니다. MOVIOLA 서버와
같은 연출 규약을 사용하며, 장면·컷·스토리보드·캐릭터·애니매틱 작업을 지원합니다.

## 브라우저 조연출과의 관계

브라우저 조연출과 터미널 조연출은 같은 조연출이 서로 다른 자리에 앉는 구조입니다. 둘은 같은
Directing Rules와 Rule Check를 사용하고, 문맥 확인·도구 선택·확인 요청·완료 보고 규약도
공유합니다.

도구 목록까지 똑같지는 않습니다. 브라우저에서는 MOVIOLA의 모델이 시나리오 작성·샷 추론·비평을
맡지만, 터미널에서는 사용자가 연결한 Claude나 Codex가 그 판단을 직접 수행합니다. 터미널 조연출은
`list_projects` → `list_drafts` → `get_draft_outline` 순서로 브라우저가 자동으로 받는 문맥을
복원한 뒤, `add_scene`·`update_cut` 같은 의미 도구로 결과를 저장합니다. 어느 자리에서 작성하든
저장과 이미지·영상 생성 전에는 서버의 같은 규약 검사를 통과합니다.

## 설치 전에 알아둘 것

MOVIOLA Directing을 쓰려면 다음 두 가지를 처음 한 번만 설정하면 됩니다.

1. **스킬 설치**: Claude Code나 Codex에 MOVIOLA의 연출 규약을 알려 줍니다.
2. **MCP 연결**: 개인 토큰으로 내 MOVIOLA 프로젝트에 접근하게 합니다.

MCP(Model Context Protocol)는 Claude Code나 Codex가 MOVIOLA의 도구를 호출하는 연결
방식입니다. 개인 토큰을 공개 스킬에 넣을 수 없으므로 스킬 설치와 MCP 연결은 분리되어
있습니다.

## Claude Code에서 시작하기

### 1. 개인 토큰 발급

MOVIOLA 웹에서 **설정 → 개인 토큰**으로 이동해 토큰을 발급합니다. `mv_pat_`로 시작하는
토큰 원문은 발급 직후 한 번만 표시됩니다.

### 2. 스킬 설치

```bash
npx skills add IXIWORKS-KIMJUNGHO/moviola-directing \
  --skill moviola-directing \
  --global \
  --agent claude-code \
  --yes
```

### 3. MOVIOLA 연결

발급받은 토큰을 환경 변수로 지정한 다음, 사용자 범위에 MCP 서버를 등록합니다. 사용자
범위로 등록하면 어느 작업 폴더에서 Claude Code를 실행해도 같은 연결을 사용할 수 있습니다.

```bash
export MOVIOLA_PAT="mv_pat_여기에_토큰"

claude mcp add \
  --transport http \
  --scope user \
  moviola https://storyboard-api.fly.dev/mcp \
  --header "Authorization: Bearer $MOVIOLA_PAT"
```

Claude Code는 연결 정보를 사용자 설정에 저장합니다. 개인 토큰이 포함되므로 공용 컴퓨터에서는
사용하지 말고, 토큰이 노출되면 MOVIOLA 설정에서 바로 회수하세요.

연결 상태를 확인합니다.

```bash
claude mcp list
```

이제 Claude Code를 열고 다음처럼 요청할 수 있습니다.

> MOVIOLA에서 작업할 프로젝트와 드래프트를 보여 주고, 내가 고르면 다음 장면을 연출해 줘.

Claude Code 안에서는 `/mcp` 명령으로 MOVIOLA 연결 상태와 도구를 확인할 수 있습니다.
자세한 MCP 설정 규칙은 [Claude Code 공식 문서](https://code.claude.com/docs/en/mcp)를
참고하세요.

## Codex에서 시작하기

### 1. 스킬과 MCP 연결

```bash
npx skills add IXIWORKS-KIMJUNGHO/moviola-directing \
  --skill moviola-directing \
  --global \
  --agent codex \
  --yes

export MOVIOLA_PAT="mv_pat_여기에_토큰"

codex mcp add moviola \
  --url https://storyboard-api.fly.dev/mcp \
  --bearer-token-env-var MOVIOLA_PAT
```

### 2. Codex 플러그인으로 설치

`npx skills` 대신 Codex 플러그인을 설치해도 됩니다. 두 방식을 함께 설치할 필요는 없습니다.
플러그인을 사용해도 개인 토큰을 위한 MCP 연결은 위에서 한 번 등록해야 합니다.

```bash
codex plugin marketplace add IXIWORKS-KIMJUNGHO/moviola-directing --ref main
codex plugin add moviola-directing@ixiworks-moviola
```

## 여러 에이전트에 한 번에 설치하기

Claude Code, Cursor, Codex에 스킬을 한꺼번에 설치하려면 다음 명령을 사용합니다.

```bash
npx skills add IXIWORKS-KIMJUNGHO/moviola-directing \
  --skill moviola-directing \
  --global \
  --agent claude-code --agent cursor --agent codex \
  --yes
```

## 연결이 안 될 때

- `401` 오류가 나오면 토큰이 만료되었거나 회수되었는지 확인합니다.
- Codex에서 새 터미널을 열었다면 `MOVIOLA_PAT` 환경 변수를 다시 설정합니다.
- Claude Code에서는 `claude mcp list` 또는 `/mcp`로 상태를 확인합니다.
- Claude Code 연결을 다시 등록하려면 `claude mcp remove moviola --scope user`를 실행한 뒤
  위의 등록 명령을 다시 실행합니다.

## 작업 원칙

스킬은 프로젝트와 드래프트를 임의로 추측하지 않고 사용자가 직접 고르게 합니다. 조언과
일반 편집은 요청에 따라 진행하지만, 삭제·대규모 구조 변경·재렌더링·유료 이미지 및 영상
생성은 실행 전에 감독의 의사를 확인합니다.

## 저장소 구성

- `skills/moviola-directing`: `npx skills`가 설치하는 생성된 공용 스킬
- `plugins/moviola-directing`: 같은 생성 결과를 포함하는 Codex 플러그인
- `.agents/plugins/marketplace.json`: Codex 마켓플레이스 목록

AI4MOVIOLA가 공통 조연출 작업 매뉴얼, 연출 규약, 스킬·플러그인 메타데이터의 원본입니다.
이 저장소의 두 배포본은 AI4MOVIOLA의 생성기로 재현되므로 직접 수정하지 않습니다. 공개 PR의
검토에서는 두 사본의 바이트 일치와 AI4MOVIOLA 원본 대비 드리프트 검사를 함께 통과해야 합니다.
