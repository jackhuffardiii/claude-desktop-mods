# claude-desktop-mods

Claude add-ons for R, Shiny and baseball analytics.

| Add-on | What it does | Type |
| --- | --- | --- |
| [claude-rshiny-plugin](https://github.com/tazovsky/claude-rshiny-plugin) | Launch a Shiny app, click through it in a real browser, and watch server logs for errors | Claude Code plugin |
| [ClaudeR](https://github.com/IMNMV/ClaudeR) | Lets Claude run code, see objects and plots, and edit files in your live RStudio session | MCP server (`r-studio`) |
| [mlb-mcp](https://github.com/etweisberg/mlb-mcp) | 46 tools: MLB StatsAPI, Statcast (arsenals, expected stats, percentiles), pybaseball/FanGraphs/B-Ref, strike-zone and spray-chart plots | MCP server (`mlb-stats`) |
| [Playwright MCP](https://github.com/microsoft/playwright-mcp) | Browser control, required by the Shiny plugin | MCP server (`playwright`) |

## Prerequisites

- R with `shiny` and `devtools`
- [uv](https://docs.astral.sh/uv/getting-started/installation/) (`uvx` runs the Python MCP servers with no manual pip installs)
- Node.js (`npx` runs Playwright MCP)

## Claude Code

```
git clone https://github.com/jackhuffardiii/claude-desktop-mods
cd claude-desktop-mods
claude
```

`.mcp.json` registers `r-studio`, `mlb-stats` and `playwright` for this project; approve them when Claude Code asks. To use them in other projects too, add them at user scope, e.g.
`claude mcp add -s user mlb-stats -- uvx --from git+https://github.com/etweisberg/mlb-mcp --with "mcp[cli]<2" python -m mlb_stats_mcp.server`.

Install the Shiny plugin (from any directory):

```
/plugin marketplace add jackhuffardiii/claude-desktop-mods
/plugin install rshiny@claude-desktop-mods
```

Then, from a folder containing `app.R`: `/rshiny-run "open the pitcher tab and pick Skenes"`, `/rshiny-logs`, `/rshiny-status`, `/rshiny-stop` (namespaced form: `/rshiny:rshiny-run`).
The plugin's skills use `bash`, `lsof` and `curl`, so on Windows run Claude Code under WSL or Git Bash.

## Claude Desktop (chat app)

1. In RStudio, run `source("setup/install_clauder.R")`. This installs ClaudeR and adds the `r-studio` server to your Desktop config.
2. Open **Settings → Developer → Edit Config** and merge the `mlb-stats` entry from [`desktop/claude_desktop_config.json`](desktop/claude_desktop_config.json) into `mcpServers`.
3. Restart Claude Desktop.

## Every session with ClaudeR

In RStudio run `ClaudeR::claudeAddin()` and click **Start Server**. Claude can't reach your R session until you do.

## Notes

- `mlb-mcp` is pinned to `mcp<2`: the upstream code uses the v1 `FastMCP` API, which the `mcp` 2.x release removed, and it fails to start without the pin.
- The marketplace lists the Shiny plugin as `rshiny` because Claude Code reserves plugin names that start with `claude-`.
