# god_view

**One capability bit from GBT V8, packaged standalone.** No. 260 of 341,
`system` domain (System).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **上帝视角**（主人令 2026-10-09：「上帝视角也是一个超级导航和给你意见和建议也是一种给项目增加的定心丸」）。来历如实：索引里 OpenClaw Monitor → god_view，2026-09-20 盘上 0 命中、只能标 unverified；原先 V8 只有一块**只读总览**（自述「只呈现，不执行」），既不会导航也不会给意见 —— 本轮补成真能力位。四个 op：overview 全局一屏（能力位/域分布/报警/交付闸/今天动作，全现读）· navigate goal=<人话> **超级导航**（意图→域→档 A/B/C 排序，附可直接照抄的命令）· advise 按现读状态给**排好序的意见与建议**（每条带依据，定心丸）· where 一页说清现状与下一步。口径：**只读零作用域**（不起进程/不写盘/不出网）· **不猜**（导航给分与命中词）· **不许反问**（按 ux_doctrine 不开口闸，只给具体候选与命令）。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-god-view.git
cd gbt-god-view
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_god_view info                  # capability card
python -m gbt_god_view spec --json           # machine-readable contract
python -m gbt_god_view check --payload '{}'
python -m gbt_god_view run   --payload '{}'
```

Real `info` output from this machine:

```text
god_view  (system)  v1.0.0
----------------------------------------
**上帝视角**（主人令 2026-10-09：「上帝视角也是一个超级导航和给你意见和建议也是一种给项目增加的定心丸」）。来历如实：索引里 OpenClaw Monitor → god_view，2026-09-20 盘上 0 命中、只能标 unverified；原先 V8 只有一块**只读总览**（自述「只呈现，不执行」），既不会导航也不会给意见 —— 本轮补成真能力位。四个 op：overview 全局一屏（能力位/域分布/报警/交付闸/今天动作，全现读）· navigate goal=<人话> **超级导航**（意图→域→档 A/B/C 排序，附可直接照抄的命令）· advise 按现读状态给**排好序的意见与建议**（每条带依据，定心丸）· where 一页说清现状与下一步。口径：**只读零作用域**（不起进程/不写盘/不出网）· **不猜**（导航给分与命中词）· **不许反问**（按 ux_doctrine 不开口闸，只给具体候选与命令）。

gated      : False
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_god_view import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.14s
```

## Provenance

| field | value |
|---|---|
| capability | `god_view` |
| domain | `system` |
| handler | `god_view` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [system/god_view](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/system/god_view.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
