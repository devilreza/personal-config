# Avante.nvim AI Integration Setup Guide

This guide will help you set up avante.nvim to integrate AI assistance with your Neovim configuration.

## Installation

The avante.nvim plugin has been added to your Neovim configuration. To complete the setup:

1. **Update your plugins**:
   ```bash
   # Open Neovim and run:
   :Lazy sync
   ```

2. **Build the plugin**:
   The plugin will automatically build when you sync. If you encounter issues, you can manually build it:
   ```bash
   cd ~/.local/share/nvim/lazy/avante.nvim
   make
   ```

## Configuration

### Setting up API Keys

Avante.nvim supports multiple AI providers. By default, it's configured to use Claude (Anthropic). You need to set the appropriate API key based on your chosen provider.

**Available Providers:**
- `claude` - Anthropic's Claude models (default)
- `openai` - OpenAI's GPT models
- `azure` - Azure OpenAI Service
- `copilot` - GitHub Copilot (requires copilot.lua)
- `cohere` - Cohere AI models
- `gemini` - Google's Gemini models

Note: The "cursor" provider mentioned in some documentation refers to using these providers through the Cursor IDE's API proxy, not a standalone provider.

#### For Claude (Default):
Add this to your shell configuration file (`~/.zshrc`, `~/.bashrc`, etc.):
```bash
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
```

To get your Anthropic API key:
1. Go to https://console.anthropic.com/
2. Sign up or log in
3. Navigate to API keys section
4. Create a new API key

#### For OpenAI:
If you prefer to use OpenAI, modify the provider in `tools/neovim/lua/plugins.lua`:

```lua
opts = {
  provider = "openai",  -- Change from "claude" to "openai"
  providers = {
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4-turbo-preview",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 4096,
      },
    },
  },
  -- ... rest of configuration
}
```

Then set your OpenAI API key:
```bash
export OPENAI_API_KEY="your-openai-api-key-here"
```

#### For Other Providers:

**GitHub Copilot:**
```lua
opts = {
  provider = "copilot",
  providers = {
    copilot = {
      endpoint = "https://api.githubcopilot.com",
      model = "gpt-4o-2024-08-06",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
      },
    },
  },
}
```

**Azure OpenAI:**
```lua
opts = {
  provider = "azure",
  providers = {
    azure = {
      endpoint = "https://your-resource.openai.azure.com",
      deployment_id = "your-deployment-id",
      api_version = "2024-05-01-preview",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 4096,
      },
    },
  },
}
```

Set the Azure API key:
```bash
export AZURE_OPENAI_API_KEY="your-azure-api-key-here"
```

## Usage

### Key Bindings

All Avante commands are prefixed with `<leader>a` (Space + a by default):

- **`<leader>aa`** - Ask AI a question (works in normal and visual mode)
- **`<leader>ae`** - Edit code with AI assistance (works in normal and visual mode)
- **`<leader>ac`** - Open AI chat window
- **`<leader>at`** - Toggle Avante window
- **`<leader>af`** - Focus on Avante window
- **`<leader>as`** - Clear current session
- **`<leader>ar`** - Refresh the response
- **`<leader>ai`** - Ask AI to implement something (works in normal and visual mode)
- **`<leader>ad`** - Debug code with AI
- **`<leader>ax`** - Explain code (works in normal and visual mode)

### Common Workflows

1. **Ask about code**:
   - Select code in visual mode
   - Press `<leader>aa`
   - Type your question

2. **Edit code**:
   - Place cursor on code or select in visual mode
   - Press `<leader>ae`
   - Describe the changes you want

3. **Get explanations**:
   - Select complex code
   - Press `<leader>ax`
   - AI will explain what the code does

4. **Debug assistance**:
   - Place cursor on problematic code
   - Press `<leader>ad`
   - AI will help identify issues

### Diff Management

When AI suggests changes, you can navigate and apply them:

- **`]x`** - Next diff
- **`[x`** - Previous diff
- **`co`** - Choose your version (ours)
- **`ct`** - Choose AI's version (theirs)
- **`ca`** - Accept all AI changes
- **`cb`** - Choose both versions
- **`cc`** - Choose cursor position

### Auto-suggestions

Auto-suggestions are disabled by default. To enable them, modify `tools/neovim/lua/plugins.lua`:

```lua
behaviour = {
  auto_suggestions = true,  -- Change from false to true
  -- ... other settings
}
```

With auto-suggestions enabled:
- **`Alt+l`** - Accept suggestion
- **`Alt+]`** - Next suggestion
- **`Alt+[`** - Previous suggestion
- **`Ctrl+]`** - Dismiss suggestion

## Troubleshooting

1. **Plugin not loading**:
   - Run `:Lazy` and check if avante.nvim is installed
   - Run `:checkhealth avante` to diagnose issues

2. **API key not working**:
   - Ensure the environment variable is set: `:echo $ANTHROPIC_API_KEY` (or `$OPENAI_API_KEY` if using OpenAI)
   - Restart Neovim after setting the environment variable

3. **Build errors**:
   - Make sure you have `make` and `curl` installed
   - On macOS: `brew install make curl`
   - On Ubuntu/Debian: `sudo apt-get install make curl`

4. **Performance issues**:
   - Reduce the window width in the configuration
   - Disable auto-suggestions if they're causing lag

## Additional Resources

- [Avante.nvim GitHub Repository](https://github.com/yetone/avante.nvim)
- [Anthropic API Documentation](https://docs.anthropic.com/)
- [OpenAI API Documentation](https://platform.openai.com/docs/)