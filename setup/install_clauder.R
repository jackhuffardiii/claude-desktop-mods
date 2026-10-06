# One-time setup for ClaudeR (RStudio <-> Claude bridge).
# Run in RStudio: source("setup/install_clauder.R")

if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("IMNMV/ClaudeR")

library(ClaudeR)

# Claude Desktop (chat app): writes the r-studio entry into claude_desktop_config.json
install_clauder()

# Claude Code: prints a `claude mcp add ...` command. Not needed if you open
# Claude Code inside this repo, since .mcp.json already registers r-studio.
# install_cli(tools = "claude")

# Each session: start the server, then click "Start Server" in the Viewer pane
# claudeAddin()
